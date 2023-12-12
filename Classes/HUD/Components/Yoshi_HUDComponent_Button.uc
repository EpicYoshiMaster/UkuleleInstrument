class Yoshi_HUDComponent_Button extends Yoshi_HUDComponent_Parent;

var bool MakeSquare;

var MaterialInstanceConstant Button;
var Material ButtonMaterial;

var delegate<OnClickButtonDelegate> OnClickButton;

delegate OnClickButtonDelegate();

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Super.Init(MyGameMod, MyMenu, MyOwner);

    Button = new class'MaterialInstanceConstant';
    Button.SetParent(ButtonMaterial);
}

function Render(HUD H) {
    local float ButtonSizeX, ButtonSizeY, posx, posy;

    if(MakeSquare) {
        ButtonSizeX = CurScaleY * H.Canvas.ClipY;
        ButtonSizeY = ButtonSizeX;
    }
    else {
        ButtonSizeX = CurScaleX * H.Canvas.ClipX;
        ButtonSizeY = CurScaleY * H.Canvas.ClipY;
    }
    
    H.Canvas.SetDrawColor(255,255,255,255);

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;

    Button.SetScalarParameterValue('Hover', (IsComponentHovered ? 1.0 : 0.0));

    class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, ButtonSizeX, ButtonSizeY, Button);

    H.Canvas.SetDrawColor(255,255,255,255);

    Super.Render(H);
}

function bool OnClick(EInputEvent EventType)
{
    if(Super.OnClick(EventType)) return true;
    if(EventType != IE_Pressed) return false;

    OnClickButton();

    return true;
}

defaultproperties
{
    MakeSquare=true
    ButtonMaterial=Material'Yoshi_UkuleleMats_Content.Materials.DropDown_Component_Mat'