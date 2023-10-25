class Yoshi_MusicalInstrument extends Object
    abstract;

struct InstrumentPitchSet {
    var string Name;
    var SoundCue Sound;
};

var const string InstrumentName;
var array<InstrumentPitchSet> Pitches;
var const int InstrumentID; //Corresponds with Configs

var bool CanReleaseNote;

var AnimSet AnimSet;
var SkeletalMesh Mesh;

var int MinOctave;
var int MaxOctave;
var int DefaultOctave;

static function AudioComponent PlayNote(Actor Player, String Note) {
    local int i;
    for(i = 0; i < default.Pitches.Length; i++) {
        if(default.Pitches[i].Name ~= Note) {
            if(Hat_Pawn(Player) != None) {
                return Hat_Pawn(Player).PlayVoice(default.Pitches[i].Sound,,true);
            }
            else {
                return Player.CreateAudioComponent(default.Pitches[i].Sound,true,true);
            }
        }
    }

    return None;
}

static function array< class<Yoshi_MusicalInstrument> > GetAllInstruments() {
    local array< class<Yoshi_MusicalInstrument> > ActualInstruments;
    local array< class<Object> > AllInstruments;
    local int i;
    AllInstruments = class'Hat_ClassHelper'.static.GetAllScriptClasses("Yoshi_MusicalInstrument");
    for(i = 0; i < AllInstruments.Length; i++) {
        if(class<Yoshi_MusicalInstrument>(AllInstruments[i]) != None) {
            ActualInstruments.AddItem(class<Yoshi_MusicalInstrument>(AllInstruments[i]));
        }
    }
    return ActualInstruments;
}

defaultproperties
{
    MinOctave=3
    MaxOctave=3
    DefaultOctave=3

    AnimSet=AnimSet'Ctm_Ukulele.Ukulele_playing'
	Mesh=SkeletalMesh'Ctm_Ukulele.Ukulele'

    CanReleaseNote=false
}