class Yoshi_InstrumentSettings_Storage extends Object;

enum KeyboardLayoutType {
    Keyboard_Custom,
    Keyboard_QWERTY,
    Keyboard_QWERTZ,
    Keyboard_AZERTY
};

struct InstrumentSettings {
    var int InstrumentIndex;
    var int ScaleIndex;
    var int SongIndex;

    var int MetronomeBPM;
    var int MetronomeBeats;

    var bool UseShiftless;
    var KeyboardLayoutType KeyboardLayout;
    var InstrumentKeyboardLayout CustomKeys;
};

var InstrumentSettings Settings;