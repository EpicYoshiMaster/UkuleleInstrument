class Yoshi_MusicalInstrument extends Object
    abstract;

struct InstrumentPitchSet {
    var string Name;
    var SoundCue Sound;
};

var const string InstrumentName;
var array<InstrumentPitchSet> Pitches;
var const int InstrumentID; //Corresponds with Configs

function PlayNote(Hat_PlayerController PC, String Note) {
    local int i;
    for(i = 0; i < Pitches.Length; i++) {
        if(Pitches[i].Name ~= Note) {
            Hat_Pawn(PC.Pawn).PlayVoice(Pitches[i].Sound,,true);
            return;
        }
    }
}

static function PlayOnlineNote(Hat_GhostPartyPlayer GhostPlayer, String Note) {
    local int i;
    for(i = 0; i < default.Pitches.Length; i++) {
        if(default.Pitches[i].Name ~= Note) {
            GhostPlayer.PlaySound(default.Pitches[i].Sound,,true);
            return;
        }
    }   
}

static function Yoshi_MusicalInstrument ReturnByID(int ID) {
    local int i;
    local array< class<Object> > AllInstruments;
    local Yoshi_MusicalInstrument YMI;
    AllInstruments = GetAllInstruments();

    for(i = 0; i < AllInstruments.Length; i++) {
        if(class<Yoshi_MusicalInstrument>(AllInstruments[i]).default.InstrumentID == ID) {
            YMI = new class<Yoshi_MusicalInstrument>(AllInstruments[i]);
        }
    }
    return YMI;
}

static function array< class<Object> > GetAllInstruments() {
    local array< class<Object> > AllInstruments;
    AllInstruments = class'Hat_ClassHelper'.static.GetAllScriptClasses("Yoshi_MusicalInstrument");
    return AllInstruments;
}