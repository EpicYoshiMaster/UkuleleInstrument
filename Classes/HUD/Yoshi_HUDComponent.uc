class Yoshi_HUDComponent extends Yoshi_HUDComponent_Base;

var bool IsComponentHovered;

function RenderUpdateHover(HUD H) {
    IsComponentHovered = true;
}

function RenderStopHover(HUD H) {
    IsComponentHovered = false;
}

//Maximize Y
//Clamp by X

static function DrawBorderedTextInBox(
    HUD H, 
    coerce string Text,
    float TextTopLeftX, 
    float TextTopLeftY, 
    float TextScaleX, 
    float TextScaleY,
    Color TextColor,
    optional TextAlign Align = TextAlign_Center,
    optional bool Shadow, 
    optional float ShadowAlpha = 0.5, 
    float BorderWidth = 4.0, 
    optional Color BorderColor, 
    optional float VerticalSize = -1, 
    optional float BorderQuality = 1
) {
    local float PosX, PosY, TextLengthX, TextLengthY, FinalTextScale, DefaultSize;

    PosX = TextTopLeftX;
    PosY = TextTopLeftY;

    switch(Align) {
        case TextAlign_TopLeft: break; //easy
        case TextAlign_Left: break; //need to handle this
        case TextAlign_BottomLeft: PosY += TextScaleY; break;

        case TextAlign_Center: PosX += 0.5 * TextScaleX; PosY += 0.5 * TextScaleY; break;

        //case TextAlign_TopRight: PosX += TextScaleX; break; hah top right doesn't exist!!!!!!!
        case TextAlign_Right: break; //need to handle this (it does top right)
        case TextAlign_BottomRight: PosX += TextScaleX; PosY += TextScaleY; break;
    }

    H.Canvas.SetDrawColorStruct(TextColor);

    DefaultSize = (0.7 / 0.8f);

    H.Canvas.TextSize(Text, TextLengthX, TextLengthY, DefaultSize, DefaultSize);

    //Text Align Left draws top left, re-position for top-left positioning
    //Text Align Right draws top right, re-position for top-right

    FinalTextScale = TextScaleX / TextLengthX;

    if(FinalTextScale >= 1) {
        FinalTextScale = 1;
    }

    class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, Text, PosX, PosY, FinalTextScale * DefaultSize, Shadow, Align, ShadowAlpha, BorderWidth, BorderColor, VerticalSize, BorderQuality);

    H.Canvas.SetDrawColor(255,255,255,255);
}

static function DrawTextInBox(HUD H, coerce string Text, float TextTopLeftX, float TextTopLeftY, float TextScaleX, float TextScaleY, optional TextAlign Align = TextAlign_Center) {

}

static function bool IsPointInSpaceTopLeft(HUD H, Vector2D TargetPos, float StartX, float StartY, float SizeX, float SizeY, bool applyclips) {
    local float EndX, EndY;

    if(applyclips) {
        StartX *= H.Canvas.ClipX;
        StartY *= H.Canvas.ClipY;
        EndX = StartX + (SizeX * H.Canvas.ClipX);
        EndY = StartY + (SizeY * H.Canvas.ClipY);        
    }
    else {
        EndX = (StartX + SizeX);
        EndY = (StartY + SizeY);
    }

    if(TargetPos.X < StartX) return false;
    if(TargetPos.Y < StartY) return false;
    if(TargetPos.X > EndX) return false;
    if(TargetPos.Y > EndY) return false;

    return true;
}

static function bool IsPointInSpace(HUD H, Vector2D TargetPos, float StartX, float StartY, float SizeX, float SizeY, bool applyclips) {
    return IsPointInSpaceTopLeft(H, TargetPos, StartX - (0.5 * SizeX), StartY - (0.5 * SizeY), SizeX, SizeY, applyclips);
}

function bool IsPointContainedWithin(HUD H, Vector2D TargetPos) {
    return IsPointInSpaceTopLeft(H, TargetPos, CurTopLeftX, CurTopLeftY, CurScaleX, CurScaleY, true);
}

defaultproperties
{
    IsComponentHovered=false
}