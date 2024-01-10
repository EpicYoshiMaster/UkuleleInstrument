class Yoshi_UkuleleInstrument_GameMod extends GameMod
    dependsOn(Yoshi_Storage_UkuleleSettings)
    dependsOn(Yoshi_MusicalInstrument)
    dependsOn(Yoshi_SongManager);

//
// To Release And Beyond
//

// Menu :3
// - Suitable Temporary Materials/Icons
// - Tooltips

//Rework Keybinds Menu to be a Vertical Submenu (probably)

//Make Piano Display Dynamic And Actually Do Stuff
//Show Always, Show On Change, Show Never

// Volume Settings
// We need assets. Please.
// Text Inputs
// Polish and cleanup to menu and panels
// trailer
// Fix No Instrument -> Play Song -> Instrument Anim Post Song
// Find thy coop menu bugs

// Remaining Instruments:
// ???

// Piano, Honky-Tonk Piano, Synth Lead

// Ukulele, Acoustic Guitar, Electric Guitar

// Violin, Harp, Cello

// Clarinet, Bassoon, Oboe, Recorder, Bari Sax, Tenor Sax, Pan Flute, Alto Sax

// Steel Drums, Drum Set, Marimba, Glockenspiel

// Trumpet, Euphonium, French Horn, Tuba

// Accordion

// Theremin, Pulse Wave, Triangle Wave


var int Octave; //Certain instruments have more than one set of ranges
var int PitchShift;
var int StepShift;

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

var bool DebugMode;

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
    AllInstruments.Sort(SortInstruments);
    AssignPlayerInstrument();

    HookActorSpawn(class'Hat_GhostPartyPlayer', 'Hat_GhostPartyPlayer');
}

delegate int SortInstruments(class<Yoshi_MusicalInstrument> InstrumentA, class<Yoshi_MusicalInstrument> InstrumentB) {
    return InstrumentA.default.InstrumentID <= InstrumentB.default.InstrumentID ? 0 : -1;
}

function class<Hat_Collectible_Skin> GetCurrentSkin(Hat_PlayerController PC) {
    return class<Hat_Collectible_Skin>(PC.GetLoadout().MyLoadout.Skin.BackpackClass);
}

function OnLoadoutChanged(PlayerController Controller, Object Loadout, Object BackpackItem) {
    if(Hat_PlayerController(Controller) != KeyManager.GetPC()) return;

    if(InstrumentManager.PlayerEquipped) {
        InstrumentManager.UpdateInstrument(Controller.Pawn, Controller.Pawn.Mesh, CurrentInstrument, GetCurrentSkin(Hat_PlayerController(Controller)));
    }
}

function AssignPlayerInstrument() {
    local int i;
    local Hat_Player Player;

    for(i = 0; i < AllInstruments.Length; i++) {
        if(AllInstruments[i].default.InstrumentID == Settings.InstrumentIndex) {
            Player = KeyManager.GetPlayer();

            if(Player != None) {
                //Don't allow notes from other instruments to continue when we switch
                NoteManager.StopAllNotes(Player, CurrentInstrument.default.FadeOutTime);

                Sync(CurrentInstrument.default.ShortName, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiStopNote);
            }

            CurrentInstrument = AllInstruments[i];
            Octave = CurrentInstrument.default.DefaultOctave;
            PitchShift = 0;
            StepShift = 0;

            if(InstrumentManager.PlayerEquipped) {
                InstrumentManager.UpdateInstrument(Player, Player.Mesh, CurrentInstrument, GetCurrentSkin(Hat_PlayerController(Player.Controller)));
            }

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
    if(InstrumentManager.PlayerEquipped) {
        Sync(CurrentInstrument.default.ShortName $ "|true", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument,,GPP.PlayerState);
    }
}

event OnModUnloaded() {
    
    if(MenuHUD != None) {
        Hat_HUD(Hat_PlayerController(class'Hat_PlayerController'.static.GetPlayer1()).MyHUD).CloseHUD(class'Yoshi_HUDMenu_MusicMenu', true);
        MenuHUD = None;
    }

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

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiPlayNote && Settings.OnlineNotes) {
        args = SplitString(Command, "|");
        if(args.Length < 3) return;

        //KeyName|NoteName|InstrumentShortName
        InstrumentClass = GetInstrumentClass(args[2]);

        InstrumentManager.AddInstrument(GhostPlayer, GhostPlayer.SkeletalMeshComponent, InstrumentClass, GhostPlayer.CurrentSkin); //Just in case
        InstrumentManager.PlayStrumAnim(GhostPlayer.SkeletalMeshComponent);
        NoteManager.PlayNote(GhostPlayer, InstrumentClass, args[0], args[1]);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiStopNote && Settings.OnlineNotes) {
        args = SplitString(Command, "|");

        if(args.Length == 1) {
            //InstrumentShortName
            InstrumentClass = GetInstrumentClass(args[0]);
            
            NoteManager.StopAllNotes(GhostPlayer, InstrumentClass.default.FadeOutTime);
            return;
        }

        //KeyName|InstrumentShortName
        InstrumentClass = GetInstrumentClass(args[1]);

        NoteManager.StopNote(GhostPlayer, args[0], InstrumentClass.default.FadeOutTime);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicSong && Settings.OnlineSongs) {
        SongManager.ReceiveSongFragment(Command, GhostPlayer);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument) {
        args = SplitString(Command, "|");
        if(args.Length < 2) return;

        //InstrumentShortName|ForceAnim
        InstrumentManager.AddInstrument(GhostPlayer, GhostPlayer.SkeletalMeshComponent, GetInstrumentClass(args[0]), GhostPlayer.CurrentSkin, bool(args[1]));
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiUpdateInstrument) {
        //InstrumentShortName
        InstrumentManager.UpdateInstrument(GhostPlayer, GhostPlayer.SkeletalMeshComponent, GetInstrumentClass(Command), GhostPlayer.CurrentSkin);
    }

    if(CommandChannel == class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiRemoveInstrument) {
        InstrumentManager.RemoveInstrument(GhostPlayer, GhostPlayer.SkeletalMeshComponent);
    }
}

event Tick(float delta) {
    if(RecordManager != None) {
        RecordManager.Tick(delta);
    }

    if(InstrumentManager != None) {
        InstrumentManager.Tick(delta);
    }
    
    if(KeyManager != None) {
        KeyManager.Tick(delta);
    }
    
    if(NoteManager != None) {
        NoteManager.Tick(delta);
    }
    
    if(SongManager != None) {
        SongManager.Tick(delta);
    }


    if(Metronome != None) {
        Metronome.Tick(delta);
    }
}

//
// Emote Events
//

function OnActivateEmote(Hat_Player Ply) {
    local PlayerTauntInfo PTI;

    if(RecordManager.IsRecording) return;
    if(SongManager.IsPlayingPlayerSong()) return;

    if(Ply.Physics == Phys_Walking) {
        InstrumentManager.AddInstrument(Ply, Ply.Mesh, CurrentInstrument, GetCurrentSkin(Hat_PlayerController(Ply.Controller)));

        PTI.TauntDuration = SongManager.GetFurthestSongTimestamp(SongManager.PlayerSong);
        PTI.PlayerCanExit = false;
        //PTI.TauntEndDelegate = OnTauntEnd;

        Ply.Taunt(JammingOutAnimName, PTI);
        Ply.PlayCustomAnimation(Name(JammingOutAnimName), true);
    }

    SongManager.PlayPlayerSong(Ply);
    SongManager.SendOnlineSongPackage();
}

//
// Metronome Events
//

function OnCountIn(Hat_Player Ply) {
    RecordManager.OnCountIn(Ply);
}

//
// Key Manager Events
//
function OnAssignPlayerController(Hat_PlayerController PC) {
    if(MenuHUD == None) {
        MenuHUD = Yoshi_HUDMenu_MusicMenu(Hat_HUD(PC.MyHUD).OpenHUD(class'Yoshi_HUDMenu_MusicMenu'));
    }
}

function bool OnPressNoteKey(Hat_Player Ply, int Index, bool HoldingPitchDownKey, string KeyName) {
    local string NoteName;

    NoteName = GetNote(Index, HoldingPitchDownKey);

    RecordManager.RecordPressNote(Ply, NoteName, KeyName);

    ply.PutAwayWeapon();

    InstrumentManager.AddInstrument(ply, ply.Mesh, CurrentInstrument, GetCurrentSkin(Hat_PlayerController(Ply.Controller)));
    InstrumentManager.PlayStrumAnim(ply.Mesh);

    if(Settings.OnlineNotes) {
        Sync(KeyName $ "|" $ NoteName $ "|" $ CurrentInstrument.default.ShortName, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiPlayNote);
    }

    NoteManager.PlayNote(ply, CurrentInstrument, KeyName, NoteName);

    return false;
}

function bool OnReleaseNoteKey(Hat_Player Ply, int Index, string KeyName) {
    RecordManager.RecordReleaseNote(Ply, KeyName);

    if(CurrentInstrument.default.CanReleaseNote) {
        NoteManager.StopNote(ply, KeyName, CurrentInstrument.default.FadeOutTime);

        if(Settings.OnlineNotes) {
            Sync(KeyName $ "|" $ CurrentInstrument.default.ShortName, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiStopNote);
        }
    }

    return false;
}

function bool OnPressControlRecording(Hat_PlayerController PC) {
    return RecordManager.OnPressControlRecording(PC);
}

function bool OnPressToggleMenu(Hat_PlayerController PC) {
    if(MenuHUD == None) return false;

    MenuHUD.SetEnabled(PC.MyHUD, !MenuHUD.IsEnabled());

    return false;
}

function bool OnPressPlayerAttack(Hat_PlayerController PC) {
    if(SongManager.IsPlayingPlayerSong()) return true;
    if(MenuHUD.IsEnabled()) return false;

    InstrumentManager.RemoveInstrument(PC.Pawn, PC.Pawn.Mesh);

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
        ChangeOctave(-1);

        if(OldOctave != Octave) {
            NewPitchShift += NumWesternNotes;
        }
        else {
            NewPitchShift = PitchShift;
        }
    }

    if(NewPitchShift >= NumWesternNotes) {
        ChangeOctave(1);

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

function ChangeStepShift(int StepShiftAmount) {
    local int OldOctave, NewStepShift;

    NewStepShift = StepShift + StepShiftAmount;

    OldOctave = Octave;

    if(NewStepShift < 0) {
        ChangeOctave(-1);

        if(OldOctave != Octave) {
            NewStepShift += Scales[Settings.ScaleIndex].NoteOffsets.Length;
        }
        else {
            NewStepShift = StepShift;
        }
    }
    else if(NewStepShift >= Scales[Settings.ScaleIndex].NoteOffsets.Length) {
        ChangeOctave(1);

        if(OldOctave != Octave) {
            NewStepShift -= Scales[Settings.ScaleIndex].NoteOffsets.Length;
        }
        else {
            NewStepShift = StepShift;
        }
    }

    StepShift = NewStepShift;
}

function string GetNote(int KeyIndex, bool HoldingPitchDownKey) {
    local int FinalNoteOffset;
    local int OffsetIndex;
    local int OctaveOffset;

    OffsetIndex = (KeyIndex + StepShift);
    OctaveOffset = 0;

    while(OffsetIndex >= Scales[Settings.ScaleIndex].NoteOffsets.Length) {
        OffsetIndex -= Scales[Settings.ScaleIndex].NoteOffsets.Length;
        OctaveOffset += 1;
    }

    FinalNoteOffset = (OctaveOffset * NumWesternNotes) + Scales[Settings.ScaleIndex].NoteOffsets[OffsetIndex] + (HoldingPitchDownKey ? -1 : 0) + PitchShift;

    return GetNoteName(FinalNoteOffset, Octave);
}

static function string GetNoteName(int NoteOffset, int CurrentOctave) {
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

    return NoteName $ (CurrentOctave + OctaveOffset);
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

    SongManager.SetSongIndex(NewIndex);
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
        Settings.OnlineNotes = true;
        Settings.OnlineSongs = true;
        Settings.PlayerVolume = 1.0f;
        Settings.OnlineVolume = 0.8f;
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
    DebugMode=true

    Scales.Add((ScaleName="Major",NoteOffsets=(0, 2, 4, 5, 7, 9, 11))); //Major
    Scales.Add((ScaleName="Major Pentatonic",NoteOffsets=(0, 2, 4, 7, 9))); //Major Pentatonic
    Scales.Add((ScaleName="Major Blues",NoteOffsets=(0, 2, 3, 4, 7, 9))); //Major Blues
    Scales.Add((ScaleName="Mixolydian",NoteOffsets=(0, 2, 4, 5, 7, 9, 10))); //Mixolydian
    
    Scales.Add((ScaleName="Minor",NoteOffsets=(0, 2, 3, 5, 7, 8, 10))); //Minor
    Scales.Add((ScaleName="Minor Pentatonic",NoteOffsets=(0, 3, 5, 7, 10))); //Minor Pentatonic
    Scales.Add((ScaleName="Minor Blues",NoteOffsets=(0, 3, 5, 6, 7, 10))); //Minor Blues
    Scales.Add((ScaleName="Harmonic Minor",NoteOffsets=(0, 2, 3, 5, 7, 8, 11))); //Harmonic Minor

    Scales.Add((ScaleName="Dorian",NoteOffsets=(0, 2, 3, 5, 7, 9, 10))); //Dorian
    Scales.Add((ScaleName="Klezmer",NoteOffsets=(0, 1, 4, 5, 7, 8, 10))); //Klezmer
    Scales.Add((ScaleName="Japanese",NoteOffsets=(0, 1, 5, 7, 8))); //Japanese
    Scales.Add((ScaleName="South-East Asian",NoteOffsets=(0, 1, 3, 7, 8))); //South-East Asian
    Scales.Add((ScaleName="Whole Tone",NoteOffsets=(0, 2, 4, 6, 8, 10))); //Whole Tone
}