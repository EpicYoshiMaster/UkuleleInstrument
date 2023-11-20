class Yoshi_HUDPanel_Keybinds extends Yoshi_HUDPanel;

var Yoshi_HUDComponent_KeybindList KeyList;
var Yoshi_HUDComponent_KeybindList FlatKeyList;
var Yoshi_HUDComponent_ModifierKeybindList ModifierKeyList;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    KeyList.GetValue = GetKeyValues;
    KeyList.SetValue = SetKeyValues;

    FlatKeyList.GetValue = GetFlatKeyValues;
    FlatKeyList.SetValue = SetFlatKeyValues;

    ModifierKeyList.GetValue = GetModifierKeyValues;
    //ModifierKeyList.GetKeyDescriptions = GetModifierKeyDescriptions;
    ModifierKeyList.SetValue = SetModifierKeyValues;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function array<string> GetKeyValues() {
    return GameMod.InstrumentKeys[GameMod.KeyboardLayout].Notes;
}

function SetKeyValues(array<string> NewValues) {

}

function array<string> GetFlatKeyValues() {
    return GameMod.InstrumentKeys[GameMod.KeyboardLayout].FlatNotes;
}

function SetFlatKeyValues(array<string> NewValues) {

}

function array<string> GetModifierKeyValues() {
    local array<string> Keys;

    Keys.AddItem("U");

    return Keys;
}

function array<string> GetModifierKeyDescriptions() {
    local array<string> Descriptions;

    Descriptions.AddItem("Hello");

    return Descriptions;
}

function SetModifierKeyValues(array<string> NewValues) {

}

defaultproperties
{
    Title="Keybinds"

    Begin Object Class=Yoshi_HUDComponent_ModifierKeybindList Name=ModifierKeybindList
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.95
        ScaleY=0.275
    End Object
    ModifierKeyList=ModifierKeybindList
    Components.Add(ModifierKeybindList);

    Begin Object Class=Yoshi_HUDComponent_KeybindList Name=FlatKeybindList
        TopLeftX=0.0
        TopLeftY=0.35
        ScaleX=0.95
        ScaleY=0.275
    End Object
    FlatKeyList=FlatKeybindList
    Components.Add(FlatKeybindList);

    Begin Object Class=Yoshi_HUDComponent_KeybindList Name=KeybindList
        TopLeftX=0.05
        TopLeftY=0.65
        ScaleX=0.95
        ScaleY=0.275
    End Object
    KeyList=KeybindList
    Components.Add(KeybindList);

    PaddingX=0.03
    PaddingY=0.03
}