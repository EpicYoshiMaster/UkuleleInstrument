class Yoshi_HUDPanel_Scales extends Yoshi_HUDPanel;

var Yoshi_HUDComponent_DropDown Scales;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Scales.GetOptions = GetScaleOptions;
    Scales.GetValue = GetScaleValue;
    Scales.SetValue = SetScaleValue;

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

defaultproperties
{
    Title="Scales"

    Begin Object Class=Yoshi_HUDComponent_DropDown Name=ScalesDropDown
        TopLeftX=0.03
        TopLeftY=0.03
        ScaleX=0.94
        ScaleY=0.3
    End Object
    Scales=ScalesDropDown
    Components.Add(ScalesDropDown);
}