class Yoshi_HUDComponent_Toggle extends Yoshi_HUDComponent;

//Margin between text and image
var float TextImageMargin;

var string OnPropertyName;
var string OffPropertyName;

var Color TextColor;

var Material ToggleMaterial;

var MaterialInstanceConstant ToggleMat;

var delegate<GetValueDelegate> GetValue;
var delegate<SetValueDelegate> SetValue;

//These delegates should be overridden with functions to link together external data
delegate bool GetValueDelegate() {
    return false;
}

delegate SetValueDelegate(bool bValue) {
}

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
    local string Text;
    local float ImageSize, TextBoxSizeX, posx, posy, marginX;

    Super.Render(H);

    Value = GetValue();

    ImageSize = Min(CurScaleX * H.Canvas.ClipX, CurScaleY * H.Canvas.ClipY);
    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;

    ToggleMat.SetScalarParameterValue('Value', (Value ? 1.0 : 0.0));
    ToggleMat.SetScalarParameterValue('Hover', (IsComponentHovered ? 1.0 : 0.0));

    H.Canvas.SetDrawColor(255,255,255,255);

    class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, ImageSize, ImageSize, ToggleMat);

    marginX = (TextImageMargin * CurScaleX * H.Canvas.ClipX);

    Text = (Value ? OnPropertyName : OffPropertyName);
    posx += ImageSize + marginX;

    TextBoxSizeX = (CurScaleX * H.Canvas.ClipX) - ImageSize - marginX;

    if(TextBoxSizeX <= 0) return;

    DrawTextInBox(H, Text, posx, posy, TextBoxSizeX, CurScaleY * H.Canvas.ClipY, TextColor, ElementAlign_Left);

    H.Canvas.SetDrawColor(255,255,255,255);
}

function bool OnClick(HUD H, bool release)
{
    if(Super.OnClick(H, release)) return true;

    if(!release) {
        SetValue(!GetValue());
        return true;
    }

    return false;
}

defaultproperties
{
    TextImageMargin=0.03

    OnPropertyName="On"
    OffPropertyName="Off"

    TextColor=(R=255,G=255,B=255,A=255)

    ToggleMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Toggle_Component_Mat'
}