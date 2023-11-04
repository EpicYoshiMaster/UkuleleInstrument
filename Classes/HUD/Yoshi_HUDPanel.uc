class Yoshi_HUDPanel extends Yoshi_HUDComponent;

var string Title;
var Color TextColor;
var Surface Background;

var array<Yoshi_HUDComponent> Components;
var Yoshi_HUDComponent HoveredComponent;
var Yoshi_HUDComponent SelectedComponent;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
	local int i;

    Super.Init(MyGameMod, MyMenu, MyOwner);

    for(i = 0; i < Components.Length; i++) {
        Components[i].Init(MyGameMod, MyMenu, self);
    }
}

function Tick(HUD H, float delta) {
    local int i;

    Super.Tick(H, delta);

    for(i = 0; i < Components.Length; i++) {
        Components[i].Tick(H, delta);
    }
}

function RenderUpdateHover(HUD H) {
    local int i;
    local Vector2D MousePos;
    
    MousePos = Menu.GetMousePos(H);

    if(HoveredComponent != None && !HoveredComponent.IsPointContainedWithin(H, MousePos)) {
        HoveredComponent.RenderStopHover(H);
        HoveredComponent = None;
    }

    for(i = 0; i < Components.Length; i++) {
        if(Components[i].IsPointContainedWithin(H, MousePos)) {
            HoveredComponent = Components[i];

            HoveredComponent.RenderUpdateHover(H);
        }
    }
}

function RenderStopHover(HUD H) {
    if(HoveredComponent != None) {
        HoveredComponent.RenderStopHover(H);
    }

    HoveredComponent = None;
}

function Render(HUD H) {
    local int i;

    Super.Render(H);

    H.Canvas.SetDrawColor(255,255,255,255);

    class'Hat_HUDMenu'.static.DrawTopLeft(H, CurTopLeftX * H.Canvas.ClipX, CurTopLeftY * H.Canvas.ClipY, CurScaleX * H.Canvas.ClipX, CurScaleY * H.Canvas.ClipY, Background);

    H.Canvas.SetDrawColorStruct(TextColor);
    H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont("");

    class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, Title, CurTopLeftX * H.Canvas.ClipX, CurTopLeftY * H.Canvas.ClipY, TextScale * H.Canvas.ClipY, true, TextAlign_BottomLeft);

    H.Canvas.SetDrawColor(255,255,255,255);

    for(i = 0; i < Components.Length; i++) {
        Components[i].Render(H);
    }
}

function bool OnClick(HUD H, bool release)
{
    if(HoveredComponent != None) {
        return HoveredComponent.OnClick(H, release);
    }

    return false;
}

defaultproperties
{
    Title="I forgot to name my panel :(";
    TextColor=(R=255,G=255,B=255,A=255)
    TextScale=0.00045
    Background=Material'HatInTime_Levels_Cruise_Meku.Materials.Skydome_Cruise'
}