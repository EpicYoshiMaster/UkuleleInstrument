class Yoshi_HUDComponent_Toggle extends Yoshi_HUDComponent;

//Margin between text and image
var float TextImageMargin;

var string OnPropertyName;
var string OffPropertyName;

var Color TextColor;

var Material ToggleMaterial;

var MaterialInstanceConstant ToggleMat;

//These delegates should be overridden with functions to link together external data
delegate bool GetValue();
delegate SetValue(bool bValue);

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
    local float ImageSize, TextBoxSizeX, TextSizeLengthX, TextSizeLengthY, posx, posy, marginX, MyTextScale, DefaultSize;

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
    posy += 0.5 * CurScaleY * H.Canvas.ClipY;

    TextBoxSizeX = (CurScaleX * H.Canvas.ClipX) - ImageSize - marginX;

    if(TextBoxSizeX <= 0) return;

    DefaultSize = (0.7 / 0.8f);

    H.Canvas.SetDrawColorStruct(TextColor);
    H.Canvas.Font = StandardFont;

    H.Canvas.TextSize(Text, TextSizeLengthX, TextSizeLengthY, DefaultSize, DefaultSize);

    MyTextScale = TextBoxSizeX / TextSizeLengthX;

    if(MyTextScale >= 1) {
        MyTextScale = 1;
    }

    H.Canvas.SetDrawColor(0,255,255,255);

    class'Hat_HUDMenu'.static.DrawCenterLeftText(H.Canvas, Text, posx, posy, MyTextScale, MyTextScale);

    H.Canvas.SetDrawColor(255,0,255,255);

    class'Hat_HUDMenu'.static.DrawCenterLeftText(H.Canvas, Text, posx, posy, MyTextScale * DefaultSize, MyTextScale);

    H.Canvas.SetDrawColor(255,255,0,255);

    class'Hat_HUDMenu'.static.DrawCenterLeftText(H.Canvas, Text, posx, posy, MyTextScale, MyTextScale * DefaultSize);

    H.Canvas.SetDrawColorStruct(TextColor);

    class'Hat_HUDMenu'.static.DrawCenterLeftText(H.Canvas, Text, posx, posy, MyTextScale * DefaultSize, MyTextScale * DefaultSize);

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