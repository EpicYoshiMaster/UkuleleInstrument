class Yoshi_UkuleleInstrument_GameMod extends GameMod
    dependsOn(Yoshi_Storage_UkuleleSettings)
    dependsOn(Yoshi_MusicalInstrument)
    dependsOn(Yoshi_SongManager);

//
// TODO
//

//
// Next Build Requirements:
// 

// Menu :3
// - Tooltips
// - Change Tabs
// - Fix Component Lifetime

// Okay it's time we need to split functionality out of GameMod better to help fix all the other problems
// Fix Coop Issues
// Fix Animation Issues
// Continue work on Instrument Visuals
// Finish building system for releasing notes

//
// To Release And Beyond
//

// We need assets. Please.
// Polish and cleanup to menu and panels
// Solve the 250 notes problem
// trailer

// The Awesome Soundfont Offerings:
// Strings - Harp, Bass
// Brass - French Horn
// Woodwinds - Oboe, Bassoon, Alto Sax, Bari Sax
// Percussion - Steel Drums

// BONUS IDEAS (not required but if there's extra time)
// Woodwinds - Clarinet, Flute
// Brass - Tuba
// Keyboard - More Piano Flavors

// Maybe more random chaotic ones

var int Octave; //Certain instruments have more than one set of ranges
var int PitchShift;

const JammingOutAnimName = "Ukulele_Play";
const NumWesternNotes = 12;

const SettingsPath = "MusicalInstruments/UkuleleSettings.Settings";
const SettingsVersion = 0;

struct NoteScale {
    var string ScaleName;
    var array<int> NoteOffsets;
};

var UkuleleSettings Settings;

var Yoshi_InstrumentManager InstrumentManager;
var Yoshi_KeyManager KeyManager;
var Yoshi_NoteManager NoteManager;
var Yoshi_RecordManager RecordManager;
var Yoshi_SongManager SongManager;
var Yoshi_Metronome Metronome;

var array< class<Yoshi_MusicalInstrument> > AllInstruments;
var class<Yoshi_MusicalInstrument> CurrentInstrument; //The instrument the player currently has

var Yoshi_HUDMenu_MusicMenu MenuHUD;

var array<NoteScale> Scales;

function Sync(string CommandString, Name CommandChannel, optional Pawn SendingPlayer, optional Hat_GhostPartyPlayerStateBase Receiver) {
    SendOnlinePartyCommand(CommandString, CommandChannel, SendingPlayer, Receiver);
    Print("OPSend:" @ CommandString $ "," @ CommandChannel $ "," @ SendingPlayer $ "," @ Receiver);
}

event OnModLoaded() {
    if(`GameManager.GetCurrentMapFilename() == `GameManager.TitlescreenMapName) return;

    LoadSettings();

    InstrumentManager = new class'Yoshi_InstrumentManager';
    KeyManager = new class'Yoshi_KeyManager';
    NoteManager = new class'Yoshi_NoteManager';
    RecordManager = new class'Yoshi_RecordManager';
    SongManager = new class'Yoshi_SongManager';
    Metronome = new class'Yoshi_Metronome';

    InstrumentManager.Init(self);
    KeyManager.Init(self);
    NoteManager.Init(self);
    RecordManager.Init(self);
    SongManager.Init(self);
    Metronome.Init(self);

    AllInstruments = class'Yoshi_MusicalInstrument'.static.GetAllInstruments();
    AssignPlayerInstrument();

    HookActorSpawn(class'Hat_PlayerController', 'Hat_PlayerController');
    HookActorSpawn(class'Hat_GhostPartyPlayer', 'Hat_GhostPartyPlayer');
}

function OnLoadoutChanged(PlayerController Controller, Object Loadout, Object BackpackItem) {
    local class<Hat_Collectible_Skin> PlayerSkin;

    if(InstrumentManager.Player == None) return;

    PlayerSkin = class<Hat_Collectible_Skin>(Hat_PlayerController(InstrumentManager.Player.Controller).GetLoadout().MyLoadout.Skin.BackpackClass);

    InstrumentManager.UpdateInstrumentColors(InstrumentManager.Player, InstrumentManager.InstrumentMesh, PlayerSkin, CurrentInstrument);
}

function AssignPlayerInstrument() {
    local int i;

    for(i = 0; i < AllInstruments.Length; i++) {
        if(AllInstruments[i].default.InstrumentID == Settings.InstrumentIndex) {
            CurrentInstrument = AllInstruments[i];
            ChangeOctave(CurrentInstrument.default.DefaultOctave);
            ChangePitchShift(0);
            return;
        }
    }
}

function OnHookedActorSpawn(Object NewActor, Name Identifier) {
    if(Identifier == 'Hat_GhostPartyPlayer') {
        SetTimer(0.001, false, NameOf(HookOnlinePlayerSpawn), self, Hat_GhostPartyPlayer(NewActor));
    }
}

function HookOnlinePlayerSpawn(Hat_GhostPartyPlayer GPP) {
    //We haven't seen this player before and we have an instrument, let them know!
    if(InstrumentManager.IsPlayerInstrumentEquipped()) {
        Sync(CurrentInstrument.default.InstrumentName $ "|true", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument,,GPP.PlayerState);
    }
}

event OnModUnloaded() {
    KeyManager.Unload();
    Metronome.Stop();

    InstrumentManager = None;
    KeyManager = None;
    NoteManager = None;
    SongManager = None;
    Metronome = None;
}

event OnOnlinePartyCommand(string Command, Name CommandChannel, Hat_GhostPartyPlayerStateBase Sender) {
    local Hat_GhostPartyPlayer GhostPlayer;
    local class<Yoshi_MusicalInstrument> InstrumentClass;
    local array<string> args;

    GhostPlayer = Hat_GhostPartyPlayer(Sender.GhostActor);
	if (GhostPlayer == None) return;

    Print("OPGet:" @ Command $ "," @ CommandChannel $ "," @ Hat_GhostPartyPlayer(Sender.GhostActor).UserName);

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicNote && Settings.OnlineNotes) {
        args = SplitString(Command, "|");
        if(args.Length < 3) return;

        //KeyName|NoteName|InstrumentShortName
        InstrumentClass = GetInstrumentClass(args[2]);

        InstrumentManager.AddOPInstrument(GhostPlayer, InstrumentClass); //Just in case
        InstrumentManager.PlayStrumAnim(Hat_GhostPartyPlayer(Sender.GhostActor).SkeletalMeshComponent);
        NoteManager.PlayNote(GhostPlayer, InstrumentClass, args[0], args[1]);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicSong && Settings.OnlineSongs) {
        SongManager.PlayOnlineSong(Command, GhostPlayer);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument) {
        args = SplitString(Command, "|");
        if(args.Length < 2) return;

        //InstrumentShortName|ForceAnim
        InstrumentManager.AddOPInstrument(Hat_GhostPartyPlayer(Sender.GhostActor), GetInstrumentClass(args[0]), bool(args[1]));
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiRemoveInstrument) {
        InstrumentManager.RemoveOPInstrument(Hat_GhostPartyPlayer(Sender.GhostActor));
    }
}

event Tick(float delta) {
    RecordManager.Tick(delta);
    InstrumentManager.Tick(delta);
    KeyManager.Tick(delta);
    SongManager.Tick(delta);
    Metronome.Tick(delta);
}

//
// Emote Events
//

function OnActivateEmote(Hat_Player Ply) {
    local PlayerTauntInfo PTI;

    if(RecordManager.IsRecording) return;
    if(SongManager.IsPlayingPlayerSong()) return;

    if(Ply.Physics == Phys_Walking) {
        InstrumentManager.AddPlayerInstrument(Ply, CurrentInstrument);

        PTI.TauntDuration = SongManager.GetFurthestSongTimestamp(SongManager.PlayerSong);
        PTI.PlayerCanExit = false;
        //PTI.TauntEndDelegate = OnTauntEnd;

        Ply.Taunt(JammingOutAnimName, PTI);
        Ply.PlayCustomAnimation(Name(JammingOutAnimName), true);
    }

    SongManager.PlayPlayerSong();
    SongManager.SendOnlineSongPackage();
}

//
// Metronome Events
//

function OnCountIn() {
    RecordManager.OnCountIn();
}

//
// Key Manager Events
//

function bool OnPressNoteKey(Hat_Player Ply, int Index, bool HoldingPitchDownKey, string KeyName) {
    local string NoteName;

    NoteName = GetNoteName(Scales[Settings.ScaleIndex].NoteOffsets[Index] + (HoldingPitchDownKey ? -1 : 0) + PitchShift);

    RecordManager.RecordPressNote(Ply, NoteName, KeyName);

    ply.PutAwayWeapon();

    InstrumentManager.AddPlayerInstrument(ply, CurrentInstrument);
    InstrumentManager.PlayStrumAnim(ply.Mesh);

    if(Settings.OnlineNotes) {
        Sync(KeyName $ "|" $ NoteName $ "|" $ CurrentInstrument.default.ShortName, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicNote);
    }

    NoteManager.PlayNote(ply, CurrentInstrument, KeyName, NoteName);

    return false;
}

function bool OnReleaseNoteKey(Hat_Player Ply, int Index, string KeyName) {
    RecordManager.RecordReleaseNote(Ply, KeyName);

    if(CurrentInstrument.default.CanReleaseNote) {
        NoteManager.StopNote(ply, KeyName, CurrentInstrument.default.FadeOutTime);
    }

    return false;
}

function bool OnPressControlRecording(Hat_PlayerController PC) {
    return RecordManager.OnPressControlRecording(PC);
}

function bool OnPressToggleMenu(Hat_PlayerController PC) {
    if(MenuHUD == None) {
        MenuHUD = Yoshi_HUDMenu_MusicMenu(Hat_HUD(PC.MyHUD).OpenHUD(class'Yoshi_HUDMenu_MusicMenu'));
    }
    else {
        Hat_HUD(PC.MyHUD).CloseHUD(class'Yoshi_HUDMenu_MusicMenu');
        MenuHUD = None;
    }

    return false;
}

function bool OnPressPlayerAttack(Hat_PlayerController PC) {
    if(SongManager.IsPlayingPlayerSong()) return true;

    InstrumentManager.RemovePlayerInstrument();

    return false;
}

//Octave min is 2, Octave is 2, new pitch shift -1
//make no change
function ChangePitchShift(int PitchShiftAmount) {
    local int OldOctave;
    local int NewPitchShift;

    NewPitchShift = PitchShift + PitchShiftAmount;

    OldOctave = Octave;

    if(NewPitchShift < 0) {
        Octave = FClamp(Octave - 1, CurrentInstrument.default.MinOctave, CurrentInstrument.default.MaxOctave);

        if(OldOctave != Octave) {
            NewPitchShift += NumWesternNotes;
        }
        else {
            NewPitchShift = PitchShift;
        }
    }

    if(NewPitchShift >= NumWesternNotes) {
        Octave = FClamp(Octave + 1, CurrentInstrument.default.MinOctave, CurrentInstrument.default.MaxOctave);

        if(OldOctave != Octave) {
            NewPitchShift -= NumWesternNotes;
        }
        else {
            NewPitchShift = PitchShift;
        }
    }

    PitchShift = NewPitchShift;
}

function ChangeOctave(int OctaveShiftAmount) {
    local int NewOctave;

    NewOctave = Octave + OctaveShiftAmount;
    Octave = FClamp(NewOctave, CurrentInstrument.default.MinOctave, CurrentInstrument.default.MaxOctave);
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

//
// Settings
//

function SetInstrumentIndex(int NewIndex) {
    Settings.InstrumentIndex = NewIndex;
    AssignPlayerInstrument();
    SaveSettings();
}

function SetScaleIndex(int NewIndex) {
    Settings.ScaleIndex = NewIndex;
    SaveSettings();
}

function SetSongIndex(int NewIndex) {
    //Cannot change while in playback / recording
    if(SongManager.IsPlayingPlayerSong()) return;

    Settings.SongIndex = NewIndex;
    SaveSettings();
}

function SetBPM(int NewValue) {
    Settings.MetronomeBPM = NewValue;
    Metronome.SetBPM(NewValue);

    SaveSettings();
}

function SetBeatsInMeasure(int NewValue) {
    Settings.MetronomeBeats = NewValue;
    Metronome.SetBeatsInMeasure(NewValue);

    SaveSettings();
}

function SetTwoRowMode(bool NewValue) {
    Settings.TwoRowMode = NewValue;
    SaveSettings();
}

function SetCustomLayout(InstrumentKeyboardLayout CustomLayout) {
    Settings.CustomLayout = CustomLayout;
    SaveSettings();
}

function SetKeyboardLayoutIndex(int NewValue) {
    Settings.CurrentLayoutIndex = NewValue;
    SaveSettings();
}

function SetOnlineNotes(bool NewValue) {
    Settings.OnlineNotes = NewValue;
    SaveSettings();
}

function SetOnlineSongs(bool NewValue) {
    Settings.OnlineSongs = NewValue;
    SaveSettings();
}

function LoadSettings() {
    local Yoshi_Storage_UkuleleSettings SettingsStorage;

    SettingsStorage = new class'Yoshi_Storage_UkuleleSettings';

    if(!class'Engine'.static.BasicLoadObject(SettingsStorage, SettingsPath, false, SettingsVersion)) {
        Settings.MetronomeBPM = class'Yoshi_Metronome'.default.BPM;
        Settings.MetronomeBeats = class'Yoshi_Metronome'.default.BeatsInMeasure;
        Settings.CustomLayout = class'Yoshi_KeyManager'.default.CustomLayout;
        return;
    }

    Settings = SettingsStorage.Settings;
}

function SaveSettings() {
    local Yoshi_Storage_UkuleleSettings SettingsStorage;

    SettingsStorage = new class'Yoshi_Storage_UkuleleSettings';

    SettingsStorage.Settings = Settings;

    class'Engine'.static.BasicSaveObject(SettingsStorage, SettingsPath, false, SettingsVersion);    
}

function class<Yoshi_MusicalInstrument> GetInstrumentClass(string InstrumentShortName) {
    local int i;

    for(i = 0; i < AllInstruments.Length; i++) {
        if(AllInstruments[i].default.ShortName ~= InstrumentShortName) {
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
    Scales.Add((ScaleName="Major",NoteOffsets=(0, 2, 4, 5, 7, 9, 11, 12, 14, 16))); //Major
    Scales.Add((ScaleName="Major Pentatonic",NoteOffsets=(0, 2, 4, 7, 9, 12, 14, 16, 19, 21))); //Major Pentatonic
    Scales.Add((ScaleName="Major Blues",NoteOffsets=(0, 2, 3, 4, 7, 9, 12, 14, 15, 16))); //Major Blues
    Scales.Add((ScaleName="Mixolydian",NoteOffsets=(0, 2, 4, 5, 7, 9, 10, 12, 14, 16))); //Mixolydian
    
    Scales.Add((ScaleName="Minor",NoteOffsets=(0, 2, 3, 5, 7, 8, 10, 12, 14, 15))); //Minor
    Scales.Add((ScaleName="Minor Pentatonic",NoteOffsets=(0, 3, 5, 7, 10, 12, 15, 17, 19, 22))); //Minor Pentatonic
    Scales.Add((ScaleName="Minor Blues",NoteOffsets=(0, 3, 5, 6, 7, 10, 12, 15, 17, 18))); //Minor Blues
    Scales.Add((ScaleName="Harmonic Minor",NoteOffsets=(0, 2, 3, 5, 7, 8, 11, 12, 14, 15))); //Harmonic Minor

    Scales.Add((ScaleName="Dorian",NoteOffsets=(0, 2, 3, 5, 7, 9, 10, 12, 14, 15))); //Dorian
    Scales.Add((ScaleName="Klezmer",NoteOffsets=(0, 1, 4, 5, 7, 8, 10, 12, 13, 16))); //Klezmer
    Scales.Add((ScaleName="Japanese",NoteOffsets=(0, 1, 5, 7, 8, 12, 13, 17, 19, 20))); //Japanese
    Scales.Add((ScaleName="South-East Asian",NoteOffsets=(0, 1, 3, 7, 8, 12, 13, 15, 19, 20))); //South-East Asian
    Scales.Add((ScaleName="Whole Tone",NoteOffsets=(0, 2, 4, 6, 8, 10, 12, 14, 16, 18))); //Whole Tone
}