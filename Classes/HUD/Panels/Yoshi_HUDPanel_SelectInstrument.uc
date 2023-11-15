class Yoshi_HUDPanel_SelectInstrument extends Yoshi_HUDPanel;

defaultproperties
{
    Title="Instruments"
    Background=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Panel_Bg_Mat'
    
    Begin Object Class=Yoshi_HUDComponent_InstrumentList Name=InstrumentListComponent
        TopLeftX=0.03
        TopLeftY=0.03
        ScaleX=0.94
        ScaleY=0.94
    End Object
    Components.Add(InstrumentListComponent);
}