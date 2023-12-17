class Yoshi_Storage_UkuleleSettings extends Object
    dependsOn(Yoshi_KeyManager);

struct UkuleleSettings {
    var int InstrumentIndex;
    var int ScaleIndex;
    var int SongIndex;

    var int MetronomeBPM;
    var int MetronomeBeats;
    var bool MetronomeCountIn;

    var bool TwoRowMode;
    var int CurrentLayoutIndex;
    var InstrumentKeyboardLayout CustomLayout;

    var bool OnlineNotes;
    var bool OnlineSongs;

    var float PlayerVolume;
    var float OnlineVolume;

    structdefaultproperties
    {
        OnlineNotes=true
        OnlineSongs=true
        PlayerVolume=1.0f
        OnlineVolume=0.8f
    }
};

var UkuleleSettings Settings;