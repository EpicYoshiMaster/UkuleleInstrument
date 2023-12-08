class Yoshi_HUDComponent_Toggle extends Yoshi_HUDComponent;

var Material ToggleMaterial;

var MaterialInstanceConstant ToggleMat;

var delegate<GetValueDelegate> GetValue;
var delegate<SetValueDelegate> SetValue;

//These delegates should be overridden with functions to link together external data
delegate bool GetValueDelegate();
delegate SetValueDelegate(bool bValue);

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    local bool Value;

    Super.Init(MyGameMod, MyMenu, MyOwner);

    Value = GetValue();

    ToggleMat = new class'MaterialInstanceConstant';
    ToggleMat.SetParent(ToggleMaterial);
    ToggleMat.SetScalarParameterValue('Value', (Value ? 1.0 : 0.0));
}

function Render(HUD H) {
    local bool Value;
    local float posx, posy, ImageSize;

    Super.Render(H);

    Value = GetValue();

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;
    ImageSize = Min(CurScaleX * H.Canvas.ClipX, CurScaleY * H.Canvas.ClipY);
    
    ToggleMat.SetScalarParameterValue('Value', (Value ? 1.0 : 0.0));
    ToggleMat.SetScalarParameterValue('Hover', (IsComponentHovered ? 1.0 : 0.0));

    H.Canvas.SetDrawColor(255,255,255,255);

    class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, ImageSize, ImageSize, ToggleMat);

    H.Canvas.SetDrawColor(255,255,255,255);
}

function bool OnClick(EInputEvent EventType)
{
    if(Super.OnClick(EventType)) return true;

    if(EventType == IE_Pressed) {
        SetValue(!GetValue());
        return true;
    }

    return false;
}

defaultproperties
{
    ToggleMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Toggle_Component_Mat'
}