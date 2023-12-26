class Yoshi_HUDMenu_MusicMenu extends Yoshi_HUDMenu_SharedCoop;

const MainTabIndex = 0;
const SettingsTabIndex = 1;

var bool bEnabled;

var string TestText;
var TextAlign TextAlignment;
var Font TextFont;

var array<string> PrintStrings;
var Yoshi_UkuleleInstrument_GameMod GameMod;

var int TabIndex;

var array<Yoshi_HUDPanel> Panels;
var Yoshi_HUDPanel HoveredPanel;

var Color TextColor;

function OnOpenHUD(HUD H, optional String command)
{
    local int i;

	Super.OnOpenHUD(H, command);

    GameMod = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

    GameMod.KeyManager.RegisterInputDelegate(OnInputKey);
    
    for(i = 0; i < Panels.Length; i++) {
        Panels[i].Init(GameMod, self);
    }
}

function SetEnabled(HUD H, bool bValue) {
    local Hat_HUD MouseHUD;

    bEnabled = bValue;
    RequiresMouse = bEnabled;

    MouseHUD = GetKeyboardHUD(H);

    if(MouseHUD != None) {
        SetMouseHidden(MouseHUD, !bEnabled);
    }
}

function bool IsEnabled() {
    return bEnabled;
}

function OnCloseHUD(HUD H)
{
    local int i;

    for(i = 0; i < Panels.Length; i++) {
        Panels[i].Close();
    }

    Panels.Length = 0;
    HoveredPanel = None;

    GameMod.KeyManager.RemoveInputDelegate(OnInputKey);

	Super.OnCloseHUD(H);
}

function SetTabIndex(int NewTabIndex) {
    TabIndex = NewTabIndex;
}

function bool Tick(HUD H, float delta)
{
    local int i;

    if (!Super.Tick(H, delta)) return false;
    if(!bEnabled) return true;

    for(i = 0; i < Panels.Length; i++) {
        if(Panels[i].InCurrentTab(TabIndex)) {
            Panels[i].Tick(H, delta);
        }
    }
	
    return true;
}

function bool Render(HUD H)
{
    local int i;
    local Vector2D MousePos;

    //local float scale, posX, posY, stepY;
    //local string s;

	if (!Super.Render(H)) return false;
    if(!bEnabled) return true;

    MousePos = GetMousePos(H);

    if(HoveredPanel != None) {
        if(HoveredPanel.InCurrentTab(TabIndex) && HoveredPanel.IsPointContainedWithin(H, MousePos)) {
            HoveredPanel.RenderUpdateHover(H);
        }
        else {
            HoveredPanel.RenderStopHover(H);
            HoveredPanel = None;
        }
    }

    for(i = 0; i < Panels.Length; i++) {
        if(!Panels[i].InCurrentTab(TabIndex)) continue;

        if(HoveredPanel == None && Panels[i].IsPointContainedWithin(H, MousePos)) {
            HoveredPanel = Panels[i];

            Panels[i].RenderUpdateHover(H);
        }

        Panels[i].Render(H);
    }

    /*

    PrintStrings.Length = 0;
    scale = FMin(H.Canvas.ClipX, H.Canvas.ClipY)*0.00025;
    posX = H.Canvas.ClipX*0.01;
    posY = H.Canvas.ClipY*0.01;
    stepY = H.Canvas.ClipY*0.03;

    H.Canvas.SetDrawColor(255,255,255,255);
    H.Canvas.Font = class'Yoshi_HUDComponent'.default.StandardFont;

    s = "Panel Hover:" @ HoveredPanel.class;

    PrintStrings.AddItem(s);

    for(i = 0; i < Panels.Length; i++) {
        s = "Panel[" $ i $ "]" @ Panels[i].class $ " Hover:" @ Panels[i].HoveredComponent.class;

        if(Yoshi_HUDComponent_Parent(Panels[i].HoveredComponent) != None) {
           s $= " Hover:" @ Yoshi_HUDComponent_Parent(Panels[i].HoveredComponent).HoveredComponent.class;
        }

        PrintStrings.AddItem(s);
    }

    for(i = 0; i < PrintStrings.Length; i++) {
        class'Hat_HUDMenu'.static.DrawText(H.Canvas, PrintStrings[i], posX, posY, scale, scale, TextAlign_Left);
        posY += stepY;
    }*/

    //DrawTextTest(H, TestText, 0.01 * H.Canvas.ClipX, 0.6 * H.Canvas.ClipY, 0.3 * H.Canvas.ClipX, 0.3 * H.Canvas.ClipY);

    return true;
}

function DrawTextTest(HUD H, string Text, float posx, float posy, float ScaleX, float ScaleY) {
    H.Canvas.SetPos(posx, posy);
    H.Canvas.SetDrawColor(255, 0, 0, 255);

    H.Canvas.DrawBox(ScaleX, ScaleY);

    H.Canvas.SetDrawColor(255, 255, 255, 255);

    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_TopLeft);
    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_Top);
    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_TopRight);
    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_Left);
    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_Center);
    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_Right);
    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_BottomLeft);
    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_Bottom);
    class'Yoshi_HUDComponent'.static.DrawTextInBox(H, Text, posx, posy, ScaleX, ScaleY, TextColor, ElementAlign_BottomRight);

    H.Canvas.SetDrawColor(255, 255, 255, 255);
}

function bool OnInputKey(string KeyName, EInputEvent EventType) {
    if(!bEnabled) return false;

    if(HoveredPanel != None) {
        return HoveredPanel.OnInputKey(KeyName, EventType);
    }

    return false;
}

function bool DisablesMovement(HUD H)
{
    return bEnabled;
}

function bool DisablesCameraMovement(HUD H)
{
    return bEnabled;
}

function bool DisablePause(HUD H)
{
	return bEnabled;
}

defaultproperties
{
    Begin Object Class=Yoshi_HUDPanel_Instruments Name=SelectInstrumentPanel
        TopLeftX=0.05
        TopLeftY=0.1
        ScaleX=0.4
        ScaleY=0.4
        TextScale=0.0007
        TabIndex=MainTabIndex
    End Object
    Panels.Add(SelectInstrumentPanel);

    Begin Object Class=Yoshi_HUDPanel_Metronome Name=MetronomePanel
        TopLeftX=0.5
        TopLeftY=0.1
        ScaleX=0.175
        ScaleY=0.2
        TextScale=0.0007
        TabIndex=MainTabIndex
    End Object
    Panels.Add(MetronomePanel);

    Begin Object Class=Yoshi_HUDPanel_Keybinds Name=KeybindsPanel
        TopLeftX=0.05
        TopLeftY=0.6
        ScaleX=0.8
        ScaleY=0.3
        TextScale=0.0007
        TabIndex=SettingsTabIndex
    End Object 
    Panels.Add(KeybindsPanel);

    Begin Object Class=Yoshi_HUDPanel_Settings Name=SettingsPanel
        TopLeftX=0.5
        TopLeftY=0.35
        ScaleX=0.175
        ScaleY=0.15
        TextScale=0.0007
        TabIndex=SettingsTabIndex
    End Object
    Panels.Add(SettingsPanel);

    Begin Object Class=Yoshi_HUDPanel_Songs Name=SongsPanel
        TopLeftX=0.725
        TopLeftY=0.35
        ScaleX=0.15
        ScaleY=0.15
        TextScale=0.0007
        TabIndex=MainTabIndex
    End Object
    Panels.Add(SongsPanel);

    Begin Object Class=Yoshi_HUDPanel_Tabs Name=TabsPanel
        TopLeftX=0.725
        TopLeftY=0.1
        ScaleX=0.15
        ScaleY=0.05
        TextScale=0.0007
        TabIndex=-1
    End Object
    Panels.Add(TabsPanel);

    Begin Object Class=Yoshi_HUDPanel_PianoRoll Name=PianoRollPanel
        TopLeftX=0.05
        TopLeftY=0.65
        ScaleX=0.8
        ScaleY=0.3
        TextScale=0.0007
        TabIndex=MainTabIndex
    End Object
    Panels.Add(PianoRollPanel);

    TextAlignment=TextAlign_TopLeft

    RequiresMouse=false
    SharedInCoop=true

    TestText="{My Test Text} <3"
    TextFont = Font'Yoshi_UkuleleMats_Content.Fonts.LatoBlackStandard'
    TextColor=(R=255,G=255,B=255,A=255)
}