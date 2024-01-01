class Yoshi_HUDComponent_Scrollbar extends Yoshi_HUDComponent;

//Scroll Up/Down support

enum ScrollbarState {
    Scrollbar_None,
    Scrollbar_Top,
    Scrollbar_Hover,
    Scrollbar_Drag,
    Scrollbar_Bottom
};

var float ButtonScale;
var float ButtonScrollAmount;

var float ScrollWindowSize;
var float ContentSize;
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

var float BorderRatio; //X-dimensions

var delegate<GetFloatValueDelegate> GetScrollWindowSize;
var delegate<GetFloatValueDelegate> GetContentSize;
var delegate<GetFloatValueDelegate> GetValue;
var delegate<SetFloatValueDelegate> SetValue;

delegate float GetFloatValueDelegate();
delegate SetFloatValueDelegate(float NewValue);

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Super.Init(MyGameMod, MyMenu, MyOwner);

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
    local float posx, posy, sizeX, sizeY, ButtonSizeY, BarSize, RemainingSize, MaximumPosition, BorderSize;
    local float ScrollOffset;

    Super.Render(H);

    ScrollWindowSize = GetScrollWindowSize();
    ContentSize = GetContentSize();
    ScrollOffset = GetValue();
    MaximumPosition = ContentSize - ScrollWindowSize;

    if(ContentSize <= ScrollWindowSize) {
        if(ScrollOffset > 0.0) {
            SetValue(0.0);
        }
        
        return;
    }

    H.Canvas.SetDrawColor(255,255,255,255);

    BorderSize = BorderRatio * CurScaleX * H.Canvas.ClipX;

    posx = (CurTopLeftX + 0.5 * CurScaleX) * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;
    sizeX = CurScaleX * H.Canvas.ClipX;
    sizeY = CurScaleY * H.Canvas.ClipY;
    RemainingSize = sizeY;

    ButtonSizeY = ButtonScale * sizeY - (2 * BorderSize);

    //Render the Track (over the full space)
    class'Hat_HUDMenu'.static.DrawTopCenter(H, posx, posy, sizeX, sizeY, Track);

    if(ScrollState != Scrollbar_Drag) {
        ScrollState = Scrollbar_None;
    }

    posy += BorderSize;
    sizeX -= 2 * BorderSize;

    //Render the Top Button
    if(ButtonSizeY > 0) {
        if(ScrollState != Scrollbar_Drag && IsPointInSpaceTopCenter(H, Menu.GetMousePos(H), posx, posy, sizeX, ButtonSizeY, false)) {
            ScrollState = Scrollbar_Top;
        }

        TopButton.SetScalarParameterValue('Hover', (ScrollState == Scrollbar_Top ? 1.0 : 0.0));

        class'Hat_HUDMenu'.static.DrawTopCenter(H, posx, posy, sizeX, ButtonSizeY, TopButton);

        RemainingSize -= ButtonSizeY + (2 * BorderSize);
    }

    //Render the Bottom Button
    if(ButtonSizeY > 0) {
        posy = ((CurTopLeftY + CurScaleY) * H.Canvas.ClipY) - ButtonSizeY - (BorderSize);

        if(ScrollState != Scrollbar_Drag && IsPointInSpaceTopCenter(H, Menu.GetMousePos(H), posx, posy, sizeX, ButtonSizeY, false)) {
            ScrollState = Scrollbar_Bottom;
        }

        BottomButton.SetScalarParameterValue('Hover', (ScrollState == Scrollbar_Bottom ? 1.0 : 0.0));

        class'Hat_HUDMenu'.static.DrawTopCenter(H, posx, posy, sizeX, ButtonSizeY, BottomButton);

        RemainingSize -= ButtonSizeY + (2 * BorderSize);
    }

    posy = (CurTopLeftY * H.Canvas.ClipY) + ButtonSizeY + (2 * BorderSize);

    BarSize = (ScrollWindowSize / ContentSize) * RemainingSize;

    //Update the Bar's position if needed
    if(ScrollState == Scrollbar_Drag) {
        ScrollOffset = Lerp(0.0, MaximumPosition, FClamp(((Menu.GetMousePos(H).Y - MouseOffsetToBar) - posy) / (RemainingSize - BarSize), 0.0, 1.0));

        SetValue(ScrollOffset);
    }
    else {
        if(ScrollOffset > MaximumPosition) {
            ScrollOffset = MaximumPosition;
            SetValue(ScrollOffset);
        }
    }

    //Render the Bar
    posy = Lerp(posy, posy + (RemainingSize - BarSize), ScrollOffset / MaximumPosition);

    if(ScrollState != Scrollbar_Drag) {
        MouseOffsetToBar = Menu.GetMousePos(H).Y - posy;

        if(IsPointInSpaceTopCenter(H, Menu.GetMousePos(H), posx, posy, sizeX, BarSize, false)) {
            ScrollState = Scrollbar_Hover;
        }
    }

    Bar.SetScalarParameterValue('Hover', ((ScrollState == Scrollbar_Hover || ScrollState == Scrollbar_Drag) ? 1.0 : 0.0));

    class'Hat_HUDMenu'.static.DrawTopCenter(H, posx, posy, sizeX, BarSize, Bar);
}

function bool OnClick(EInputEvent EventType)
{
    local float MaximumPosition;

    if(Super.OnClick(EventType)) return true;

    if(EventType == IE_Released) {
        ScrollState = Scrollbar_None;
        return true;
    }

    if(EventType != IE_Pressed) return false;

    MaximumPosition = ContentSize - ScrollWindowSize;

    switch(ScrollState) {
        case Scrollbar_Top: 
            SetValue(FClamp(GetValue() - (ButtonScrollAmount * MaximumPosition), 0.0, MaximumPosition)); 
            break;
        case Scrollbar_Bottom: 
            SetValue(FClamp(GetValue() + (ButtonScrollAmount * MaximumPosition), 0.0, MaximumPosition)); 
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
    BorderRatio=0.1

    TopButtonMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Scrollbar_Component_Thumb_Mat'
    BarMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Scrollbar_Component_Thumb_Mat'
    TrackMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Scrollbar_Component_Track_Mat'
    BottomButtonMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Scrollbar_Component_Thumb_Mat'
}