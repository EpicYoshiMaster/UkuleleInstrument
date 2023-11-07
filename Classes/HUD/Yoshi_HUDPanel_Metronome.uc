class Yoshi_HUDPanel_Metronome extends Yoshi_HUDPanel;

var bool MyCoolBool;

function bool GetBoolValue() {
    return MyCoolBool;
}

function SetBoolValue(bool bValue) {
    MyCoolBool = bValue;
}

defaultproperties
{
    Title="Metronome"
    Background=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Panel_Bg_Mat'

    Begin Object Class=Yoshi_HUDComponent_Toggle Name=ToggleComponent1
        TopLeftX=0.03
        TopLeftY=0.03
        ScaleX=0.94
        ScaleY=0.1
        GetValue=GetBoolValue
        SetValue=SetBoolValue
        
        OnPropertyName="On"
        OffPropertyName="Off"
    End Object
    Components.Add(ToggleComponent1);

    Begin Object Class=Yoshi_HUDComponent_Toggle Name=ToggleComponent2
        TopLeftX=0.03
        TopLeftY=0.16
        ScaleX=0.94
        ScaleY=0.1
        GetValue=GetBoolValue
        SetValue=SetBoolValue

        OnPropertyName="Something Cool"
        OffPropertyName="Something Cool 2"
    End Object
    Components.Add(ToggleComponent2);

    Begin Object Class=Yoshi_HUDComponent_Toggle Name=ToggleComponent3
        TopLeftX=0.03
        TopLeftY=0.29
        ScaleX=0.94
        ScaleY=0.1
        GetValue=GetBoolValue
        SetValue=SetBoolValue

        OnPropertyName="Really really really long set of text designed to be absurd and be tiny as hell"
        OffPropertyName="Really really really long set of text designed to be absurd and be tiny as hell"
    End Object
    Components.Add(ToggleComponent3);
}