class Yoshi_HUDPanel_Keybinds extends Yoshi_HUDPanel;

var Yoshi_HUDComponent_KeybindList KeyList;
var Yoshi_HUDComponent_KeybindList FlatKeyList;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    KeyList.GetValue = GetKeyValues;
    KeyList.SetValue = SetKeyValues;

    FlatKeyList.GetValue = GetFlatKeyValues;
    FlatKeyList.SetValue = SetFlatKeyValues;

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

defaultproperties
{
    Title="Keybinds"

    Begin Object Class=Yoshi_HUDComponent_KeybindList Name=FlatKeybindList
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.95
        ScaleY=0.45
    End Object
    FlatKeyList=FlatKeybindList
    Components.Add(FlatKeybindList);

    Begin Object Class=Yoshi_HUDComponent_KeybindList Name=KeybindList
        TopLeftX=0.05
        TopLeftY=0.55
        ScaleX=0.95
        ScaleY=0.45
    End Object
    KeyList=KeybindList
    Components.Add(KeybindList);

    PaddingX=0.03
    PaddingY=0.03
}