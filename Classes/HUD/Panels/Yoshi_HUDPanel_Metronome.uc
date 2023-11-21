class Yoshi_HUDPanel_Metronome extends Yoshi_HUDPanel;

var Yoshi_Metronome Metronome;

var Yoshi_HUDComponent_Toggle Toggle;
var Yoshi_HUDComponent_NumberEntry BPMEntry;
var Yoshi_HUDComponent_NumberEntry BeatsEntry;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Metronome = MyGameMod.Metronome;

    Toggle.GetValue = GetUpdating;
    Toggle.SetValue = SetUpdating;
    BPMEntry.GetValue = GetBPM;
    BPMEntry.SetValue = SetBPM;
    BeatsEntry.GetValue = GetBeatsInMeasure;
    BeatsEntry.SetValue = SetBeatsInMeasure;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

delegate bool GetUpdating() {
    return Metronome.IsUpdating();
}

delegate SetUpdating(bool bValue) {
    if(bValue) {
        Metronome.Start();
    }
    else {
        Metronome.Stop();
    }
}

delegate int GetBPM() {
    return Metronome.BPM;
}

delegate SetBPM(int NewBPM) {
    Metronome.SetBPM(NewBPM);
}

delegate int GetBeatsInMeasure() {
    return Metronome.BeatsInMeasure;
}

delegate SetBeatsInMeasure(int NewBeatsInMeasure) {
    Metronome.SetBeatsInMeasure(NewBeatsInMeasure);
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
}