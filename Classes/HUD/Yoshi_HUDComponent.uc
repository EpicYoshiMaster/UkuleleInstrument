class Yoshi_HUDComponent extends Yoshi_HUDComponent_Base;

enum ElementAlign {
    ElementAlign_TopLeft,
    ElementAlign_Top,
    ElementAlign_TopRight,
    ElementAlign_Left,
    ElementAlign_Center,
    ElementAlign_Right,
    ElementAlign_BottomLeft,
    ElementAlign_Bottom,
    ElementAlign_BottomRight
};

var bool IsComponentHovered;

function RenderUpdateHover(HUD H) {
    IsComponentHovered = true;
}

function RenderStopHover(HUD H) {
    IsComponentHovered = false;
}

static function DrawBorderedTextInBox(
    HUD H, 
    coerce string Text,
    float BoxTopLeftX, 
    float BoxTopLeftY, 
    float BoxScaleX, 
    float BoxScaleY,
    Color TextColor,
    optional ElementAlign Align = ElementAlign_TopLeft,
    optional float TextSize = 1.0f,
    optional bool Shadow, 
    optional float ShadowAlpha = 0.5, 
    float BorderWidth = 4.0, 
    optional Color BorderColor, 
    optional float VerticalSize = -1, 
    optional float BorderQuality = 1
) {
    local float PosX, PosY, TextLengthX, TextLengthY, FinalTextScale;

    PosX = BoxTopLeftX;
    PosY = BoxTopLeftY;

    H.Canvas.TextSize(Text, TextLengthX, TextLengthY, TextSize, TextSize);

    //TextLengthX and TextLengthY describe the size of the text in pixels

    switch(Align) {
        case ElementAlign_TopLeft: 
            break; //easy
        case ElementAlign_Top: 
            PosX += (0.5 * BoxScaleX) - (0.5 * TextLengthX);
            break;
        case ElementAlign_TopRight: 
            PosX += BoxScaleX - TextLengthX;
            break;
        
        case ElementAlign_Left: 
            PosY += (0.5 * BoxScaleY) - (0.5 * TextLengthY); 
            break;
        case ElementAlign_Center: 
            PosX += (0.5 * BoxScaleX) - (0.5 * TextLengthX); 
            PosY += 0.5 * BoxScaleY - (0.5 * TextLengthY);
            break;
        case ElementAlign_Right: 
            PosX += BoxScaleX - TextLengthX;
            PosY += (0.5 * BoxScaleY) - (0.5 * TextLengthY);
            break;

        case ElementAlign_BottomLeft: 
            PosY += BoxScaleY - TextLengthY;
            break;
        case ElementAlign_Bottom: 
            PosX += (0.5 * BoxScaleX) - (0.5 * TextLengthX);
            PosY += BoxScaleY - TextLengthY;
            break;
        case ElementAlign_BottomRight: 
            PosX += BoxScaleX - TextLengthX;
            PosY += BoxScaleY - TextLengthY;
            break;
    }

    H.Canvas.SetDrawColorStruct(TextColor);

    H.Canvas.Font = default.StandardFont;

    FinalTextScale = BoxScaleX / TextLengthX;

    if(FinalTextScale >= 1) {
        FinalTextScale = 1;
    }

    class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, Text, PosX, PosY, FinalTextScale * TextSize, Shadow, TextAlign_Left, ShadowAlpha, BorderWidth, BorderColor, VerticalSize, BorderQuality);

    H.Canvas.SetDrawColor(255,255,255,255);
}

static function DrawTextInBox(
    HUD H, 
    coerce string Text, 
    float BoxTopLeftX, 
    float BoxTopLeftY, 
    float BoxScaleX, 
    float BoxScaleY,
    Color TextColor,
    optional ElementAlign Align = ElementAlign_TopLeft,
    optional float TextSize = 1.0f
) {
    local float PosX, PosY, TextLengthX, TextLengthY, FinalTextScale;

    PosX = BoxTopLeftX;
    PosY = BoxTopLeftY;

    H.Canvas.TextSize(Text, TextLengthX, TextLengthY, TextSize, TextSize);

    switch(Align) {
        case ElementAlign_TopLeft: 
            break; //easy
        case ElementAlign_Top: 
            PosX += (0.5 * BoxScaleX) - (0.5 * TextLengthX);
            break;
        case ElementAlign_TopRight: 
            PosX += BoxScaleX - TextLengthX;
            break;
        
        case ElementAlign_Left: 
            PosY += (0.5 * BoxScaleY) - (0.5 * TextLengthY); 
            break;
        case ElementAlign_Center: 
            PosX += (0.5 * BoxScaleX) - (0.5 * TextLengthX); 
            PosY += 0.5 * BoxScaleY - (0.5 * TextLengthY);
            break;
        case ElementAlign_Right: 
            PosX += BoxScaleX - TextLengthX;
            PosY += (0.5 * BoxScaleY) - (0.5 * TextLengthY);
            break;

        case ElementAlign_BottomLeft: 
            PosY += BoxScaleY - TextLengthY;
            break;
        case ElementAlign_Bottom: 
            PosX += (0.5 * BoxScaleX) - (0.5 * TextLengthX);
            PosY += BoxScaleY - TextLengthY;
            break;
        case ElementAlign_BottomRight: 
            PosX += BoxScaleX - TextLengthX;
            PosY += BoxScaleY - TextLengthY;
            break;
    }

    H.Canvas.SetDrawColorStruct(TextColor);
    H.Canvas.Font = default.StandardFont;

    FinalTextScale = BoxScaleX / TextLengthX;

    if(FinalTextScale >= 1) {
        FinalTextScale = 1;
    }

    class'Hat_HUDMenu'.static.DrawCenterLeftText(H.Canvas, Text, posx, posy, FinalTextScale * TextSize, FinalTextScale * TextSize);

    H.Canvas.SetDrawColor(255,255,255,255);
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

static function bool IsPointInSpaceTopRight(HUD H, Vector2D TargetPos, float StartX, float StartY, float SizeX, float SizeY, bool applyclips) {
    return IsPointInSpaceTopLeft(H, TargetPos, StartX - SizeX, StartY, SizeX, SizeY, applyclips);
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