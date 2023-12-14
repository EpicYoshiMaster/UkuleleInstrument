class Yoshi_RecordManager extends Object
    dependsOn(Yoshi_SongManager);

const MaxRecordingLength = 600; //10 minutes

var Yoshi_UkuleleInstrument_GameMod GameMod;
var Yoshi_SongManager SongManager;
var Yoshi_Metronome Metronome;

var Yoshi_HUDElement_RecordingMode RecordingHUD; //idk if I'll keep this here

var SongLayer RecordLayer;
var int RecordingSongIndex;
var int RecordingLayer;

var bool InRecordingMode;
var bool AwaitingCountIn;
var bool IsRecording;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod) {
    GameMod = MyGameMod;
    SongManager = GameMod.SongManager;
    Metronome = GameMod.Metronome;
}

//
// Events
//

function RecordPressNote(Hat_Player Ply, string NoteName, string KeyName) {
    local SingleNote NotePlayed;

    if(!InRecordingMode) return;
    if(AwaitingCountIn) return;

    if(!IsRecording) {
        if(GameMod.Settings.MetronomeCountIn) {
            Metronome.Start(Ply);
            AwaitingCountIn = true;
            return;
        }
        else {
            StartRecording(Ply);
        }
    }

    if(IsRecording) {
        NotePlayed.Pitch = NoteName;
        NotePlayed.Timestamp = SongManager.PlayerSong.Time;
        NotePlayed.KeyName = KeyName;

        RecordLayer.Notes.AddItem(NotePlayed);
    }
}

function RecordReleaseNote(Hat_Player Ply, string KeyName) {
    local int i;

    if(!InRecordingMode) return;
    if(AwaitingCountIn) return;
    if(!IsRecording) return;
    if(!RecordLayer.Instrument.default.CanReleaseNote) return;

    //Search backwards to find the most recent associated key
    for(i = RecordLayer.Notes.Length - 1; i >= 0; i--) {
        if(RecordLayer.Notes[i].KeyName ~= KeyName) {
            RecordLayer.Notes[i].Hold = true;
            RecordLayer.Notes[i].Duration = FMax(SongManager.PlayerSong.Time - RecordLayer.Notes[i].Timestamp, 0.0);
            return;
        }
    }
}

function bool OnPressControlRecording(Hat_PlayerController PC) {
    if(IsRecording) {
        StopRecording();

        return true;
    }
    else if(InRecordingMode) {
        if(GameMod.Settings.MetronomeCountIn) {
            Metronome.Start(Hat_Player(PC.Pawn));
            AwaitingCountIn = true;
        }
        else {
            StartRecording(Hat_Player(PC.Pawn));
        }

        return true;
    }

    return false;
}

function OnCountIn(Hat_Player Ply) {
    if(InRecordingMode && !IsRecording && AwaitingCountIn) {
        AwaitingCountIn = false;
        StartRecording(Ply);
    }
}

function SetRecordingMode(bool NewValue) {
    if(IsRecording) return;

    InRecordingMode = NewValue;
}

//
// All Me :D
//

function SetRecordingLayer(int NewRecordingLayer) {
    if(NewRecordingLayer < 0) {
        NewRecordingLayer = SongManager.PlayerSong.Layers.Length;
    }

    if(NewRecordingLayer > SongManager.PlayerSong.Layers.Length) {
        NewRecordingLayer = 0;
    }

    RecordingLayer = NewRecordingLayer;
}

function StartRecording(Hat_Player Ply) {
    if(GameMod.SongManager.IsPlayingPlayerSong() || AwaitingCountIn || IsRecording) return;

    IsRecording = true;

    RecordingSongIndex = GameMod.Settings.SongIndex;

    RecordLayer.Instrument = GameMod.CurrentInstrument;
    RecordLayer.LastPlayedNoteIndex = 0;
    RecordLayer.Notes.Length = 0;

    SongManager.PlayPlayerSong(Ply, RecordingLayer);
}

function StopRecording() {
    if(!IsRecording) return;

    SongManager.StopPlayerSong();

    SongManager.SaveRecordedLayer(RecordLayer, RecordingLayer, RecordingSongIndex);

    IsRecording = false;
    InRecordingMode = false;

    if(Metronome.IsUpdating()) {
        Metronome.Stop();
    }
}

function Tick(float delta) {
    local Hat_PlayerController PC;

    if(IsRecording && SongManager.IsPlayingPlayerSong()) {
        if(SongManager.PlayerSong.Time >= MaxRecordingLength) {
            StopRecording();
        }
    }

    PC = GameMod.KeyManager.GetPC();

    if(!InRecordingMode && RecordingHUD != None) {
        Hat_HUD(PC.MyHUD).CloseHUD(class'Yoshi_HUDElement_RecordingMode');
        RecordingHUD = None;
    }
    else if(InRecordingMode && RecordingHUD == None) {
        RecordingHUD = Yoshi_HUDElement_RecordingMode(Hat_HUD(PC.MyHUD).OpenHUD(class'Yoshi_HUDElement_RecordingMode'));
        RecordingHUD.Init(GameMod);
    }
}

function GetDebugStrings(out array<string> PrintStrings) {
    local string s;

    PrintStrings.AddItem("Recording Mode:" @ InRecordingMode $ ", Await Count In:" @ AwaitingCountIn $ ", Recording:" @ IsRecording);
    PrintStrings.AddItem("Record Song Index:" @ RecordingSongIndex $ ", Recording Layer:" @ RecordingLayer);

    s = "Record Layer:" @ RecordLayer.Instrument;
    s $= "," @ RecordLayer.Notes.Length @ "Notes";

    PrintStrings.AddItem(s);
}