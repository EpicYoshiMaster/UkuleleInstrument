class Yoshi_HUDComponent_DropDown extends Yoshi_HUDComponent;

var bool ShouldRefreshOptions; //Whether or not the options values could potentially change to avoid calling for them repeatedly
var float MarginClippingThreshold; //% of ClipY the dropdown should at most be able to touch (set to 0 for stopping perfectly at the edge)
var int MaxItemsDisplayed;

var delegate<GetOptionsDelegate> GetOptions;
var delegate<GetValueDelegate> GetValue;
var delegate<SetValueDelegate> SetValue;

var bool IsFocused;
var int HoverOption;
var array<string> Options;

var MaterialInstanceConstant OptionMat;
var MaterialInstanceConstant OptionHoveredMat;

var Material OptionMaterial;

var Color TextColor;

//These delegates should be overridden with functions to link together external data
delegate array<string> GetOptionsDelegate();
delegate int GetValueDelegate();
delegate SetValueDelegate(int NewValue);

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Super.Init(MyGameMod, MyMenu, MyOwner);

    Options = GetOptions();

    OptionMat = new class'MaterialInstanceConstant';
    OptionMat.SetParent(OptionMaterial);

    OptionHoveredMat = new class'MaterialInstanceConstant';
    OptionHoveredMat.SetParent(OptionMaterial);
    OptionHoveredMat.SetScalarParameterValue('Hover', 1.0);
}

function RenderStopHover(HUD H) {
    Super.RenderStopHover(H);

    IsFocused = false;
    HoverOption = INDEX_NONE;
}

function Render(HUD H) {
    local int i;
    local string OptionText;
    local int NumberItemsToDisplay, SelectedOption;
    local float FullSizeY;
    local float ItemSizeX, ItemSizeY, posx, posy;
    local MaterialInstanceConstant RenderMaterial;

    Super.Render(H);

    if(ShouldRefreshOptions) {
        Options = GetOptions();
    }

    SelectedOption = GetValue();

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;
    ItemSizeX = CurScaleX * H.Canvas.ClipX;
    ItemSizeY = CurScaleY * H.Canvas.ClipY;

    HoverOption = INDEX_NONE;

    //Currently Selected Item
    OptionText = (SelectedOption != INDEX_NONE ? Options[SelectedOption] : "Null");

    class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, ItemSizeX, ItemSizeY, OptionMat);
    DrawTextInBox(H, OptionText, posx, posy, ItemSizeX, ItemSizeY, TextColor, ElementAlign_Center);

    if(!IsFocused) return;

    //The Drop-Down

    posy += ItemSizeY;

    NumberItemsToDisplay = Min(Options.Length, MaxItemsDisplayed);
    FullSizeY = NumberItemsToDisplay * ItemSizeY;

    //Minimize the display of items until it fits
    while(NumberItemsToDisplay > 0 && posy + FullSizeY > H.Canvas.ClipY * (1 - MarginClippingThreshold)) {
        NumberItemsToDisplay--;
        FullSizeY = NumberItemsToDisplay * ItemSizeY;
    }

    for(i = 0; i < NumberItemsToDisplay; i++) {
        if(IsPointInSpaceTopLeft(H, Menu.GetMousePos(H), posx, posy, ItemSizeX, ItemSizeY, false)) {
            HoverOption = i;
            RenderMaterial = OptionHoveredMat;
        }
        else {
            RenderMaterial = OptionMat;
        }

        class'Hat_HUDMenu'.static.DrawTopLeft(H, posx, posy, ItemSizeX, ItemSizeY, RenderMaterial);

        DrawTextInBox(H, Options[i], posx, posy, ItemSizeX, ItemSizeY, TextColor, ElementAlign_Center);

        posy += ItemSizeY;
    }

    H.Canvas.SetDrawColor(255,255,255,255);
}

function bool OnClick(HUD H, bool release)
{
    if(Super.OnClick(H, release)) return true;
    if(release) return false;

    if(!IsFocused) {
        IsFocused = true;
    }
    else if(HoverOption == INDEX_NONE) {
        IsFocused = false;
    }
    else {
        SetValue(HoverOption);
        IsFocused = false;
    }

    return true;
}

function bool IsPointContainedWithin(HUD H, Vector2D TargetPos) {
    if(IsFocused) return true; //When focused make this component always be hovered

    return Super.IsPointContainedWithin(H, TargetPos);
}

defaultproperties
{
    ShouldRefreshOptions=false
    MaxItemsDisplayed=15
    MarginClippingThreshold=0.01

    TextColor=(R=255,G=255,B=255,A=255)

    OptionMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Toggle_Component_Mat'
}