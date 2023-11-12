class Yoshi_Metronome extends Object;

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

function Start() {
    SetBeatLength(BPM, BeatsInMeasure);

    MeasureNumber = 1;
    BeatNumber = 1;
    LastBeat = 0.0;

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

function SetPlayer(Hat_Player ply) {
    Player = ply;
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

function TickMetronome() {
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