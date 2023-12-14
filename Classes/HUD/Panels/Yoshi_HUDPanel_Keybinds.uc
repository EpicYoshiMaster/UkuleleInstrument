class Yoshi_HUDPanel_Keybinds extends Yoshi_HUDPanel
    dependsOn(Yoshi_KeyManager);

var Yoshi_KeyManager KeyManager;

var Yoshi_HUDComponent_Toggle TwoRow;
var Yoshi_HUDComponent_DropDown KeyboardLayout;

var Yoshi_HUDComponent_KeybindList KeyList;
var Yoshi_HUDComponent_KeybindList FlatKeyList;

var Yoshi_HUDComponent_KeybindListText MenuKeyList;
var Yoshi_HUDComponent_KeybindListText EndRecordingKeyList;
var Yoshi_HUDComponent_KeybindListText ShiftKeyList;

var Yoshi_HUDComponent_KeybindListText OctaveKeyList;
var Yoshi_HUDComponent_KeybindListText PitchKeyList;
var Yoshi_HUDComponent_KeybindListText StepKeyList;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    KeyManager = MyGameMod.KeyManager;

    TwoRow.GetValue = GetTwoRowMode;
    TwoRow.SetValue = MyGameMod.SetTwoRowMode;
    
    KeyboardLayout.GetOptions = GetKeyboardLayoutOptions;
    KeyboardLayout.GetValue = GetKeyboardLayoutIndex;
    KeyboardLayout.SetValue = MyGameMod.SetKeyboardLayoutIndex;

    KeyList.GetValue = GetKeyValues;
    //KeyList.SetValue = SetKeyValues;

    FlatKeyList.GetValue = GetFlatKeyValues;
    //FlatKeyList.SetValue = SetFlatKeyValues;

    MenuKeyList.GetValue = GetMenuKeyValues;
    ///MenuKeyList.SetValue = SetMenuKeyValues;

    EndRecordingKeyList.GetValue = GetEndRecordingKeyValues;

    ShiftKeyList.GetValue = GetShiftKeyValues;
    //ShiftKeyList.SetValue = SetShiftKeyValues;

    OctaveKeyList.GetValue = GetOctaveKeyValues;
    //OctaveKeyList.SetValue = SetOctaveKeyValues;

    PitchKeyList.GetValue = GetPitchKeyValues;
    //PitchKeyList.SetValue = SetPitchKeyValues;

    StepKeyList.GetValue = GetStepKeyValues;
    //StepKeyList.SetValue = SetStepKeyValues;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function bool GetTwoRowMode() {
    return GameMod.Settings.TwoRowMode;
}

function array<string> GetKeyboardLayoutOptions() {
    local array<InstrumentKeyboardLayout> AllLayouts;
    local array<string> Options;
    local int i;

    AllLayouts = KeyManager.GetAllLayouts();

    for(i = 0; i < AllLayouts.Length; i++) {
        Options.AddItem(AllLayouts[i].LayoutName);
    }

    return Options;
}

function int GetKeyboardLayoutIndex() {
    return GameMod.Settings.CurrentLayoutIndex;
}

function array<string> GetKeyValues() {
    return KeyManager.GetCurrentLayout().Notes;
}

function SetKeyValues(array<string> NewValues) {

}

function array<string> GetFlatKeyValues() {
    return KeyManager.GetCurrentLayout().FlatNotes;
}

function SetFlatKeyValues(array<string> NewValues) {

}

function array<string> GetMenuKeyValues() {
    local array<string> Keys;

    Keys.AddItem(KeyManager.GetCurrentLayout().ToggleMenu);
    
    return Keys;
}

function array<string> GetEndRecordingKeyValues() {
    local array<string> Keys;

    Keys.AddItem(KeyManager.GetCurrentLayout().ControlRecording);
    
    return Keys;
}

function array<string> GetShiftKeyValues() {
    local array<string> Keys;

    Keys.AddItem(KeyManager.GetCurrentLayout().HoldPitchDown);
    
    return Keys;
}

function array<string> GetOctaveKeyValues() {
    local array<string> ModKeys;
    local array<string> Keys;

    ModKeys = KeyManager.GetCurrentLayout().Modifiers;

    Keys.AddItem(ModKeys[class'Yoshi_KeyManager'.const.OctaveDown]);
    Keys.AddItem(ModKeys[class'Yoshi_KeyManager'.const.OctaveUp]);
    
    return Keys;
}

function array<string> GetPitchKeyValues() {
    local array<string> ModKeys;
    local array<string> Keys;

    ModKeys = KeyManager.GetCurrentLayout().Modifiers;

    Keys.AddItem(ModKeys[class'Yoshi_KeyManager'.const.PitchDown]);
    Keys.AddItem(ModKeys[class'Yoshi_KeyManager'.const.PitchUp]);
    
    return Keys;
}

function array<string> GetStepKeyValues() {
    local array<string> ModKeys;
    local array<string> Keys;

    ModKeys = KeyManager.GetCurrentLayout().Modifiers;

    Keys.AddItem(ModKeys[class'Yoshi_KeyManager'.const.StepDown]);
    Keys.AddItem(ModKeys[class'Yoshi_KeyManager'.const.StepUp]);
    
    return Keys;
}

defaultproperties
{
    Title="Keybinds"

    Begin Object Class=Yoshi_HUDComponent_KeybindListText Name=MenuKeybind
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.13333
        ScaleY=0.275
        Text="Toggle Menu"
    End Object
    MenuKeyList=MenuKeybind
    Components.Add(MenuKeybind);

    Begin Object Class=Yoshi_HUDComponent_KeybindListText Name=EndRecordingKeybind
        TopLeftX=0.13333
        TopLeftY=0.0
        ScaleX=0.13333
        ScaleY=0.275
        Text="End Recording"
    End Object
    EndRecordingKeyList=EndRecordingKeybind
    Components.Add(EndRecordingKeybind);

    Begin Object Class=Yoshi_HUDComponent_KeybindListText Name=ShiftKeybind
        TopLeftX=0.26666
        TopLeftY=0.0
        ScaleX=0.13333
        ScaleY=0.275
        Text="Hold Pitch Down"
    End Object
    ShiftKeyList=ShiftKeybind
    Components.Add(ShiftKeybind);

    Begin Object Class=Yoshi_HUDComponent_KeybindListText Name=OctaveKeybind
        TopLeftX=0.4
        TopLeftY=0.0
        ScaleX=0.2
        ScaleY=0.275
        Text="Octave Down/Up"
    End Object
    OctaveKeyList=OctaveKeybind
    Components.Add(OctaveKeybind);

    Begin Object Class=Yoshi_HUDComponent_KeybindListText Name=PitchKeybind
        TopLeftX=0.6
        TopLeftY=0.0
        ScaleX=0.2
        ScaleY=0.275
        Text="Pitch Down/Up"
    End Object
    PitchKeyList=PitchKeybind
    Components.Add(PitchKeybind);

    Begin Object Class=Yoshi_HUDComponent_KeybindListText Name=StepKeybind
        TopLeftX=0.8
        TopLeftY=0.0
        ScaleX=0.2
        ScaleY=0.275
        Text="Step Down/Up"
    End Object
    StepKeyList=StepKeybind
    Components.Add(StepKeybind);

    Begin Object Class=Yoshi_HUDComponent_Text Name=ShiftlessText
        TopLeftX=0.0
        TopLeftY=0.35
        ScaleX=0.075
        ScaleY=0.275
        Text="Two Row Mode"
        BaseTextSize=0.8
    End Object
    Components.Add(ShiftlessText)

    Begin Object Class=Yoshi_HUDComponent_Toggle Name=ShiftlessToggle
        TopLeftX=0.075
        TopLeftY=0.4375 //0.35 + 0.1375 - 0.05
        ScaleX=0.125
        ScaleY=0.1
    End Object
    TwoRow=ShiftlessToggle
    Components.Add(ShiftlessToggle)

    Begin Object Class=Yoshi_HUDComponent_Text Name=KeyboardLayoutText
        TopLeftX=0.0
        TopLeftY=0.65
        ScaleX=0.075
        ScaleY=0.275
        Text="Key Layout"
        BaseTextSize=0.8
    End Object
    Components.Add(KeyboardLayoutText)

    Begin Object Class=Yoshi_HUDComponent_DropDown Name=KeyboardLayoutDropDown
        TopLeftX=0.075
        TopLeftY=0.7375 //0.65 + 0.1375 - 0.05
        ScaleX=0.1
        ScaleY=0.1
    End Object
    KeyboardLayout=KeyboardLayoutDropDown
    Components.Add(KeyboardLayoutDropDown);

    Begin Object Class=Yoshi_HUDComponent_KeybindList Name=FlatKeybindList
        TopLeftX=0.15
        TopLeftY=0.35
        ScaleX=0.8
        ScaleY=0.275
    End Object
    FlatKeyList=FlatKeybindList
    Components.Add(FlatKeybindList);

    Begin Object Class=Yoshi_HUDComponent_KeybindList Name=KeybindList
        TopLeftX=0.2
        TopLeftY=0.65
        ScaleX=0.8
        ScaleY=0.275
    End Object
    KeyList=KeybindList
    Components.Add(KeybindList);

    PaddingX=0.01
    PaddingY=0.01
}