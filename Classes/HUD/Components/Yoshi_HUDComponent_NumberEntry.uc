class Yoshi_HUDComponent_NumberEntry extends Yoshi_HUDComponent;

var string PropertyName;

var float PropertySpaceX;

var Color TextColor;

var float ElementMargin;

enum NumberEntryHoverState {
    EHover_None,
    EHover_Left,
    EHover_Right,
    EHover_Entry
};

var NumberEntryHoverState HoverState;

var int MinimumValue;
var int MaximumValue;

var int ChangeValue;

var MaterialInstanceConstant LeftButton;
var MaterialInstanceConstant RightButton;

var Material LeftButtonMaterial;
var Material RightButtonMaterial;

var delegate<GetValueDelegate> GetValue;
var delegate<SetValueDelegate> SetValue;

//These delegates should be overridden with functions to link together external data
delegate int GetValueDelegate();
delegate SetValueDelegate(int NewValue);

//var Yoshi_BubbleTalker_InputText_Ukulele BubbleTalker;

//Left and Right button to increment and decrement

//A text entry where you can edit the number


function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Super.Init(MyGameMod, MyMenu, MyOwner);

    LeftButton = new class'MaterialInstanceConstant';
    LeftButton.SetParent(LeftButtonMaterial);

    RightButton = new class'MaterialInstanceConstant';
    RightButton.SetParent(RightButtonMaterial);
}

function RenderStopHover(HUD H) {
    Super.RenderStopHover(H);

    HoverState = EHover_None;
}

function Render(HUD H) {
    local string Text;
    local float ButtonSize, TextBoxSizeX, posx, posy, MarginSpaceX;

    Super.Render(H);

    //Draw Property Text
    /*posx = (CurTopLeftX + PropertySpaceX) * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;

    RemainingScaleX = CurScaleX - PropertySpaceX;*/

    HoverState = EHover_None;

    ButtonSize = CurScaleY * H.Canvas.ClipY;
    
    H.Canvas.SetDrawColor(255,255,255,255);

    //Draw Left Buttton

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;

    if(IsPointInSpaceTopLeft(H, Menu.GetMousePos(H), posx, posy, ButtonSize, ButtonSize, false)) {
        HoverState = EHover_Left;
    }

    LeftButton.SetScalarParameterValue('Hover', (HoverState == EHover_Left ? 1.0 : 0.0));

    class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, ButtonSize, ButtonSize, LeftButton);

    //Draw Right Button

    posx = posx + (CurScaleX * H.Canvas.ClipX);

    if(IsPointInSpaceTopRight(H, Menu.GetMousePos(H), posx, posy, ButtonSize, ButtonSize, false)) {
        HoverState = EHover_Right;
    }

    RightButton.SetScalarParameterValue('Hover', (HoverState == EHover_Right ? 1.0 : 0.0));

    class'Hat_HUDMenu'.static.DrawTopRight(H, posx, posy, ButtonSize, ButtonSize, RightButton);

    //Draw Number Entry

    MarginSpaceX = (ElementMargin * CurScaleX * H.Canvas.ClipX);

    posx = (CurTopLeftX * H.Canvas.ClipX) + ButtonSize + MarginSpaceX;
    TextBoxSizeX = (CurScaleX * H.Canvas.ClipX) - (2 * ButtonSize) - (2 * MarginSpaceX);

    Text = string(GetValue());    

    if(TextBoxSizeX <= 0) return;

    DrawTextInBox(H, Text, posx, posy, TextBoxSizeX, CurScaleY * H.Canvas.ClipY, TextColor, ElementAlign_Center);

    H.Canvas.SetDrawColor(255,255,255,255);
}

function bool OnClick(HUD H, bool release)
{
    if(Super.OnClick(H, release)) return true;

    if(!release) {
        switch(HoverState) {
            case EHover_None: break;
            case EHover_Left: SetValue(FClamp(GetValue() - ChangeValue, MinimumValue, MaximumValue)); break;
            case EHover_Right: SetValue(FClamp(GetValue() + ChangeValue, MinimumValue, MaximumValue)); break;
            case Ehover_Entry: break;
        }

        return true;
    }

    return false;
}

defaultproperties
{
    ElementMargin=0.03
    MinimumValue=0
    MaximumValue=100
    ChangeValue=1
    PropertyName="Number Entry"
    PropertySpaceX=0.4

    TextColor=(R=255,G=255,B=255,A=255)

    LeftButtonMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Toggle_Component_Mat'
    RightButtonMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Toggle_Component_Mat'
}