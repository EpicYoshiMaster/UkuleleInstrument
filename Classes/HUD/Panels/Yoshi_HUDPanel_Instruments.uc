class Yoshi_HUDPanel_Instruments extends Yoshi_HUDPanel;

var Yoshi_HUDComponent_IconBoxList Instruments;
var Yoshi_HUDComponent_DropDown Scales;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Instruments.GetIcons = GetInstrumentIcons;
    Instruments.GetValue = GetInstrumentIndex;
    Instruments.SetValue = MyGameMod.SetInstrumentIndex;

    Scales.GetOptions = GetScaleOptions;
    Scales.GetValue = GetScaleValue;
    Scales.SetValue = MyGameMod.SetScaleIndex;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function array<Texture2D> GetInstrumentIcons() {
    local array<Texture2D> AllIcons;
    local int i;

    for(i = 0; i < GameMod.AllInstruments.Length; i++) {
        AllIcons.AddItem(GameMod.AllInstruments[i].default.Icon);
    }

    return AllIcons;
}

function int GetInstrumentIndex() {
    return GameMod.Settings.InstrumentIndex;
}

function array<string> GetScaleOptions() {
    local array<string> ScaleOptions;
    local int i;

    for(i = 0; i < GameMod.Scales.Length; i++) {
        ScaleOptions.AddItem(GameMod.Scales[i].ScaleName);
    }

    return ScaleOptions;
}

function int GetScaleValue() {
    return GameMod.Settings.ScaleIndex;
}

defaultproperties
{
    Title="Instruments"
    Background=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Panel_Bg_Mat'
    
    PaddingX=0.03
    PaddingY=0.03

    Begin Object Class=Yoshi_HUDComponent_IconBoxList Name=InstrumentListComponent
        TopLeftX=0.0
        TopLeftY=0.13
        ScaleX=1.0
        ScaleY=0.87
    End Object
    Instruments=InstrumentListComponent
    Components.Add(InstrumentListComponent);

    Begin Object Class=Yoshi_HUDComponent_Text Name=ScalesText
        Text="Scale"
        UseBorderedText=false
        TextAlignment=ElementAlign_Right
        TopLeftX=0.6
        TopLeftY=0.0
        ScaleX=0.2
        ScaleY=0.1
        BaseTextSize=0.8f
    End Object
    Components.Add(ScalesText);

    Begin Object Class=Yoshi_HUDComponent_DropDown Name=ScalesDropDown
        TopLeftX=0.8
        TopLeftY=0.01
        ScaleX=0.2
        ScaleY=0.08
    End Object
    Scales=ScalesDropDown
    Components.Add(ScalesDropDown);
}