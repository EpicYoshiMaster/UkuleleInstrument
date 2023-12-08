class Yoshi_Metronome extends Object;

var Yoshi_UkuleleInstrument_GameMod GameMod;

var Hat_Player Player;

var SoundCue BigBeat;
var SoundCue SmallBeat;

var float LastBeat;
var int MeasureNumber;
var int BeatNumber;

var float BeatLength;
var float BPM;
var float BeatsInMeasure;

var float SongPosition;
var float SongStartTime;

var bool bUpdating;
var bool DidCountIn;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod) {
    GameMod = MyGameMod;
}

function Start(Hat_Player MyPlayer) {
    SetBeatLength(BPM, BeatsInMeasure);

    Player = MyPlayer;

    MeasureNumber = 1;
    BeatNumber = 1;
    LastBeat = 0.0;

    if(GameMod.Settings.MetronomeCountIn) {
        DidCountIn = false;
    }
    else {
        DidCountIn = true;
    }

    SongStartTime = class'WorldInfo'.static.GetWorldInfo().AudioTimeSeconds;

    PlayBeatSound(true);

    bUpdating = true;
}

function Stop() {
    bUpdating = false;
}

function bool IsUpdating() {
    return bUpdating;
}

function SetBPM(float NewBPM) {
    SetBeatLength(NewBPM, BeatsInMeasure);
}

function SetBeatsInMeasure(float NewBeatsInMeasure) {
    SetBeatLength(BPM, NewBeatsInMeasure);
}

function SetBeatLength(float NewBPM, float NewBeatsInMeasure) {
    BPM = NewBPM;
    BeatsInMeasure = NewBeatsInMeasure;

    BeatLength = (60 / BPM);
}

function Tick(float delta) {
    local bool DidBeat;

    if(!bUpdating) return;

    SongPosition = ((class'WorldInfo'.static.GetWorldInfo().AudioTimeSeconds - SongStartTime));

    DidBeat = false;

    while(SongPosition > LastBeat + BeatLength) {
        LastBeat += BeatLength;
        BeatNumber++;

        DidBeat = true;

        while(BeatNumber >= BeatsInMeasure + 1) {
            MeasureNumber++;
            BeatNumber -= BeatsInMeasure;
        }
    }

    if(!DidCountIn && MeasureNumber > 1) {
        DidCountIn = true;
        GameMod.OnCountIn(Player);
    }

    if(DidBeat) {
        PlayBeatSound(BeatNumber <= 1);
    }
}

function PlayBeatSound(bool isBig) {
    if(Player == None) return;
    if(Hat_PlayerController(Player.Controller).IsPaused()) return;

    if(isBig && BigBeat != None) {
        Player.PlaySound(BigBeat);
    }
    else if(SmallBeat != None) {
        Player.PlaySound(SmallBeat);
    }
}

defaultproperties 
{
    BeatsInMeasure=4.0;
    BPM=120;

    BigBeat=SoundCue'Yoshi_MusicalUkulele_Content.MetronomeSoundCues.Perc_MetronomeQuartz_hi';
    SmallBeat=SoundCue'Yoshi_MusicalUkulele_Content.MetronomeSoundCues.Perc_MetronomeQuartz_lo';
}