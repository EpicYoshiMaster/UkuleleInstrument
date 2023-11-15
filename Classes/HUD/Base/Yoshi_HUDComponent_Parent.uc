//Base Component class for components which can own other components
class Yoshi_HUDComponent_Parent extends Yoshi_HUDComponent
    abstract;

var array<Yoshi_HUDComponent> Components;
var Yoshi_HUDComponent HoveredComponent;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
	local int i;

    Super.Init(MyGameMod, MyMenu, MyOwner);

    for(i = 0; i < Components.Length; i++) {
        Components[i].Init(MyGameMod, MyMenu, self);
    }
}

function Close() {
    local int i;

    for(i = 0; i < Components.Length; i++) {
        Components[i].Close();
    }

    Components.Length = 0;
    HoveredComponent = None;

    Super.Close();
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

    Super.RenderUpdateHover(H);
    
    MousePos = Menu.GetMousePos(H);

    if(HoveredComponent != None) {
        if(HoveredComponent.IsPointContainedWithin(H, MousePos)) {
            HoveredComponent.RenderUpdateHover(H);
            return; //This component still has control
        }
        else {
            HoveredComponent.RenderStopHover(H);
            HoveredComponent = None;
        }
    }

    for(i = 0; i < Components.Length; i++) {
        if(Components[i].IsPointContainedWithin(H, MousePos)) {
            HoveredComponent = Components[i];

            HoveredComponent.RenderUpdateHover(H);
        }
    }
}

function RenderStopHover(HUD H) {
    Super.RenderStopHover(H);

    if(HoveredComponent != None) {
        HoveredComponent.RenderStopHover(H);
    }

    HoveredComponent = None;
}

function Render(HUD H) {
    local int i;

    Super.Render(H);

    for(i = 0; i < Components.Length; i++) {
        Components[i].Render(H);
    }
}

function bool OnClick(HUD H, bool release)
{
    if(Super.OnClick(H, release)) return true;

    if(HoveredComponent != None) {
        return HoveredComponent.OnClick(H, release);
    }

    return false;
}

function bool IsPointContainedWithin(HUD H, Vector2D TargetPos) {
    if(Super.IsPointContainedWithin(H, TargetPos)) return true;

    //We might still be considered within our hovered component if we have one (ex. a drop-down extends outside of the standard range), check that too
    if(HoveredComponent != None && HoveredComponent.IsPointContainedWithin(H, TargetPos)) return true;

    return false;
}
