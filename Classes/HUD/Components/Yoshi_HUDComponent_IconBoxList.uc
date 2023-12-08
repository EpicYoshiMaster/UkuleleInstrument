class Yoshi_HUDComponent_IconBoxList extends Yoshi_HUDComponent_Parent;

var int MaxPerRow; //Maximum number of items in each row

var float CurItemMargin;
var float ItemMargin; //Scaled by Min(X,Y)
var float ScrollbarSpace;

var float PulsePeriod;
var float PulseScaleAmount;

var Material IconMaterial;

var array<MaterialInstanceConstant> IconMaterials;

var int HoverIndex;

var float ContentSize;
var float ScrollWindowSize;
var float ScrollOffset;
var Yoshi_HUDComponent_Scrollbar Scrollbar;

var delegate<GetArrayTextureDelegate> GetIcons;
var delegate<GetIntValueDelegate> GetValue;
var delegate<SetIntValueDelegate> SetValue;

//These delegates should be overridden with functions to link together external data
delegate array<Texture2D> GetArrayTextureDelegate();
delegate int GetIntValueDelegate();
delegate SetIntValueDelegate(int NewValue);

//TODO: Convey selected item

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
	local int i;
    local MaterialInstanceConstant InstrumentMat;
    local array<Texture2D> AllIcons;

    Scrollbar.GetScrollWindowSize = GetScrollWindowSize;
    Scrollbar.GetContentSize = GetContentSize;
    Scrollbar.GetValue = GetScrollOffset;
    Scrollbar.SetValue = SetScrollOffset;

    Super.Init(MyGameMod, MyMenu, MyOwner);

    AllIcons = GetIcons();

    IconMaterials.Length = 0;

    for(i = 0; i < AllIcons.Length; i++) {
        InstrumentMat = new class'MaterialInstanceConstant';
        InstrumentMat.SetParent(IconMaterial);
        InstrumentMat.SetTextureParameterValue('Texture', AllIcons[i]);

        IconMaterials.AddItem(InstrumentMat);
    }
}

function float GetPulseSize(float BaseSize, float WorldTime, float RowOffset) {
    local float minSize, maxSize;
    local float alpha;

    minSize = BaseSize * (1 - PulseScaleAmount);
    maxSize = BaseSize * (1 + PulseScaleAmount);

    alpha = WorldTime / PulsePeriod;
    alpha += RowOffset / MaxPerRow;

    return Lerp(minSize, maxSize, 0.5 + 0.5 * Sin(2 * Pi * alpha));
}

function RenderStopHover(HUD H) {
    Super.RenderStopHover(H);

    if(HoverIndex > INDEX_NONE) {
        IconMaterials[HoverIndex].SetScalarParameterValue('Hover', 0.0);
    }

    HoverIndex = INDEX_NONE;
}

function Render(HUD H) {
    local int i, rowIndex, NumRows;
    local WorldInfo wi;
    local float posx, posy, marginSize, itemSize, ScrollbarSizeX;

    wi = class'WorldInfo'.static.GetWorldInfo();

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;
    CurItemMargin = ItemMargin * CurScaleX;
    marginSize = CurItemMargin * Min(H.Canvas.ClipX, H.Canvas.ClipY);
    ScrollbarSizeX = ScrollbarSpace * CurScaleX * H.Canvas.ClipX;

    //Items are sized by the maximum number per row minus the space for margins
    itemSize = ((CurScaleX * H.Canvas.ClipX) - (marginSize * (MaxPerRow - 1)) - ScrollbarSizeX) / MaxPerRow;

    NumRows = FCeil(float(IconMaterials.Length) / MaxPerRow);

    ScrollWindowSize = CurScaleY * H.Canvas.ClipY;
    ContentSize = itemSize * NumRows + marginSize * (NumRows - 1);

    Super.Render(H);

    if(MaxPerRow <= 0) return;

    //Mask region GO
    H.Canvas.PushMaskRegion(posx, posy, CurScaleX * H.Canvas.ClipX, CurScaleY * H.Canvas.ClipY);
    
    rowIndex = 0;

    posy -= ScrollOffset;

    for(i = 0; i < IconMaterials.Length; i++) {
        if(rowIndex >= MaxPerRow) {
            rowindex -= MaxPerRow;
            posx = CurTopLeftX * H.Canvas.ClipX;
            posy += itemSize + marginSize;
        }

        RenderIconBox(wi, H, i, rowIndex, posx + 0.5 * itemSize, posy + 0.5 * itemSize, itemSize);

        posx += itemSize + marginSize;
        rowIndex += 1;
    }

    //Mask region... STOP!
    H.Canvas.PopMaskRegion();
}

function RenderIconBox(WorldInfo wi, HUD H, int i, int rowIndex, float centerX, float centerY, float itemSize) {
    local float pulseItemSize;
    local float hoverSize;

    if(i < 0 || i >= IconMaterials.Length) return;

    if(IsComponentHovered) {
        hoverSize = itemSize * (1 + PulseScaleAmount);

        if(IsPointInSpace(H, Menu.GetMousePos(H), centerX, centerY, hoverSize, hoverSize, false)) {

            if(HoverIndex != INDEX_NONE) {
                IconMaterials[HoverIndex].SetScalarParameterValue('Hover', 0.0);
            }

            HoverIndex = i;

            IconMaterials[HoverIndex].SetScalarParameterValue('Hover', 1.0);
        }
    }

    pulseItemSize = GetPulseSize(itemSize, wi.TimeSeconds, rowIndex);

    class'Hat_HUDMenu'.static.DrawCenter(H, centerX, centerY, pulseItemSize, pulseItemSize, IconMaterials[i]);
}

function bool OnClick(EInputEvent EventType)
{
    if(Super.OnClick(EventType)) return true;
    if(EventType != IE_Pressed) return false;

    if(HoverIndex > INDEX_NONE) {
        SetValue(HoverIndex);

        return true;
    }

    return false;
}

function float GetScrollWindowSize() {
    return ScrollWindowSize;
}

function float GetContentSize() {
    return ContentSize;
}

function float GetScrollOffset() {
    return ScrollOffset;
}

function SetScrollOffset(float NewOffset) {
    ScrollOffset = NewOffset;
}

defaultproperties
{
    MaxPerRow=6
    ItemMargin=0.03
    PulsePeriod=4.0
    PulseScaleAmount=0.03
    ScrollbarSpace=0.06
    HoverIndex=INDEX_NONE

    ScrollOffset=0.0

    IconMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Icon_Mat'

    Begin Object Class=Yoshi_HUDComponent_Scrollbar Name=ScrollbarComponent
        TopLeftX=0.97
        TopLeftY=0.0
        ScaleX=0.03
        ScaleY=1.0
    End Object
    Scrollbar=ScrollbarComponent
    Components.Add(ScrollbarComponent);
}
