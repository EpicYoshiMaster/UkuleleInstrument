class Yoshi_HUDComponent_Text extends Yoshi_HUDComponent_Parent;

var bool UseBorderedText;

var string Text;
var ElementAlign TextAlignment;
var Color TextColor;
var float BaseTextSize;

var bool Shadow;
var float ShadowAlpha;
var float BorderWidth;
var Color BorderColor;
var float VerticalSize;
var float BorderQuality;

function Render(HUD H) {
    local float posx, posy, boxX, boxY;

    Super.Render(H);

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;
    boxX = CurScaleX * H.Canvas.ClipX;
    boxY = CurScaleY * H.Canvas.ClipY;

    if(!UseBorderedText) {
        DrawTextInBox(H, Text, posx, posy, boxX, boxY, TextColor, TextAlignment, BaseTextSize);
    }   
    else {
        DrawBorderedTextInBox(H, Text, posx, posy, boxX, boxY, TextColor, TextAlignment, BaseTextSize, Shadow, ShadowAlpha, BorderWidth, BorderColor, VerticalSize, BorderQuality);
    }
}

defaultproperties
{
    Text="Hello"
    TextAlignment=ElementAlign_Right
    TextColor=(R=255,G=255,B=255,A=255)
    BaseTextSize=1.0f
    ShadowAlpha=0.5f
    BorderWidth=4.0f
    BorderColor=(R=0,G=0,B=0,A=255)
    VerticalSize=-1
    BorderQuality=1

    MarginX=0.03
    MarginY=0.03
}