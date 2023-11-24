class Yoshi_HUDPanel_Songs extends Yoshi_HUDPanel;

var Yoshi_HUDComponent_DropDown Songs;
var Yoshi_HUDComponent_Toggle RecordMode;
var Yoshi_HUDComponent_Button ResetLayers;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Songs.GetOptions = GetSongs;
    Songs.GetValue = GetSongIndex;
    Songs.SetValue = SetSongIndex;

    RecordMode.GetValue = GetRecordMode;
    RecordMode.SetValue = SetRecordMode;

    ResetLayers.OnClickButton = ResetSongLayers;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function array<string> GetSongs() {
    local array<string> SongNames;
    local int i;

    for(i = 0; i < GameMod.StoredSongs.Songs.Length; i++) {
        SongNames.AddItem("Song " $ (i + 1));
    }

    SongNames.AddItem("New Song");

    return SongNames;
}

function int GetSongIndex() {
    return class'Yoshi_UkuleleInstrument_GameMod'.default.SongIndex;
}

function SetSongIndex(int NewValue) {
    class'GameMod'.static.SaveConfigValue(GameMod.class, 'SongIndex', NewValue);
}

function bool GetRecordMode() {
    return (class'Yoshi_UkuleleInstrument_GameMod'.default.RecordingMode == 1);
}

function SetRecordMode(bool NewValue) {
    class'GameMod'.static.SaveConfigValue(GameMod.class, 'RecordingMode', (NewValue) ? 1 : 0);
}

function ResetSongLayers() {
    class'GameMod'.static.SaveConfigValue(GameMod.class, 'RecordingMode', 2);
}

defaultproperties
{
    Title="Songs"

    //
    // Text
    // 

    Begin Object Class=Yoshi_HUDComponent_Text Name=SongsText
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.5
        ScaleY=0.2
        MarginX=0.03
        MarginY=0.03

        Text="Song"
        BaseTextSize=0.8f
    End Object
    Components.Add(SongsText);

    Begin Object Class=Yoshi_HUDComponent_Text Name=RecordModeText
        TopLeftX=0.0
        TopLeftY=0.2
        ScaleX=0.7
        ScaleY=0.4
        MarginX=0.03
        MarginY=0.03

        Text="Recording Mode"
        BaseTextSize=0.8f        
    End Object
    Components.Add(RecordModeText);

    //
    // Components
    //

    Begin Object Class=Yoshi_HUDComponent_Toggle Name=RecordModeToggle
        TopLeftX=0.7
        TopLeftY=0.2
        ScaleX=0.3
        ScaleY=0.4
        MarginX=0.03
        MarginY=0.03
    End Object
    RecordMode=RecordModeToggle
    Components.Add(RecordModeToggle);

    Begin Object Class=Yoshi_HUDComponent_ButtonTextConfirm Name=ResetLayersButton
        TopLeftX=0.4
        TopLeftY=0.6
        ScaleX=0.6
        ScaleY=0.3
        MarginX=0.03
        MarginY=0.03

        Text="Delete Song"
    End Object
    ResetLayers=ResetLayersButton
    Components.Add(ResetLayersButton);

    //Must be last for render priority
    Begin Object Class=Yoshi_HUDComponent_DropDown Name=SongsDropDown
        TopLeftX=0.5
        TopLeftY=0.0
        ScaleX=0.5
        ScaleY=0.2
        MarginX=0.03
        MarginY=0.03
    End Object
    Songs=SongsDropDown
    Components.Add(SongsDropDown);
}