class Yoshi_HUDPanel_Tabs extends Yoshi_HUDPanel;

var Yoshi_HUDComponent_Button MainTab;
var Yoshi_HUDComponent_Button SettingsTab;

delegate SetIntValueDelegate(int NewValue);

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {

    MainTab.OnClickButton = SetToMainTab;
    SettingsTab.OnClickButton = SetToSettingsTab;

    Super.Init(MyGameMod, MyMenu, MyOwner);
}

function SetToMainTab() {
    Menu.SetTabIndex(class'Yoshi_HUDMenu_MusicMenu'.const.MainTabIndex);
}

function SetToSettingsTab() {
    Menu.SetTabIndex(class'Yoshi_HUDMenu_MusicMenu'.const.SettingsTabIndex);
}

defaultproperties
{
    Title="Tab"
    Background=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Panel_Bg_Mat'

    PaddingX=0.03
    PaddingY=0.03

    Begin Object Class=Yoshi_HUDComponent_ButtonText Name=MainTabButton
        TopLeftX=0.0
        TopLeftY=0.0
        ScaleX=0.5
        ScaleY=1.0
        MarginX=0.03
        MarginY=0.03

        Text="Home"
    End Object
    MainTab=MainTabButton
    Components.Add(MainTabButton);

    Begin Object Class=Yoshi_HUDComponent_ButtonText Name=SettingsTabButton
        TopLeftX=0.5
        TopLeftY=0.0
        ScaleX=0.5
        ScaleY=1.0
        MarginX=0.03
        MarginY=0.03

        Text="Settings"
    End Object
    SettingsTab=SettingsTabButton
    Components.Add(SettingsTabButton);
}