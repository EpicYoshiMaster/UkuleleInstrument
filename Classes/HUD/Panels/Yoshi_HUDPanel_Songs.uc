class Yoshi_HUDPanel_Songs extends Yoshi_HUDPanel;

var Yoshi_RecordManager RecordManager;
var Yoshi_SongManager SongManager;

var Yoshi_HUDComponent_DropDown Songs;
var Yoshi_HUDComponent_Toggle RecordMode;
var Yoshi_HUDComponent_Button ResetLayers;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    RecordManager = MyGameMod.RecordManager;
    SongManager = MyGameMod.SongManager;

    Songs.GetOptions = GetSongs;
    Songs.GetValue = GetSongIndex;
    Songs.SetValue = MyGameMod.SetSongIndex;

    RecordMode.GetValue = GetRecordMode;
    RecordMode.SetValue = RecordManager.SetRecordingMode;

    ResetLayers.OnClickButton = DeleteSong;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function array<string> GetSongs() {
    local array<string> SongNames;
    local int i;

    for(i = 0; i < SongManager.SavedSongs.Length; i++) {
        SongNames.AddItem(SongManager.SavedSongs[i].SongName);
    }

    SongNames.AddItem("New Song");

    return SongNames;
}

function int GetSongIndex() {
    return GameMod.Settings.SongIndex;
}

function bool GetRecordMode() {
    return RecordManager.InRecordingMode;
}

function DeleteSong() {
    SongManager.DeleteSong(GetSongIndex());
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