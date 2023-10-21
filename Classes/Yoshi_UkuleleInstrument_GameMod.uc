class Yoshi_UkuleleInstrument_GameMod extends GameMod
    dependsOn(Yoshi_MusicalInstrument)
    dependsOn(Yoshi_InputPack);

//
// TODO
//
// dyeable ukulele
// new icon
// trailer
// Metronome time???
// more instruments - saxophone, drums, trumpet, maybe more?

var config int RecordingMode; //0 = Playback mode, 1 = Record Layer, 2 = Reset Layers
var config int SongIndex; //You can have up to 25 different songs saved!
var config int KeyboardLayout; //The keyboard layout being used ex. QWERTY, AZERTY, etc.
var config int OnlineNotes; //Should we receive individual notes from online players
var config int OnlineSongs; //Should we receive the emote songs from online players
var config int Instrument; //Which instrument sound should we use?
var config int Scale; //Which kind of scale (major, minor, etc.) should our keys be based off of

var int Octave; //Certain instruments have more than one set of ranges
var int PitchShift;

const OnlineSongNoteLimit = 250; //This limit is due to constraints on the max string length
const MaxSongs = 25;
const MaxRecordingLength = 600; //10 minutes
const SavedSongsPath = "MusicalInstruments/EmoteSong.Song";
const NumWesternNotes = 12;
const SongFormatVersion = 2;

const DelimiterLayer = "&";
const DelimiterInstrument = "=";
const DelimiterNote = "/";
const DelimiterPitch = "|";

struct InstrumentKeyboardLayout {
    var array<Name> Notes;
    var Name OctaveUp;
    var Name OctaveDown;
    var Name PitchUp;
    var Name PitchDown;
};

//One note consists of a certain Pitch and Timestamp
struct SingleNote {
    var string Pitch;
    var float Timestamp;
};

//One layer consists of several notes assigned to a specific instrument
struct SongLayer {
    var string InstrumentName;
    var int LastPlayedNoteIndex;
    var array<SingleNote> Notes;
};

//Holds Song Data + Playback Information
struct SongPlaybackStatus {
    var float Time;
    var Actor Player;
    var array<SongLayer> Layers;
};

//Song format for Yoshi_MusicalSong_Storage
struct SavedSong {
    var array<SongLayer> Layers;
};

struct NoteScale {
    var array<int> NoteOffsets;
};

enum PlayingMode {
    PS_IdleMode, //We are not playing a song or recording anything
    PS_PlaybackMode, //We are playing back our song
    PS_RecordMode //We are recording a layer for our song
};

var Yoshi_InstrumentManager InstrumentManager;

var array< class<Yoshi_MusicalInstrument> > AllInstruments;
var Yoshi_MusicalInstrument CurrentInstrument; //The instrument the player currently has

var SongPlaybackStatus PlayerSong; //Holds the player's saved song
var array<SongPlaybackStatus> OPSongs; //Holds all active Emote Songs being played
var Yoshi_MusicalSong_Storage StoredSongs;

var PlayingMode PlayingState;
var SongLayer RecordLayer;
var int RecordingLayer;

var Yoshi_HUDElement_RecordingMode RecordingHUD;

var InputPack InputPack;
var Hat_Player Player;

var int LastSongIndex; //Saved in case this config value is attempted to be changed mid-song

var array<InstrumentKeyboardLayout> InstrumentKeys;
var array<NoteScale> Scales;
var bool IsHoldingLeftShift;
var bool IsHoldingRightShift;

function Sync(string CommandString, Name CommandChannel, optional Pawn SendingPlayer, optional Hat_GhostPartyPlayerStateBase Receiver) {
    SendOnlinePartyCommand(CommandString, CommandChannel, SendingPlayer, Receiver);
    Print("OPSend:" @ CommandString $ "," @ CommandChannel $ "," @ SendingPlayer $ "," @ Receiver);
}

event OnModLoaded() {
    if(`GameManager.GetCurrentMapFilename() == `GameManager.TitlescreenMapName) return;

    InstrumentManager = new class'Yoshi_InstrumentManager';
    InstrumentManager.GameMod = self;

    LoadSongs();

    LastSongIndex = SongIndex;

    AllInstruments = class'Yoshi_MusicalInstrument'.static.GetAllInstruments();
    AssignPlayerInstrument();

    HookActorSpawn(class'Hat_PlayerController', 'Hat_PlayerController');
    HookActorSpawn(class'Hat_GhostPartyPlayer', 'Hat_GhostPartyPlayer');

    RecordingLayer = PlayerSong.Layers.Length;
}

function OnLoadoutChanged(PlayerController Controller, Object Loadout, Object BackpackItem) {
    local class<Hat_Collectible_Skin> PlayerSkin;

    if(InstrumentManager.Player == None) return;

    PlayerSkin = class<Hat_Collectible_Skin>(Hat_PlayerController(InstrumentManager.Player.Controller).GetLoadout().MyLoadout.Skin.BackpackClass);

    InstrumentManager.UpdateInstrumentColors(InstrumentManager.InstrumentMesh, PlayerSkin);
}

event OnConfigChanged(Name ConfigName) {
    if(ConfigName == 'RecordingMode') {
        if(RecordingMode == 0 && PlayingState != PS_IdleMode) {
            SetPlayingState(PS_IdleMode);
        }

        if(RecordingMode == 1) {
            RecordingLayer = PlayerSong.Layers.Length;
        }
        
        if(RecordingMode == 2) {
            DeleteSong(SongIndex);
            class'GameMod'.static.SaveConfigValue(class'Yoshi_UkuleleInstrument_GameMod', 'RecordingMode', 0);
        }
        
    }

    if(ConfigName == 'Instrument') {
        AssignPlayerInstrument();
    }

    if(ConfigName == 'SongIndex') {
        if(StoredSongs == None) {
            LoadSongs();
        }

        if(PlayingState != PS_IdleMode) {
            if(LastSongIndex == SongIndex) return; //oops no infinite loop pls

            //Do not allow changing the song index while in playback or recording
            class'GameMod'.static.SaveConfigValue(class'Yoshi_UkuleleInstrument_GameMod', 'SongIndex', LastSongIndex);
        }
        else {
            PlayerSong.Layers = StoredSongs.Songs[SongIndex].Layers;

            //Make sure to update the relevant recording layer
            if(RecordingMode == 1) {
                RecordingLayer = PlayerSong.Layers.Length;
            }
        }

        LastSongIndex = SongIndex;
    }
}

function AssignPlayerInstrument() {
    local int i;

    for(i = 0; i < AllInstruments.Length; i++) {
        if(AllInstruments[i].default.InstrumentID == Instrument) {
            CurrentInstrument = new AllInstruments[i];
            ChangeOctave(CurrentInstrument.DefaultOctave);
            ChangePitchShift(0);
            return;
        }
    }

    //We should never get here
    CurrentInstrument = new class'Yoshi_MusicalInstrument_Ukulele';
}

function OnTauntEnd(Pawn p) {
    //InstrumentManager.RemovePlayerInstrument();
}

function OnHookedActorSpawn(Object NewActor, Name Identifier) {
    if(Identifier == 'Hat_PlayerController' && InputPack.PlyCon == None) {
        SetTimer(0.001, false, NameOf(HookPlayerInput), self, Hat_PlayerController(NewActor));
    }

    if(Identifier == 'Hat_GhostPartyPlayer') {
        SetTimer(0.001, false, NameOf(HookOnlinePlayerSpawn), self, Hat_GhostPartyPlayer(NewActor));
    }
}

function HookPlayerInput(Hat_PlayerController PlyCon) {
    class'Yoshi_InputPack'.static.AttachController(ReceivedNativeInputKey, PlyCon, InputPack);
    Player = Hat_Player(PlyCon.Pawn);
    PlayerSong.Player = Player;

    Hat_HUD(PlyCon.MyHUD).OpenHUD(class'Yoshi_HUDElement_DebugMode');
}

function HookOnlinePlayerSpawn(Hat_GhostPartyPlayer GPP) {
    //We haven't seen this player before and we have an instrument, let them know!
    if(InstrumentManager.IsPlayerInstrumentEquipped()) {
        Sync(CurrentInstrument.InstrumentName $ "|true", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument,,GPP.PlayerState);
    }
}

event OnModUnloaded() {
    class'Yoshi_InputPack'.static.DetachController(InputPack);
    Player = None;
}

function SendOnlineSongPackage() {
    local string SongPackage;
    local int i, j, NoteCount;

    NoteCount = GetPlayerSongNoteCount();

    if(OnlineSongs != 0) return;
    if(NoteCount > OnlineSongNoteLimit || NoteCount <= 0) return;

    for(i = 0; i < PlayerSong.Layers.Length; i++) {
        if(i > 0) {
            SongPackage $= DelimiterLayer;
        }

        SongPackage $= PlayerSong.Layers[i].InstrumentName $ DelimiterInstrument;

        for(j = 0; j < PlayerSong.Layers[i].Notes.Length; j++) {
            if(j > 0) {
                SongPackage $= DelimiterNote;
            }

            SongPackage $= PlayerSong.Layers[i].Notes[j].Pitch $ DelimiterPitch $ int(PlayerSong.Layers[i].Notes[j].Timestamp * 1000);
        }
    }

    Sync(SongPackage, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicSong);
}

function SongPlaybackStatus DecodeOnlineSongPackage(string SongPackage, Hat_GhostPartyPlayer GhostPlayer) {
    local SongPlaybackStatus Song;
    local SongLayer NewLayer;
    local SingleNote Note;
    local array<string> SongLayers;
    local array<string> SongInstrumentSplit;
    local array<string> SongNotes;
    local array<string> SongNote;
    local int i, j;

    SongLayers = SplitString(SongPackage, DelimiterLayer);

    if(SongLayers.Length <= 0 || GhostPlayer == None) return Song;

    for(i = 0; i < SongLayers.Length; i++) {
        SongInstrumentSplit = SplitString(SongLayers[i], DelimiterInstrument);
        if(SongInstrumentSplit.Length != 2) continue;

        NewLayer.InstrumentName = SongInstrumentSplit[0];
        SongNotes = SplitString(SongInstrumentSplit[1], DelimiterNote);

        for(j = 0; j < SongNotes.Length; j++) {
            SongNote = SplitString(SongNotes[j], DelimiterPitch);
            if(SongNote.Length != 2) continue;

            Note.Pitch = SongNote[0];
            Note.Timestamp = float(SongNote[1]) / 1000;
            NewLayer.Notes.AddItem(Note);
        }

        Song.Layers.AddItem(NewLayer);
    }

    Song.Player = GhostPlayer;
    return Song;
}

event OnOnlinePartyCommand(string Command, Name CommandChannel, Hat_GhostPartyPlayerStateBase Sender) {
    local Hat_GhostPartyPlayer GhostPlayer;
    local SongPlaybackStatus OPSong;
    local array<string> args;

    GhostPlayer = Hat_GhostPartyPlayer(Sender.GhostActor);
	if (GhostPlayer == None) return;

    Print("OPGet:" @ Command $ "," @ CommandChannel $ "," @ Hat_GhostPartyPlayer(Sender.GhostActor).UserName);

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicNote && OnlineNotes == 0) {
        args = SplitString(Command, "|");
        if(args.Length < 2) return;

        InstrumentManager.AddOPInstrument(GhostPlayer, GetInstrumentClassByName(args[1])); //Just in case
        InstrumentManager.PlayStrumAnim(Hat_GhostPartyPlayer(Sender.GhostActor).SkeletalMeshComponent);
        PlayNote(GhostPlayer, args[0], args[1]);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicSong && OnlineSongs == 0) {
        OPSong = DecodeOnlineSongPackage(Command, GhostPlayer);
        OPSongs.AddItem(OPSong);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument) {
        args = SplitString(Command, "|");
        if(args.Length < 2) return;

        InstrumentManager.AddOPInstrument(Hat_GhostPartyPlayer(Sender.GhostActor), GetInstrumentClassByName(args[0]), bool(args[1]));
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiRemoveInstrument) {
        InstrumentManager.RemoveOPInstrument(Hat_GhostPartyPlayer(Sender.GhostActor));
    }
}

function float GetFurthestSongTimestamp(SongPlaybackStatus Song) {
    local int i;
    local float FurthestTimestamp;

    FurthestTimestamp = 0.0;

    for(i = 0; i < Song.Layers.Length; i++) {
        if(Song.Layers[i].Notes.Length <= 0) continue;

        if(Song.Layers[i].Notes[Song.Layers[i].Notes.Length - 1].Timestamp > FurthestTimestamp) {
            FurthestTimestamp = Song.Layers[i].Notes[Song.Layers[i].Notes.Length - 1].Timestamp;
        }
    }

    return FMax(FurthestTimestamp, 1.5);
}

event Tick(float delta) {
    local Hat_HUD MyHUD;
    local int i;

    if(PlayingState != PS_IdleMode) {
        PlayerSong = TickSong(PlayerSong, delta);

        if(PlayingState == PS_RecordMode && PlayerSong.Time >= MaxRecordingLength) {
            StopRecording();
            SetPlayingState(PS_IdleMode);
        }
        else if(PlayingState == PS_PlaybackMode && PlayerSong.Time >= GetFurthestSongTimestamp(PlayerSong)) {
            SetPlayingState(PS_IdleMode);
        }
    }

    for(i = 0; i < OPSongs.Length; i++) {
        OPSongs[i] = TickSong(OPSongs[i], delta);
        if(OPSongs[i].Time >= GetFurthestSongTimestamp(OPSongs[i])) {
            OPSongs.Remove(i, 1);
            i--;
        }
    }

    if(InputPack.PlyCon == None) return;
    MyHUD = Hat_HUD(InputPack.PlyCon.MyHUD);

    InstrumentManager.PlayerTickInstrument();

    if(RecordingMode == 0 && RecordingHUD != None)  {
        MyHUD.CloseHUD(class'Yoshi_HUDElement_RecordingMode');
        RecordingHUD = None;
    }

    if((RecordingMode == 1 || RecordingMode == 2) && RecordingHUD == None) {
        RecordingHUD = Yoshi_HUDElement_RecordingMode(MyHUD.OpenHUD(class'Yoshi_HUDElement_RecordingMode', string(RecordingMode)));
    }
}

//Updates for the current tick, plays all associated notes, and updates the last played index for each layer
function SongPlaybackStatus TickSong(SongPlaybackStatus Song, float Delta) {
    local int i;

    Song.Time += Delta;

    for(i = 0; i < Song.Layers.Length; i++) {
        while(Song.Layers[i].LastPlayedNoteIndex < Song.Layers[i].Notes.Length && Song.Time >= Song.Layers[i].Notes[Song.Layers[i].LastPlayedNoteIndex].Timestamp) {


            PlayNote(Song.Player, Song.Layers[i].Notes[Song.Layers[i].LastPlayedNoteIndex].Pitch, Song.Layers[i].InstrumentName);
            Song.Layers[i].LastPlayedNoteIndex++;
        }
    }

    return Song;
}

function SetPlayingState(PlayingMode SongState) {
    local int i;
    PlayingState = SongState;
    PlayerSong.Time = 0.0;

    for(i = 0; i < PlayerSong.Layers.Length; i++) {
        PlayerSong.Layers[i].LastPlayedNoteIndex = 0;
    }
}

function int GetPlayerSongNoteCount() {
    local int NoteCount;
    local int i;

    NoteCount = 0;

    for(i = 0; i < PlayerSong.Layers.Length; i++) {
        NoteCount += PlayerSong.Layers[i].Notes.Length;
    }

    if(RecordingMode == 1) {
        NoteCount += RecordLayer.Notes.Length;
    }

    return NoteCount;
}

function PlayPlayerNote(String Note) {
    local SingleNote NotePlayed;

    if(CurrentInstrument != None) {
        if(Player != None) {
            Player.PutAwayWeapon();

            InstrumentManager.AddPlayerInstrument(Player, CurrentInstrument.class);
            InstrumentManager.PlayStrumAnim(Player.Mesh);
        }

        if(OnlineNotes == 0) Sync(Note $ "|" $ CurrentInstrument.InstrumentName, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicNote);

        CurrentInstrument.PlayNote(Player, Note);
    }

    if(RecordingMode == 1) {
        if(PlayingState == PS_PlaybackMode) return; //We're listening back at the moment so NO

        if(PlayingState == PS_IdleMode) {
            StartRecording();
        }

        NotePlayed.Pitch = Note;
        NotePlayed.Timestamp = PlayerSong.Time;

        RecordLayer.Notes.AddItem(NotePlayed);
    }
}

function PlayNote(Actor NotePlayer, string Note, string InstrumentName) {
    local int i;

    if(InputPack.PlyCon.IsPaused()) return; //Don't play notes while paused

    for(i = 0; i < AllInstruments.Length; i++) {
        if(AllInstruments[i].default.InstrumentName == InstrumentName) {
            AllInstruments[i].static.PlayNote(NotePlayer, Note);
        }
    }
}

//Octave min is 2, Octave is 2, new pitch shift -1
//make no change
function ChangePitchShift(int NewPitchShift) {
    local int OldOctave;

    OldOctave = Octave;

    if(NewPitchShift < 0) {
        Octave = FClamp(Octave - 1, CurrentInstrument.MinOctave, CurrentInstrument.MaxOctave);

        if(OldOctave != Octave) {
            NewPitchShift += NumWesternNotes;
        }
        else {
            NewPitchShift = PitchShift;
        }
    }

    if(NewPitchShift >= NumWesternNotes) {
        Octave = FClamp(Octave + 1, CurrentInstrument.MinOctave, CurrentInstrument.MaxOctave);

        if(OldOctave != Octave) {
            NewPitchShift -= NumWesternNotes;
        }
        else {
            NewPitchShift = PitchShift;
        }
    }

    PitchShift = NewPitchShift;
}

function ChangeOctave(int NewOctave) {
    Octave = FClamp(NewOctave, CurrentInstrument.MinOctave, CurrentInstrument.MaxOctave);
}

function SetRecordingLayer(int NewRecordingLayer) {
    if(NewRecordingLayer < 0) {
        NewRecordingLayer = PlayerSong.Layers.Length;
    }

    if(NewRecordingLayer > PlayerSong.Layers.Length) {
        NewRecordingLayer = 0;
    }

    RecordingLayer = NewRecordingLayer;
}

function StartRecording() {
    if(PlayingState != PS_IdleMode) return;

    SetPlayingState(PS_RecordMode);

    if(RecordingLayer < PlayerSong.Layers.Length) {
        PlayerSong.Layers[RecordingLayer].Notes.Length = 0;
    }

    RecordLayer.InstrumentName = CurrentInstrument.InstrumentName;
    RecordLayer.Notes.Length = 0;
}

function StopRecording() {
    local SongLayer NewLayer;

    if(PlayingState != PS_RecordMode) return;

    while(PlayerSong.Layers.Length <= RecordingLayer) {
        PlayerSong.Layers.AddItem(NewLayer);
    }

    PlayerSong.Layers[RecordingLayer] = RecordLayer;
    RecordLayer.Notes.Length = 0;

    SaveSongs(SongIndex);
    class'GameMod'.static.SaveConfigValue(class'Yoshi_UkuleleInstrument_GameMod', 'RecordingMode', 0);

    SetPlayingState(PS_IdleMode);
}

function SaveSongs(optional int SaveSongIndex = -1) {
    if(SaveSongIndex > -1 && SaveSongIndex < MaxSongs) {
        StoredSongs.Songs[SaveSongIndex].Layers = PlayerSong.Layers;
    }
    
    class'Engine'.static.BasicSaveObject(StoredSongs, SavedSongsPath, false, SongFormatVersion);
}

function LoadSongs() {
    if(StoredSongs == None) {
        StoredSongs = new class'Yoshi_MusicalSong_Storage';
    }
    class'Engine'.static.BasicLoadObject(StoredSongs, SavedSongsPath, false, SongFormatVersion);
    PlayerSong.Layers = StoredSongs.Songs[SongIndex].Layers;
}

function DeleteSong(int RemoveSongIndex) {
    PlayerSong.Layers.Length = 0;
    StoredSongs.Songs[RemoveSongIndex].Layers.Length = 0;
    class'Engine'.static.BasicSaveObject(StoredSongs, SavedSongsPath, false, SongFormatVersion);
}

function bool ReceivedNativeInputKey(int ControllerId, name Key, EInputEvent EventType, float AmountDepressed, bool bGamepad) {
    local int i;
    local bool HoldingShiftKey;

    if(InputPack.PlyCon.IsPaused()) return false;

    //Print(`ShowVar(Key) @ `ShowVar(EventType) @ `ShowVar(bGamepad));

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

    if(Key == 'LeftControl' || Key == 'RightControl') {
        if(PlayingState == PS_IdleMode && RecordingMode == 1) {
            StartRecording();
            return true; //Eat thy input
        }
        else if(PlayingState == PS_RecordMode) {
            StopRecording();
            return true; //Eat thy input
        }
    }

    if(Key == 'Hat_Player_Attack') {
        if(PlayingState == PS_PlaybackMode) {
            //Eat the input, we shouldn't be attacking right now
            return true;
        }
        else {
            InstrumentManager.RemovePlayerInstrument();
        }
    }

    HoldingShiftKey = (IsHoldingLeftShift || IsHoldingRightShift);

    if(InstrumentKeys[KeyboardLayout].PitchDown == Key) {
        ChangePitchShift(PitchShift - 1);
    }

    if(InstrumentKeys[KeyboardLayout].PitchUp == Key) {
        ChangePitchShift(PitchShift + 1);
    }

    if(InstrumentKeys[KeyboardLayout].OctaveUp == Key) {
        ChangeOctave(Octave + 1);
    }

    if(InstrumentKeys[KeyboardLayout].OctaveDown == Key) {
        ChangeOctave(Octave - 1);
    }

    for(i = 0; i < InstrumentKeys[KeyboardLayout].Notes.Length; i++) {
        if(InstrumentKeys[KeyboardLayout].Notes[i] == Key && Scale < Scales.Length) {
            PlayPlayerNote(GetNoteName(Scales[Scale].NoteOffsets[i] + (HoldingShiftKey ? -1 : 0) + PitchShift));
        }
    }

    return false;
}

function string GetNoteName(int NoteOffset) {
    local string NoteName;
    local int OctaveOffset;

    OctaveOffset = 0;

    while(NoteOffset < 0) {
        OctaveOffset -= 1;
        NoteOffset += NumWesternNotes;
    }

    while(NoteOffset >= NumWesternNotes) {
        OctaveOffset += 1;
        NoteOffset -= NumWesternNotes;
    }

    switch(NoteOffset) {
        case 0: NoteName = "C"; break;
        case 1: NoteName = "Db"; break;
        case 2: NoteName = "D"; break;
        case 3: NoteName = "Eb"; break;
        case 4: NoteName = "E"; break;
        case 5: NoteName = "F"; break;
        case 6: NoteName = "Gb"; break;
        case 7: NoteName = "G"; break;
        case 8: NoteName = "Ab"; break;
        case 9: NoteName = "A"; break;
        case 10: NoteName = "Bb"; break;
        case 11: NoteName = "B"; break;
    }

    return NoteName $ (Octave + OctaveOffset);
}

function class<Yoshi_MusicalInstrument> GetInstrumentClassByName(string InstrumentName) {
    local int i;

    for(i = 0; i < AllInstruments.Length; i++) {
        if(AllInstruments[i].default.InstrumentName == InstrumentName) {
            return AllInstruments[i];
        }
    }

    return None;
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

static function Print(coerce string msg)
{
    local WorldInfo wi;

	msg = "[Ukulele] " $ msg;

    wi = class'WorldInfo'.static.GetWorldInfo();
    if (wi != None)
    {
        if (wi.GetALocalPlayerController() != None)
            wi.GetALocalPlayerController().TeamMessage(None, msg, 'Event', 6);
        else
            wi.Game.Broadcast(wi, msg);
    }
}

defaultproperties
{
    PlayingState=PS_IdleMode
    Octave=3;

    InstrumentKeys.Add((Notes=("Z","X","C","V","B","N","M","comma","period","slash"),OctaveDown="J",OctaveUp="K",PitchDown="L",PitchUp="semicolon")); //QWERTY
    InstrumentKeys.Add((Notes=("Y","X","C","V","B","N","M","comma","period","underscore"),OctaveDown="J",OctaveUp="K",PitchDown="L",PitchUp="semicolon")); //QWERTZ
    InstrumentKeys.Add((Notes=("W","X","C","V","B","N","comma","period","slash"),OctaveDown="J",OctaveUp="K",PitchDown="L",PitchUp="M")); //AZERTY (Limited to 9 keys as ! does not have any input event)

    Scales.Add((NoteOffsets=(0, 2, 4, 5, 7, 9, 11, 12, 14, 16))); //Major
    Scales.Add((NoteOffsets=(0, 2, 4, 7, 9, 12, 14, 16, 19, 21))); //Major Pentatonic
    Scales.Add((NoteOffsets=(0, 2, 3, 4, 7, 9, 12, 14, 15, 16))); //Major Blues
    Scales.Add((NoteOffsets=(0, 2, 4, 5, 7, 9, 10, 12, 14, 16))); //Mixolydian
    
    Scales.Add((NoteOffsets=(0, 2, 3, 5, 7, 8, 10, 12, 14, 15))); //Minor
    Scales.Add((NoteOffsets=(0, 3, 5, 7, 10, 12, 15, 17, 19, 22))); //Minor Pentatonic
    Scales.Add((NoteOffsets=(0, 3, 5, 6, 7, 10, 12, 15, 17, 18))); //Minor Blues
    Scales.Add((NoteOffsets=(0, 2, 3, 5, 7, 8, 11, 12, 14, 15))); //Harmonic Minor

    Scales.Add((NoteOffsets=(0, 2, 3, 5, 7, 9, 10, 12, 14, 15))); //Dorian
    Scales.Add((NoteOffsets=(0, 1, 4, 5, 7, 8, 10, 12, 13, 16))); //Klezmer
    Scales.Add((NoteOffsets=(0, 1, 5, 7, 8, 12, 13, 17, 19, 20))); //Japanese
    Scales.Add((NoteOffsets=(0, 1, 3, 7, 8, 12, 13, 15, 19, 20))); //South-East Asian
    Scales.Add((NoteOffsets=(0, 2, 4, 6, 8, 10, 12, 14, 16, 18))); //Whole Tone
}