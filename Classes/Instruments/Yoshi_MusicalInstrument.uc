class Yoshi_MusicalInstrument extends Object
    dependsOn(Yoshi_NoteManager)
    abstract;

struct InstrumentPitchSet {
    var string Name;
    var SoundCue Sound;
};

var const string InstrumentName;
var const string ShortName;
var array<InstrumentPitchSet> Pitches;
var const int InstrumentID; //Corresponds with Configs

var bool CanReleaseNote;
var float FadeOutTime;

var Texture2D Icon;
var bool ShouldUseParticle;

var int MinOctave;
var int MaxOctave;
var int DefaultOctave;

static function AudioComponent PlayNote(Actor Player, String Note, SoundSettings Settings) {
    local int i;
    local AudioComponent Component;
    local SoundCue InstrumentSound;

    //Don't play sounds while paused
    if(class'WorldInfo'.static.GetWorldInfo().Pauser != None) return None;

    i = default.Pitches.Find('Name', Note);

    if(i == INDEX_NONE) return None;

    InstrumentSound = default.Pitches[i].Sound;

    if(SoundNodeAttenuation(InstrumentSound.FirstNode) != None) {
        SoundNodeAttenuation(InstrumentSound.FirstNode).DistanceAlgorithm = Settings.DistanceAlgorithm;
    }

    Component = Player.CreateAudioComponent(InstrumentSound,true,true);

    if(Component != None) {
        Component.bAutoDestroy = true;
    }

    return Component;
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
    FadeOutTime=0.15

    Icon=Texture2D'HatInTime_Hud_Loadout.Loadout.backpack_icon'

    CanReleaseNote=false
    ShouldUseParticle=true
}