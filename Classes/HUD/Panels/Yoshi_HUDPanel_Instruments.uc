class Yoshi_HUDPanel_Instruments extends Yoshi_HUDPanel;

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
    Title="Instruments"
    Background=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Panel_Bg_Mat'
    
    PaddingX=0.03
    PaddingY=0.03

    Begin Object Class=Yoshi_HUDComponent_InstrumentList Name=InstrumentListComponent
        TopLeftX=0.0
        TopLeftY=0.13
        ScaleX=1.0
        ScaleY=0.87
    End Object
    Components.Add(InstrumentListComponent);

    Begin Object Class=Yoshi_HUDComponent_DropDown Name=ScalesDropDown
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.25
        ScaleY=0.1
    End Object
    Scales=ScalesDropDown
    Components.Add(ScalesDropDown);
}