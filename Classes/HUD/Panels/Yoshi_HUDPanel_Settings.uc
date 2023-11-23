class Yoshi_HUDPanel_Settings extends Yoshi_HUDPanel;

var Yoshi_HUDComponent_Toggle NotesToggle;
var Yoshi_HUDComponent_Toggle SongsToggle;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {

    NotesToggle.GetValue = GetNotes;
    NotesToggle.SetValue = SetNotes;

    SongsToggle.GetValue = GetSongs;
    SongsToggle.SetValue = SetSongs;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function bool GetNotes() {
    return (class'Yoshi_UkuleleInstrument_GameMod'.default.OnlineNotes == 0);
}

function SetNotes(bool NewValue) {
    class'GameMod'.static.SaveConfigValue(GameMod.class, 'OnlineNotes', (NewValue) ? 0 : 1);
}

function bool GetSongs() {
    return (class'Yoshi_UkuleleInstrument_GameMod'.default.OnlineSongs == 0);
}

function SetSongs(bool NewValue) {
    class'GameMod'.static.SaveConfigValue(GameMod.class, 'OnlineSongs', (NewValue) ? 0 : 1);
}

defaultproperties
{
    Title="Settings"
    Background=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Panel_Bg_Mat'

    PaddingX=0.03
    PaddingY=0.03

    //
    // Text
    //

    Begin Object Class=Yoshi_HUDComponent_Text Name=NotesText
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.8
        ScaleY=0.5
        MarginX=0.03
        MarginY=0.03

        Text="Online Party Notes"
        BaseTextSize=0.8f        
    End Object
    Components.Add(NotesText);

    Begin Object Class=Yoshi_HUDComponent_Text Name=SongsText
        TopLeftX=0.0
        TopLeftY=0.5
        ScaleX=0.8
        ScaleY=0.5
        MarginX=0.03
        MarginY=0.03

        Text="Online Party Songs"
        BaseTextSize=0.8f
    End Object
    Components.Add(SongsText);

    //
    // Components
    //

    Begin Object Class=Yoshi_HUDComponent_Toggle Name=ToggleNotes
        TopLeftX=0.8
        TopLeftY=0.0
        ScaleX=0.2
        ScaleY=0.5
        MarginX=0.03
        MarginY=0.03
    End Object
    NotesToggle=ToggleNotes
    Components.Add(ToggleNotes);

    Begin Object Class=Yoshi_HUDComponent_Toggle Name=ToggleSongs
        TopLeftX=0.8
        TopLeftY=0.5
        ScaleX=0.2
        ScaleY=0.5
        MarginX=0.03
        MarginY=0.03
    End Object
    SongsToggle=ToggleSongs
    Components.Add(ToggleSongs);
}