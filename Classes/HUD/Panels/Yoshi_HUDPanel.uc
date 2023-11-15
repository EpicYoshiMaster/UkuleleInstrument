class Yoshi_HUDPanel extends Yoshi_HUDComponent_Parent;

var string Title;
var Color TextColor;
var Surface Background;

//We want a specific behavior here
function Render(HUD H) {
    H.Canvas.SetDrawColor(255,255,255,255);

    if(Background != None) {
        class'Hat_HUDMenu'.static.DrawTopLeft(H, CurTopLeftX * H.Canvas.ClipX, CurTopLeftY * H.Canvas.ClipY, CurScaleX * H.Canvas.ClipX, CurScaleY * H.Canvas.ClipY, Background);
    }

    Super.Render(H);

    H.Canvas.SetDrawColorStruct(TextColor);
    H.Canvas.Font = StandardFont;

    if(Title != "") {
        //DrawBorderedTextInBox(H, Title, )
        class'Hat_HUDMenu'.static.DrawText(H.Canvas, Title, CurTopLeftX * H.Canvas.ClipX, CurTopLeftY * H.Canvas.ClipY, TextScale * H.Canvas.ClipY, TextScale * H.Canvas.ClipY, TextAlign_BottomLeft);
    }

    H.Canvas.SetDrawColor(255,255,255,255);    
}

defaultproperties
{
    Title="I forgot to name my panel :(";
    TextColor=(R=255,G=255,B=255,A=255)
    TextScale=0.00045
    Background=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Panel_Bg_Mat'
}