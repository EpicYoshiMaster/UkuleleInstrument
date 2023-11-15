class Yoshi_HUDPanel_Scales extends Yoshi_HUDPanel;

var Yoshi_HUDComponent_DropDown Scales;
var Yoshi_HUDComponent_Scrollbar Scrollbar;

var float ScrollWindowSize;
var float MaximumOffset;

var float ScrollOffset;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Scales.GetOptions = GetScaleOptions;
    Scales.GetValue = GetScaleValue;
    Scales.SetValue = SetScaleValue;

    Scrollbar.GetScrollWindowSize = GetScrollWindowSize;
    Scrollbar.GetMaximumOffset = GetMaximumOffset;
    Scrollbar.GetValue = GetScrollOffset;
    Scrollbar.SetValue = SetScrollOffset;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

delegate array<string> GetScaleOptions() {
    local array<string> ScaleOptions;
    local int i;

    for(i = 0; i < GameMod.Scales.Length; i++) {
        ScaleOptions.AddItem(GameMod.Scales[i].ScaleName);
    }

    return ScaleOptions;
}

delegate int GetScaleValue() {
    return class'Yoshi_UkuleleInstrument_GameMod'.default.Scale;
}

delegate SetScaleValue(int NewValue) {
    class'GameMod'.static.SaveConfigValue(GameMod.class, 'Scale', NewValue);
}

function float GetScrollWindowSize() {
    return ScrollWindowSize;
}

function float GetMaximumOffset() {
    return MaximumOffset;
}

function float GetScrollOffset() {
    return ScrollOffset;
}

function SetScrollOffset(float NewValue) {
    ScrollOffset = NewValue;
}

defaultproperties
{
    Title="Scales"

    Begin Object Class=Yoshi_HUDComponent_DropDown Name=ScalesDropDown
        TopLeftX=0.03
        TopLeftY=0.03
        ScaleX=0.8
        ScaleY=0.3
    End Object
    Scales=ScalesDropDown
    Components.Add(ScalesDropDown);

    Begin Object Class=Yoshi_HUDComponent_Scrollbar Name=ScalesScrollbar
        TopLeftX=0.86
        TopLeftY=0.03
        ScaleX=0.11
        ScaleY=0.94
    End Object
    Scrollbar=ScalesScrollbar
    Components.Add(ScalesScrollbar);

    ScrollWindowSize=3.0
    MaximumOffset=25.0
}