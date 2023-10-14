class Yoshi_UkuleleInstrument_GameMod extends GameMod
    dependsOn(Yoshi_MusicalInstrument);

var config int RecordingMode; //We can record a song and play it back as an emote!
var config int OnlineNotes; //Should we receive individual notes from online players
var config int OnlineSongs; //Should we receive the emote songs from online players
//var config int Instrument; 
//0 = Playback mode, 1 = Track 1 Recording, 2 = Track 2 Recording

const MaxRecordingTime = 30.0;
const OnlineSongNoteLimit = 250; //This limit is due to constraints on the max string length

struct SingleNote {
    var string Pitch;
    var float Timestamp;
};

struct MusicalSong {
    var int InstrumentID; //only used in Online Party songs
    var array<SingleNote> Layer1;
    var array<SingleNote> Layer2;
};

struct OnlineMusicalSong {
    var float EmoteTimePassed;
    var int LastPlayedNoteIndexLayer1;
    var int LastPlayedNoteIndexLayer2;
    var Hat_GhostPartyPlayer GPP;
    var MusicalSong EmoteSong;
};

struct ActiveUkulele {
    var Hat_GhostPartyPlayer GPP;
    var SkeletalMeshComponent Ukulele;
    var bool isActive;
};

var Yoshi_MusicalInstrument CurrentInstrument; //Updates on config change but not relevant yet

var MusicalSong SavedSong; //Holds the player's saved song
var array<OnlineMusicalSong> OPSongs; //Holds all active Emote Songs being played
var array<ActiveUkulele> OPUkuleles; //Ensures we know what mesh goes with who and all that stuff
var Yoshi_MusicalSong_Storage StoredSong; //Serialized Song Class
var int isPlayingSong; //-1 for not playing, 0 for all layers, 1 or 2 for specific layer of playback
var float TimePassed; //Time since the first note of recording began
var int LastPlayedNoteIndexLayer1; //Helps track where we are when doing song playback
var int LastPlayedNoteIndexLayer2;
var Yoshi_HUDElement_RecordingMode RecordingHUD;

var Interaction KeyCaptureInteraction;
var Hat_PlayerController PC;
var bool IsHoldingLeftShift;
var bool IsHoldingRightShift;

event OnModLoaded() {
    LoadSong();
    if(`GameManager.GetCurrentMapFilename() == `GameManager.TitlescreenMapName) return;
    CurrentInstrument = class'Yoshi_MusicalInstrument'.static.ReturnByID(0);
    HookActorSpawn(class'Hat_PlayerController', 'Hat_PlayerController');
    HookActorSpawn(class'Hat_GhostPartyPlayer', 'Hat_GhostPartyPlayer');
}

event OnConfigChanged(Name ConfigName) {
    if(ConfigName == 'RecordingMode') {

        if(RecordingMode == 0 && GetPlayingSong() > 0) {
            SetPlayingSong(-1);
        }
        
        if(RecordingMode == 3) {
            DeleteSong();
            class'GameMod'.static.SaveConfigValue(class'Yoshi_UkuleleInstrument_GameMod', 'RecordingMode', 0);
        }
        
    }
}

function OnHookedActorSpawn(Object NewActor, Name Identifier) {
    if(Identifier == 'Hat_PlayerController' && PC == None) {
        AttachPlayer(Hat_PlayerController(NewActor));
    }

    if(Identifier == 'Hat_GhostPartyPlayer') {
        Hat_GhostPartyPlayer(NewActor).SkeletalMeshComponent.AnimSets.AddItem(AnimSet'Ctm_Ukulele.Ukulele_playing');
        Hat_GhostPartyPlayer(NewActor).SkeletalMeshComponent.UpdateAnimations();
        if(PC != None || Hat_Player(PC.Pawn).HasStatusEffect(class'Yoshi_StatusEffect_Ukulele')) {
            SendOnlinePartyCommand("ThisDoesntMatter", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddUkulele,,Hat_GhostPartyPlayerBase(NewActor).PlayerState);
        }
    }
}

event OnModUnloaded() {
    DetachPlayer();
}

function PrepareOnlineSongPackage() {
    local string SongPackage;
    local int i;

    if(GetSongNoteCount() > OnlineSongNoteLimit) return;
    if(OnlineSongs != 0 || (SavedSong.Layer1.Length == 0 && SavedSong.Layer2.Length == 0)) return;

    SongPackage $= CurrentInstrument.default.InstrumentID $ "+";
    for(i = 0; i < SavedSong.Layer1.Length; i++) {
        SongPackage $= SavedSong.Layer1[i].Pitch $ "|" $ int(SavedSong.Layer1[i].Timestamp * 1000) $ "/";
    }
    SongPackage $= "+";
    for(i = 0; i < SavedSong.Layer2.Length; i++) {
        SongPackage $= SavedSong.Layer2[i].Pitch $ "|" $ int(SavedSong.Layer2[i].Timestamp * 1000) $ "/";
    }

    SendOnlinePartyCommand(SongPackage, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicSong);
}

function OnlineMusicalSong DecodeOnlineSongPackage(string SongPackage, Hat_GhostPartyPlayer GhostPlayer) {
    local OnlineMusicalSong PreparedSong;
    local MusicalSong ReceivedSong;
    local SingleNote ReceivedNote;
    local array<string> OuterLayer;
    local array<string> SongLayer;
    local array<string> NoteLayer;
    local int i;

    OuterLayer = SplitString(SongPackage, "+");
    if(OuterLayer.Length >= 3 && GhostPlayer != None) {
        ReceivedSong.InstrumentID = int(OuterLayer[0]);
        SongLayer = SplitString(OuterLayer[1], "/");
        for(i = 0; i < SongLayer.Length; i++) {
            NoteLayer = SplitString(SongLayer[i], "|");
            if(NoteLayer.Length == 2) {
                ReceivedNote.Pitch = NoteLayer[0];
                ReceivedNote.Timestamp = float(NoteLayer[1]) / 1000;
                ReceivedSong.Layer1.AddItem(ReceivedNote);
            }
        }
        SongLayer = SplitString(OuterLayer[2], "/");
        for(i = 0; i < SongLayer.Length; i++) {
            NoteLayer = SplitString(SongLayer[i], "|");
            if(NoteLayer.Length == 2) {
                ReceivedNote.Pitch = NoteLayer[0];
                ReceivedNote.Timestamp = float(NoteLayer[1]) / 1000;
                ReceivedSong.Layer2.AddItem(ReceivedNote);
            }
        }
        PreparedSong.EmoteSong = ReceivedSong;
        PreparedSong.GPP = GhostPlayer;
    }

    //Print("Decoded Song with a Layer 1 of " $ ReceivedSong.Layer1.Length $ " notes and a Layer 2 of " $ ReceivedSong.Layer2.Length $ " notes!");
    return PreparedSong;
}

event OnOnlinePartyCommand(string Command, Name CommandChannel, Hat_GhostPartyPlayerStateBase Sender) {
    local Hat_GhostPartyPlayer GhostPlayer;
    local OnlineMusicalSong OPSong;
    GhostPlayer = Hat_GhostPartyPlayer(Sender.GhostActor);
	if (GhostPlayer == None) return;

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicNote && OnlineNotes == 0) {
        PlayOnlineStrumAnim(Hat_GhostPartyPlayer(Sender.GhostActor), true);
        class'Yoshi_MusicalInstrument_Ukulele'.static.PlayOnlineNote(GhostPlayer, Command);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicSong && OnlineSongs == 0) {
        OPSong = DecodeOnlineSongPackage(Command, GhostPlayer);
        OPSongs.AddItem(OPSong);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddUkulele) {
        AddOPUkulele(Hat_GhostPartyPlayer(Sender.GhostActor));
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiRemoveUkulele) {
        RemoveOPUkulele(Hat_GhostPartyPlayer(Sender.GhostActor));
    }
}

function AddOPUkulele(Hat_GhostPartyPlayer GPP) {
    local int i;
    local ActiveUkulele NewUser;
    local SkeletalMeshComponent UkuleleMesh;

    if (GPP.SkeletalMeshComponent.AnimSets.Find(AnimSet'Ctm_Ukulele.Ukulele_playing') == INDEX_NONE) {
        GPP.SkeletalMeshComponent.AnimSets.AddItem(AnimSet'Ctm_Ukulele.Ukulele_playing');
        GPP.SkeletalMeshComponent.UpdateAnimations();
    }

    for(i = 0; i < OPUkuleles.Length; i++) {
        //This player already has a Ukulele but it needs to be attached again
        if(OPUkuleles[i].GPP == GPP && OPUkuleles[i].Ukulele != None && !OPUkuleles[i].isActive) {
            GPP.SkeletalMeshComponent.AttachComponentToSocket(OPUkuleles[i].Ukulele, 'Umbrella');
            OPUkuleles[i].isActive = true;
            return;
        } 
    }

    NewUser.GPP = GPP;
    UkuleleMesh = new class'SkeletalMeshComponent';
    UkuleleMesh.SetSkeletalMesh(class'Yoshi_StatusEffect_Ukulele'.default.instrumentMesh);
    UkuleleMesh.SetLightEnvironment(GPP.SkeletalMeshComponent.LightEnvironment);
    GPP.SkeletalMeshComponent.AttachComponentToSocket(UkuleleMesh, 'Umbrella');
    NewUser.Ukulele = UkuleleMesh;
    NewUser.isActive = true;
    OPUkuleles.AddItem(NewUser);
}

function RemoveOPUkulele(Hat_GhostPartyPlayer GPP) {
    local int i;
    for(i = 0; i < OPUkuleles.Length; i++) {
        if(OPUkuleles[i].GPP == GPP && OPUkuleles[i].isActive) {
            OPUkuleles[i].isActive = false;
            if(OPUkuleles[i].Ukulele != None) {
                GPP.SkeletalMeshComponent.DetachComponent(OPUkuleles[i].Ukulele);
            }
        }
    }
}

function PlayOnlineStrumAnim(Hat_GhostPartyPlayer GPP, optional bool play = true) {
	local AnimNodeBlendBase anim;
	if (GPP == None) return;

    if (GPP.SkeletalMeshComponent.AnimSets.Find(AnimSet'Ctm_Ukulele.Ukulele_playing') == INDEX_NONE) {
        GPP.SkeletalMeshComponent.AnimSets.AddItem(AnimSet'Ctm_Ukulele.Ukulele_playing');
        GPP.SkeletalMeshComponent.UpdateAnimations();
    }

	anim = AnimNodeBlend(GPP.SkeletalMeshComponent.FindAnimNode('TicketScan'));
	if (anim != None)
	{
		AnimNodeBlend(anim).SetBlendTarget(play ? 1 : 0, play ? 0.3f : 0.0f); // Need blend time of 0 when removing, otherwise the real TicketScan anim is visible for a few frames. Sharp blend looks kinda bad though.
		if (play) anim.Children[1].Anim.PlayAnim(false, 2.0, 0.0); // Using a rate of 2.0 because original animation is slightly too slow.
	}
}

function float GetFurthestSongTimestamp() {
    local float Timestamp;
    Timestamp = GetFurthestSongTimestampForLayer1();
    Timestamp = GetFurthestSongTimeStampForLayer2() > Timestamp ? GetFurthestSongTimeStampForLayer2() : Timestamp;

    return FClamp(Timestamp, 1.5, MaxRecordingTime);
}

function float GetFurthestSongTimestampForLayer1() {
    if(SavedSong.Layer1.Length > 0) {
        return SavedSong.Layer1[SavedSong.Layer1.Length - 1].Timestamp;
    }
    return 0.0;
}

function float GetFurthestSongTimestampForLayer2() {
    if(SavedSong.Layer2.Length > 0) {
        return SavedSong.Layer2[SavedSong.Layer2.Length - 1].Timestamp;
    }
    return 0.0;
}

event Tick(float delta) {
    local Hat_HUD MyHUD;
    local int i;

    if(isPlayingSong > -1) {
        TimePassed += delta;
        TickSong();
        if(TimePassed >= MaxRecordingTime || (TimePassed >= GetFurthestSongTimestamp() && isPlayingSong == 0)) {
            if(isPlayingSong > 0) {
                SaveSong();
                class'GameMod'.static.SaveConfigValue(class'Yoshi_UkuleleInstrument_GameMod', 'RecordingMode', 0);
            }
            SetPlayingSong(-1);
        }    
    }

    for(i = 0; i < OPSongs.Length; i++) {
        OPSongs[i].EmoteTimePassed += delta;
        OPSongs[i] = TickOnlineSong(OPSongs[i]);
        if(OPSongs[i].EmoteTimePassed >= MaxRecordingTime) {
            OPSongs.Remove(i, 1);
            i--;
        }
    }


    if(PC == None) return;
    MyHUD = Hat_HUD(PC.MyHUD);

    if(RecordingMode == 0 && RecordingHUD != None)  {
        MyHUD.CloseHUD(class'Yoshi_HUDElement_RecordingMode');
        RecordingHUD = None;
    }

    if((RecordingMode == 1 || RecordingMode == 2) && RecordingHUD == None) {
        RecordingHUD = Yoshi_HUDElement_RecordingMode(MyHUD.OpenHUD(class'Yoshi_HUDElement_RecordingMode', string(RecordingMode)));
    }
}

function TickSong() {
    local int i;

    if(isPlayingSong == 0 || isPlayingSong == 2) {
        for(i = LastPlayedNoteIndexLayer1; i < SavedSong.Layer1.Length; i++) {
            if(TimePassed >= SavedSong.Layer1[i].TimeStamp) {
                CurrentInstrument.PlayNote(PC, SavedSong.Layer1[i].Pitch);
                LastPlayedNoteIndexLayer1++;
            }
        }
    }

    if(isPlayingSong == 0 || isPlayingSong == 1) {
        for(i = LastPlayedNoteIndexLayer2; i < SavedSong.Layer2.Length; i++) {
            if(TimePassed >= SavedSong.Layer2[i].TimeStamp) {
                CurrentInstrument.PlayNote(PC, SavedSong.Layer2[i].Pitch);
                LastPlayedNoteIndexLayer2++;
            }
        }
    }
    
}

function OnlineMusicalSong TickOnlineSong(OnlineMusicalSong OMS) {
    local int i;
    for(i = OMS.LastPlayedNoteIndexLayer1; i < OMS.EmoteSong.Layer1.Length; i++) {
        if(OMS.EmoteTimePassed >= OMS.EmoteSong.Layer1[i].TimeStamp) {
            class'Yoshi_MusicalInstrument_Ukulele'.static.PlayOnlineNote(OMS.GPP, OMS.EmoteSong.Layer1[i].Pitch);
            OMS.LastPlayedNoteIndexLayer1++;
        }
    }

    for(i = OMS.LastPlayedNoteIndexLayer2; i < OMS.EmoteSong.Layer2.Length; i++) {
        if(OMS.EmoteTimePassed >= OMS.EmoteSong.Layer2[i].TimeStamp) {
            class'Yoshi_MusicalInstrument_Ukulele'.static.PlayOnlineNote(OMS.GPP, OMS.EmoteSong.Layer2[i].Pitch);
            OMS.LastPlayedNoteIndexLayer2++;
        }
    }

    return OMS;
}


function SetPlayingSong(int SongStatus) {
    isPlayingSong = SongStatus;
    TimePassed = 0.0;
    LastPlayedNoteIndexLayer1 = 0;
    LastPlayedNoteIndexLayer2 = 0;
}

function int GetPlayingSong() {
    return isPlayingSong;
}

function int GetSongNoteCount() {
    return SavedSong.Layer1.Length + SavedSong.Layer2.Length;
}

function PlayNote(String Note) {
    local SingleNote NotePlayed;
    local Yoshi_StatusEffect_Ukulele statusUkulele;

    if(CurrentInstrument != None) {
        if(OnlineNotes == 0) SendOnlinePartyCommand(Note, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicNote);

        CurrentInstrument.PlayNote(PC, Note);

        statusUkulele = Yoshi_StatusEffect_Ukulele(Hat_Player(PC.Pawn).GiveStatusEffect(class'Yoshi_StatusEffect_Ukulele'));
        statusUkulele.PlayStrumAnim();
    }

    if(RecordingMode > 0 && RecordingMode < 3) {
        if(isPlayingSong == 0) return; //We're listening back at the moment so NO

        if(isPlayingSong == -1) {
            //Print("Recording for Layer " $ RecordingMode);
            SetPlayingSong(RecordingMode);
            if(RecordingMode == 1) SavedSong.Layer1.Length = 0;
            if(RecordingMode == 2) SavedSong.Layer2.Length = 0;

        }
        NotePlayed.Pitch = Note;
        NotePlayed.Timestamp = TimePassed;

        if(RecordingMode == 1) SavedSong.Layer1.AddItem(NotePlayed);
        if(RecordingMode == 2) SavedSong.Layer2.AddItem(NotePlayed);
    }
}

function SaveSong() {
    StoredSong.Song = SavedSong;
    //Print("Saved Song with a Layer 1 of " $ SavedSong.Layer1.Length $ " notes and a Layer 2 of " $ SavedSong.Layer2.Length $ " notes!");
    class'Engine'.static.BasicSaveObject(StoredSong, "MusicalInstruments/EmoteSong.Song", false, 1);
}

function LoadSong() {
    if(StoredSong == None) {
        StoredSong = new class'Yoshi_MusicalSong_Storage';
    }
    class'Engine'.static.BasicLoadObject(StoredSong, "MusicalInstruments/EmoteSong.Song", false, 1);
    SavedSong = StoredSong.Song;
}

function DeleteSong() {
    SavedSong.Layer1.Length = 0;
    SavedSong.Layer2.Length = 0;
    StoredSong.Song = SavedSong;
    class'Engine'.static.BasicSaveObject(StoredSong, "MusicalInstruments/EmoteSong.Song", false, 1);
}
/*
function ChangeUkuleleRotation(string Direction, optional bool Negative) {
    local Yoshi_StatusEffect_Ukulele statusUkulele;
    local Rotator NewOffset;

    statusUkulele = Yoshi_StatusEffect_Ukulele(Hat_Player(PC.Pawn).GetStatusEffect(class'Yoshi_StatusEffect_Ukulele'));
    if(statusUkulele != None) {
        switch(Direction) {
            case "Pitch": NewOffset.Pitch = 4096; break;
            case "Yaw": NewOffset.Yaw = 4096; break;
            case "Roll": NewOffset.Roll = 4096; break;
        }
        
        if(Negative) NewOffset *= -1;

        NewOffset = statusUkulele.SetUkeRot(NewOffset);

        //Print("Ukelele Rotation is: Pitch " $ NewOffset.Pitch $ " Yaw " $ NewOffset.Yaw $ " Roll " $ NewOffset.Roll);
    }
}

function ChangeUkuleleLocation(string Direction, optional bool Negative) {
    local Yoshi_StatusEffect_Ukulele statusUkulele;
    local Vector NewOffset;

    statusUkulele = Yoshi_StatusEffect_Ukulele(Hat_Player(PC.Pawn).GetStatusEffect(class'Yoshi_StatusEffect_Ukulele'));
    if(statusUkulele != None) {
        switch(Direction) {
            case "X": NewOffset.X = 1; break;
            case "Y": NewOffset.Y = 1; break;
            case "Z": NewOffset.Z = 1; break;
        }

        if(Negative) NewOffset *= -1;

        NewOffset = statusUkulele.SetUkeLot(NewOffset);

        //Print("Ukelele Location is: X " $ NewOffset.X $ " Y " $ NewOffset.Y $ " Z " $ NewOffset.Z);
    }
}*/

//This will insert our key capture interaction into the playercontroller
function AttachPlayer(Hat_PlayerController player)
{
    local int iInput;
    PC = player;
    KeyCaptureInteraction = new(PC) class'Interaction';
    //Set the functions for received keys and axis data to our own
    KeyCaptureInteraction.OnReceivedNativeInputKey = ReceivedNativeInputKey;
    KeyCaptureInteraction.OnReceivedNativeInputAxis = ReceivedNativeInputAxis;
 
    iInput = PC.Interactions.Find(PC.PlayerInput);
    PC.Interactions.InsertItem(Max(iInput, 0), KeyCaptureInteraction);
}
 
function DetachPlayer()
{
    PC.Interactions.RemoveItem(KeyCaptureInteraction);
    KeyCaptureInteraction = none;
    PC = none;
}

//IE_Pressed, IE_Released, IE_Repeat, IE_DoubleClick, IE_Axis
//Return true to stop the keypress from getting further (like to the player pawn, effectively "eating" the input), return false for not.
function bool ReceivedNativeInputKey(int ControllerId, name Key, EInputEvent EventType, float AmountDepressed, bool bGamepad)
{
    local bool HoldingShiftKey;

    if(Key == 'Hat_Player_Attack' && EventType == IE_Pressed && isPlayingSong == 0) {
        return true;
    }

    if (Key == 'LeftShift' || (!bGamepad && Key == 'Hat_Player_Ability'))
	{
		if (EventType == IE_Released) IsHoldingLeftShift = false;
		else if (EventType == IE_Repeat && !IsHoldingLeftShift) IsHoldingLeftShift = true;
	}
	else if (Key == 'RightShift')
	{
		if (EventType == IE_Released) IsHoldingRightShift = false;
		else if (EventType == IE_Repeat && !IsHoldingRightShift) IsHoldingRightShift = true;
	}

    if(EventType != IE_Pressed) return false;

    HoldingShiftKey = (IsHoldingLeftShift || IsHoldingRightShift);

    switch(Key)
    {
        //case 'T': ChangeUkuleleLocation("X"); break; //ChangeUkuleleRotation("Pitch"); break;
        //case 'Y': ChangeUkuleleLocation("Y"); break;//ChangeUkuleleRotation("Yaw"); break;
        //case 'U': ChangeUkuleleLocation("Z"); break;//ChangeUkuleleRotation("Roll"); break;
        //case 'G': ChangeUkuleleLocation("X", true); break;//ChangeUkuleleRotation("Pitch", true); break;
        //case 'H': ChangeUkuleleLocation("Y", true); break;//ChangeUkuleleRotation("Yaw", true); break;
        //case 'J': ChangeUkuleleLocation("Z", true); break;//ChangeUkuleleRotation("Roll", true); break;

        case 'Z': PlayNote("C3"); break;
        case 'X': PlayNote(HoldingShiftKey ? "Db3" : "D3"); break;
        case 'C': PlayNote(HoldingShiftKey ? "Eb3" : "E3"); break;
        case 'V': PlayNote(HoldingShiftKey ? "E3" : "F3"); break;
        case 'B': PlayNote(HoldingShiftKey ? "Gb3" : "G3"); break;
        case 'N': PlayNote(HoldingShiftKey ? "Ab3" : "A3"); break;
        case 'M': PlayNote(HoldingShiftKey ? "Bb3" : "B3"); break;
        case 'comma': PlayNote(HoldingShiftKey ? "B3" : "C4"); break;
        case 'period': PlayNote(HoldingShiftKey ? "Db4" : "D4"); break;
        case 'Slash': PlayNote(HoldingShiftKey ? "Eb4" : "E4"); break;
    }
    return false;
}
 
function bool ReceivedNativeInputAxis( int ControllerId, name Key, float Delta, float DeltaTime, optional bool bGamepad )
{
 
    if(Key == 'Hat_Player_MoveX')
    {
        //Delta is left stick/WASD X axis from -1.0 to 1.0
    }
    else if(Key == 'Hat_Player_MoveY')
    {
        //Delta is left stick/WASD Y axis from -1.0 to 1.0
    }
    else if(Key == 'Hat_Player_LookX')
    {
        //Delta is right stick/mouse X axis from -1.0 to 1.0
    }
    else if(Key == 'Hat_Player_LookY')
    {
        //Delta is right stick/mouse Y axis from -1.0 to 1.0
    }
    return false;
}

static function Yoshi_UkuleleInstrument_GameMod GetGameMod() {
    local Yoshi_UkuleleInstrument_GameMod GM;
    foreach class'WorldInfo'.static.GetWorldInfo().DynamicActors(class'Yoshi_UkuleleInstrument_GameMod', GM) {
        if(GM != None) {
            return GM;
        }
    }
    return GM;
}

static function Print(string s)
{
	//class'WorldInfo'.static.GetWorldInfo().Game.Broadcast(class'WorldInfo'.static.GetWorldInfo(), s);
}

defaultproperties
{
    isPlayingSong=-1;
}