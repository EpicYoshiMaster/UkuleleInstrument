class Yoshi_HUDMenu_MusicMenu extends Hat_HUDMenu;

var array<string> PrintStrings;
var Yoshi_UkuleleInstrument_GameMod GameMod;

var array<Yoshi_HUDPanel> Panels;
var Yoshi_HUDPanel HoveredPanel;
var Yoshi_HUDPanel SelectedPanel;

//Component-wise system

//Yoshi_HUDComponent
//Yoshi_HUDComponent_Slider
//Yoshi_HUDComponent_Keybind
//Yoshi_HUDComponent_Panel

//Render
//Tick
//OnClick
//Directional

function OnOpenHUD(HUD H, optional String command)
{
    local int i;

	Super.OnOpenHUD(H, command);

    GameMod = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();
    
    for(i = 0; i < Panels.Length; i++) {
        Panels[i].Init(GameMod, self);
    }
}

function bool Tick(HUD H, float delta)
{
    local int i;

    if (!Super.Tick(H, delta)) return false;

    for(i = 0; i < Panels.Length; i++) {
        Panels[i].Tick(H, delta);
    }
	
    return true;
}

function bool Render(HUD H)
{
    local int i;
    local Vector2D MousePos;

    local float scale, scaleX, scaleY, stepY;
    local string s;

	if (!Super.Render(H)) return false;

    MousePos = GetMousePos(H);

    if(HoveredPanel != None && !HoveredPanel.IsPointContainedWithin(H, MousePos)) {
        HoveredPanel.RenderStopHover(H);
        HoveredPanel = None;
    }

    for(i = 0; i < Panels.Length; i++) {
        if(Panels[i].IsPointContainedWithin(H, MousePos)) {
            HoveredPanel = Panels[i];

            Panels[i].RenderUpdateHover(H);
        }

        Panels[i].Render(H);
    }

    PrintStrings.Length = 0;
    scale = FMin(H.Canvas.ClipX, H.Canvas.ClipY)*0.00045;
    scaleX = H.Canvas.ClipX*0.01;
    scaleY = H.Canvas.ClipY*0.15;
    stepY = H.Canvas.ClipY*0.05;

    H.Canvas.SetDrawColor(255,255,255,255);
    H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont("");

    s = "Panel Hover:" @ HoveredPanel.class;

    PrintStrings.AddItem(s);

    for(i = 0; i < Panels.Length; i++) {
        s = "Panel[" $ i $ "]" @ Panels[i].class @ ": Component Hover:" @ Panels[i].HoveredComponent.class;

        PrintStrings.AddItem(s);
    }

    for(i = 0; i < PrintStrings.Length; i++) {
        class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, PrintStrings[i], scaleX, scaleY, scale, true, TextAlign_Left);
        scaleY += stepY;
    }

    return true;
}

function bool OnClick(HUD H, bool release)
{
    if(HoveredPanel != None) {
        return HoveredPanel.OnClick(H, release);
    }

    return false;
}

function bool OnAltClick(HUD H, bool release)
{
    return false;
}

function bool OnPressUp(HUD H, bool menu, bool release)
{
	return false;
}

function bool OnPressDown(HUD H, bool menu, bool release)
{
	return false;
}

function bool OnPressLeft(HUD H, bool menu, bool release)
{
	return false;
}

function bool OnPressRight(HUD H, bool menu, bool release)
{
	return false;
}

function bool DisablesMovement(HUD H)
{
    return true;
}

function bool DisablesCameraMovement(HUD H)
{
    return true;
}

function bool DisablePause(HUD H)
{
	return true;
}

defaultproperties
{
    Begin Object Class=Yoshi_HUDPanel_SelectInstrument Name=SelectInstrumentPanel
        TopLeftX=0.1
        TopLeftY=0.3
        ScaleX=0.4
        ScaleY=0.3
        TextScale=0.0007
    End Object
    Panels.Add(SelectInstrumentPanel)

    Begin Object Class=Yoshi_HUDPanel Name=TestPanel2
        Title="Test Panel 2"
        TextColor=(R=0,G=255,B=0,A=255)
        Background=Material'HatinTime_Levels_Boat_H2.Materials.Map'
        TopLeftX=0.7
        TopLeftY=0.3
        ScaleX=0.2
        ScaleY=0.4
        TextScale=0.0007
    End Object
    Panels.Add(TestPanel2)

    RequiresMouse=true
}