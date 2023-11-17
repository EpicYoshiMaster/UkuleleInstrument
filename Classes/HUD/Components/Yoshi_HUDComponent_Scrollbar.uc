class Yoshi_HUDComponent_Scrollbar extends Yoshi_HUDComponent;

enum ScrollbarState {
    Scrollbar_None,
    Scrollbar_Top,
    Scrollbar_Hover,
    Scrollbar_Drag,
    Scrollbar_Bottom
};

//Do we need to refresh every frame for a dynamic window size / maximum offset?
var bool ShouldRefresh;
var float ButtonScale;
var float ButtonScrollAmount;

var float ScrollWindowSize;
var float MaximumOffset;
var float MouseOffsetToBar;
var ScrollbarState ScrollState;

var MaterialInstanceConstant TopButton;
var MaterialInstanceConstant Bar;
var MaterialInstanceConstant Track;
var MaterialInstanceConstant BottomButton;

var Material TopButtonMaterial;
var Material BarMaterial;
var Material TrackMaterial;
var Material BottomButtonMaterial;

var delegate<GetFloatValueDelegate> GetScrollWindowSize;
var delegate<GetFloatValueDelegate> GetMaximumOffset;
var delegate<GetFloatValueDelegate> GetValue;
var delegate<SetFloatValueDelegate> SetValue;

delegate float GetFloatValueDelegate();
delegate SetFloatValueDelegate(float NewValue);

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Super.Init(MyGameMod, MyMenu, MyOwner);

    ScrollWindowSize = GetScrollWindowSize();
    MaximumOffset = GetMaximumOffset();

    TopButton = new class'MaterialInstanceConstant';
    TopButton.SetParent(TopButtonMaterial);

    Bar = new class'MaterialInstanceConstant';
    Bar.SetParent(BarMaterial);

    Track = new class'MaterialInstanceConstant';
    Track.SetParent(TrackMaterial);

    BottomButton = new class'MaterialInstanceConstant';
    BottomButton.SetParent(BottomButtonMaterial);
}

function RenderStopHover(HUD H) {
    Super.RenderStopHover(H);

    ScrollState = Scrollbar_None;
}

function Render(HUD H) {
    local float posx, posy, sizeX, sizeY, ButtonSizeY, BarSize, RemainingSize;
    local float ScrollOffset;

    Super.Render(H);

    H.Canvas.SetDrawColor(255,255,255,255);

    if(ShouldRefresh) {
        ScrollWindowSize = GetScrollWindowSize();
        MaximumOffset = GetMaximumOffset();
    }

    ScrollOffset = GetValue();

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;
    sizeX = CurScaleX * H.Canvas.ClipX;
    sizeY = CurScaleY * H.Canvas.ClipY;
    RemainingSize = sizeY;
    ButtonSizeY = ButtonScale * sizeY;

    if(ScrollState != Scrollbar_Drag) {
        ScrollState = Scrollbar_None;
    }

    //Render the Top Button
    if(ButtonSizeY > 0) {
        if(ScrollState != Scrollbar_Drag && IsPointInSpaceTopLeft(H, Menu.GetMousePos(H), posx, posy, sizeX, ButtonSizeY, false)) {
            ScrollState = Scrollbar_Top;
        }

        TopButton.SetScalarParameterValue('Hover', (ScrollState == Scrollbar_Top ? 1.0 : 0.0));

        class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, sizeX, ButtonSizeY, TopButton);

        RemainingSize -= ButtonSizeY;
    }

    //Render the Bottom Button
    if(ButtonSizeY > 0) {
        posy += sizeY - ButtonSizeY;

        if(ScrollState != Scrollbar_Drag && IsPointInSpaceTopLeft(H, Menu.GetMousePos(H), posx, posy, sizeX, ButtonSizeY, false)) {
            ScrollState = Scrollbar_Bottom;
        }

        BottomButton.SetScalarParameterValue('Hover', (ScrollState == Scrollbar_Bottom ? 1.0 : 0.0));

        class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, sizeX, ButtonSizeY, BottomButton);

        RemainingSize -= ButtonSizeY;
    }

    posy = (CurTopLeftY * H.Canvas.ClipY) + ButtonSizeY;

    //Render the Track
    class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, sizeX, RemainingSize, Track);

    BarSize = (ScrollWindowSize / MaximumOffset) * RemainingSize;

    //Update the Bar's position if needed
    if(ScrollState == Scrollbar_Drag) {
        ScrollOffset = Lerp(0.0, MaximumOffset, FClamp(((Menu.GetMousePos(H).Y - MouseOffsetToBar) - posy) / (RemainingSize - BarSize), 0.0, 1.0));

        SetValue(ScrollOffset);
    }

    //Render the Bar
    posy = Lerp(posy, posy + (RemainingSize - BarSize), ScrollOffset / MaximumOffset);

    if(ScrollState != Scrollbar_Drag) {
        MouseOffsetToBar = Menu.GetMousePos(H).Y - posy;

        if(IsPointInSpaceTopLeft(H, Menu.GetMousePos(H), posx, posy, sizeX, BarSize, false)) {
            ScrollState = Scrollbar_Hover;
        }
    }

    Bar.SetScalarParameterValue('Hover', ((ScrollState == Scrollbar_Hover || ScrollState == Scrollbar_Drag) ? 1.0 : 0.0));

    class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, sizeX, BarSize, Bar);
}

function bool OnClick(HUD H, bool release)
{
    if(Super.OnClick(H, release)) return true;

    if(release) {
        ScrollState = Scrollbar_None;
        return true;
    }

    switch(ScrollState) {
        case Scrollbar_Top: 
            SetValue(FClamp(GetValue() - (ButtonScrollAmount * MaximumOffset), 0.0, MaximumOffset)); 
            break;
        case Scrollbar_Bottom: 
            SetValue(FClamp(GetValue() + (ButtonScrollAmount * MaximumOffset), 0.0, MaximumOffset)); 
            break;
        case Scrollbar_Hover: 
            ScrollState = Scrollbar_Drag; 
            break;
        case Scrollbar_Drag: 
            break; //That shouldn't really happen
    }

    return true;
}

function bool IsPointContainedWithin(HUD H, Vector2D TargetPos) {
    if(ScrollState == Scrollbar_Drag) return true;

    return Super.IsPointContainedWithin(H, TargetPos);
}

defaultproperties
{
    ButtonScale=0.05
    ButtonScrollAmount=0.1;

    ShouldRefresh=false
    TopButtonMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Toggle_Component_Mat'
    BarMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Toggle_Component_Mat'
    TrackMaterial=Material'HatInTime_Levels.Materials.Black'
    BottomButtonMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Toggle_Component_Mat'
}