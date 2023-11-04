class Yoshi_HUDComponent extends Yoshi_HUDComponent_Base;

function RenderUpdateHover(HUD H) {

}

function RenderStopHover(HUD H) {

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