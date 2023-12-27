class Yoshi_HUDPanel_Metronome extends Yoshi_HUDPanel;

var Yoshi_KeyManager KeyManager;
var Yoshi_Metronome Metronome;

var Yoshi_HUDComponent_Toggle Toggle;
var Yoshi_HUDComponent_NumberEntry BPMEntry;
var Yoshi_HUDComponent_NumberEntry BeatsEntry;

var Material MetronomeMaterial;
var MaterialInstanceConstant MetronomeMat;

var float MetronomeSize;
var float MetronomeAngle;

var bool ReverseBeat;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Metronome = MyGameMod.Metronome;
    KeyManager = MyGameMod.KeyManager;

    Toggle.GetValue = GetUpdating;
    Toggle.SetValue = SetUpdating;
    BPMEntry.GetValue = GetBPM;
    BPMEntry.SetValue = MyGameMod.SetBPM;
    BeatsEntry.GetValue = GetBeatsInMeasure;
    BeatsEntry.SetValue = MyGameMod.SetBeatsInMeasure;

    Metronome.RegisterDelegate(OnBeat);

    MetronomeMat = new class'MaterialInstanceConstant';
    MetronomeMat.SetParent(MetronomeMaterial);

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function Close() {
    Metronome.RemoveDelegate(OnBeat);

    Super.Close();
}

function OnBeat(int MeasureNumber, int BeatNumber) {
    ReverseBeat = !ReverseBeat;
}

function Render(HUD H) {
    local float Alpha;

    Super.Render(H);

    H.Canvas.SetDrawColor(255,255,255,255);

    if(Metronome.IsUpdating()) {
        Alpha = Metronome.GetBeatProgress();
        //Alpha = class'Hat_Math'.static.InterpolationAnticipate(0.0, 1.0, Alpha,,false);

        MetronomeMat.SetScalarParameterValue('Value', ReverseBeat ? 1.0f - Alpha : Alpha);
    }
    else {
        MetronomeMat.SetScalarParameterValue('Value', 0.0);
        ReverseBeat = false;
    }

    MetronomeMat.SetScalarParameterValue('RotateAmount', MetronomeAngle);

    class'Hat_HUDMenu'.static.DrawBottomCenter(H, CurTopLeftX * H.Canvas.ClipX + CurScaleX * H.Canvas.ClipX, CurTopLeftY * H.Canvas.ClipY, MetronomeSize * CurScaleX * H.Canvas.ClipX, MetronomeSize * CurScaleX * H.Canvas.ClipX, MetronomeMat);
}

delegate bool GetUpdating() {
    return Metronome.IsUpdating();
}

delegate SetUpdating(bool bValue) {
    if(bValue && Metronome.IsUpdating()) return;

    if(bValue) {
        Metronome.Start(KeyManager.GetPlayer());
    }
    else {
        Metronome.Stop();
    }
}

delegate int GetBPM() {
    return Metronome.BPM;
}

delegate int GetBeatsInMeasure() {
    return Metronome.BeatsInMeasure;
}

defaultproperties
{
    Title="Metronome"
    Background=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Panel_Bg_Mat'

    PaddingX=0.03
    PaddingY=0.03

    //
    // Text
    //

    Begin Object Class=Yoshi_HUDComponent_Text Name=PowerText
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.3
        ScaleY=0.2
        MarginX=0.03
        MarginY=0.03

        Text="Power"
        BaseTextSize=0.8f        
    End Object
    Components.Add(PowerText);

    Begin Object Class=Yoshi_HUDComponent_Text Name=BeatsText
        TopLeftX=0.0
        TopLeftY=0.2
        ScaleX=0.3
        ScaleY=0.4
        MarginX=0.03
        MarginY=0.03

        Text="Beats"
        BaseTextSize=0.8f        
    End Object
    Components.Add(BeatsText);

    Begin Object Class=Yoshi_HUDComponent_Text Name=BPMText
        TopLeftX=0.0
        TopLeftY=0.6
        ScaleX=0.3
        ScaleY=0.4
        MarginX=0.03
        MarginY=0.03

        Text="BPM"
        BaseTextSize=0.8f
    End Object
    Components.Add(BPMText);

    //
    // Components
    //

    Begin Object Class=Yoshi_HUDComponent_Toggle Name=ToggleMetronome
        TopLeftX=0.3
        TopLeftY=0.0
        ScaleX=0.7
        ScaleY=0.2
        MarginX=0.03
        MarginY=0.06
    End Object
    Toggle=ToggleMetronome
    Components.Add(ToggleMetronome);

    Begin Object Class=Yoshi_HUDComponent_NumberEntry Name=MetronomeBeatsInMeasure
        TopLeftX=0.3
        TopLeftY=0.2
        ScaleX=0.7
        ScaleY=0.4
        MarginX=0.03
        MarginY=0.03

        MinimumValue=1
        MaximumValue=32
    End Object
    BeatsEntry=MetronomeBeatsInMeasure
    Components.Add(MetronomeBeatsInMeasure);

    Begin Object Class=Yoshi_HUDComponent_NumberEntry Name=MetronomeBPM
        TopLeftX=0.3
        TopLeftY=0.6
        ScaleX=0.7
        ScaleY=0.4
        MarginX=0.03
        MarginY=0.03

        MinimumValue=1
        MaximumValue=999
    End Object
    BPMEntry=MetronomeBPM
    Components.Add(MetronomeBPM);

    MetronomeMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Metronome_Pendulum_Mat'
    MetronomeSize=0.5
    MetronomeAngle=70
}