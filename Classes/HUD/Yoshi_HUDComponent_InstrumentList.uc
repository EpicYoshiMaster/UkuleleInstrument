class Yoshi_HUDComponent_InstrumentList extends Yoshi_HUDComponent;

// Pulsating items which alternate with each other
// Material which can accept a texture for the instrument icon
// Partial transparency

//This component needs to pull data from Yoshi_MusicalInstrument classes
//Make a list of instruments with materials / names
//Display the currently selected instrument / change the instrument selection


var int MaxPerRow; //Maximum number of items in each row

//Margin applies to all sides
var float CurItemMargin;
var float ItemMargin; //Scaled by Min(X,Y)

var float PulsePeriod;
var float PulseScaleAmount;

var Material IconMaterial;

var array< class<Yoshi_MusicalInstrument> > InstrumentClasses;
var array<MaterialInstanceConstant> InstrumentMaterials;

var bool FlagUpdateHover;
var int HoverIndex;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
	local int i;
    local MaterialInstanceConstant InstrumentMat;

    Super.Init(MyGameMod, MyMenu, MyOwner);

    InstrumentClasses = class'Yoshi_MusicalInstrument'.static.GetAllInstruments();

    InstrumentMaterials.Length = 0;

    for(i = 0; i < InstrumentClasses.Length; i++) {
        InstrumentMat = new class'MaterialInstanceConstant';
        InstrumentMat.SetParent(IconMaterial);
        InstrumentMat.SetTextureParameterValue('Texture', InstrumentClasses[i].default.Icon);

        InstrumentMaterials.AddItem(InstrumentMat);
    }
}

/*
function Tick(HUD H, float delta) {
    local int i;

    Super.Tick(H, delta);

}*/

function float GetPulseSize(float BaseSize, float WorldTime, float RowOffset) {
    local float minSize, maxSize;
    local float alpha;

    minSize = BaseSize * (1 - PulseScaleAmount);
    maxSize = BaseSize * (1 + PulseScaleAmount);

    alpha = WorldTime / PulsePeriod;
    alpha += RowOffset / MaxPerRow;

    return Lerp(minSize, maxSize, 0.5 + 0.5 * Sin(2 * Pi * alpha));
}

function RenderUpdateHover(HUD H) {
    FlagUpdateHover = true;
}

function RenderStopHover(HUD H) {
    FlagUpdateHover = false;

    if(HoverIndex > INDEX_NONE) {
        InstrumentMaterials[HoverIndex].SetScalarParameterValue('Hover', 0.0);
    }

    HoverIndex = INDEX_NONE;
}

function Render(HUD H) {
    local int i, rowIndex;
    local WorldInfo wi;
    local float posx, posy, marginSize, itemSize;

    Super.Render(H);

    if(MaxPerRow <= 0) return;

    wi = class'WorldInfo'.static.GetWorldInfo();

    CurItemMargin = ItemMargin * CurScaleX;

    marginSize = CurItemMargin * Min(H.Canvas.ClipX, H.Canvas.ClipY);

    //Items are sized by the maximum number per row minus the space for margins
    itemSize = ((CurScaleX * H.Canvas.ClipX) - (marginSize * (MaxPerRow - 1))) / MaxPerRow;

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;
    rowIndex = 0;

    for(i = 0; i < InstrumentClasses.Length; i++) {
        if(rowIndex >= MaxPerRow) {
            rowindex -= MaxPerRow;
            posx = CurTopLeftX * H.Canvas.ClipX;
            posy += itemSize + marginSize;
        }

        RenderInstrumentBox(wi, H, i, rowIndex, posx + 0.5 * itemSize, posy + 0.5 * itemSize, itemSize);

        posx += itemSize + marginSize;
        rowIndex += 1;
    }
}

function RenderInstrumentBox(WorldInfo wi, HUD H, int i, int rowIndex, float centerX, float centerY, float itemSize) {
    local float pulseItemSize;
    local float hoverSize;

    if(i < 0 || i >= InstrumentClasses.Length) return;

    if(FlagUpdateHover) {
        hoverSize = itemSize * (1 + PulseScaleAmount);

        if(IsPointInSpace(H, Menu.GetMousePos(H), centerX, centerY, hoverSize, hoverSize, false)) {

            if(HoverIndex != INDEX_NONE) {
                InstrumentMaterials[HoverIndex].SetScalarParameterValue('Hover', 0.0);
            }

            HoverIndex = i;

            InstrumentMaterials[HoverIndex].SetScalarParameterValue('Hover', 1.0);
        }
    }

    pulseItemSize = GetPulseSize(itemSize, wi.TimeSeconds, rowIndex);

    class'Hat_HUDMenu'.static.DrawCenter(H, centerX, centerY, pulseItemSize, pulseItemSize, InstrumentMaterials[i]);
}

function bool OnClick(HUD H, bool release)
{
    if(!release && HoverIndex > INDEX_NONE) {
        class'GameMod'.static.SaveConfigValue(class'Yoshi_UkuleleInstrument_GameMod', 'Instrument', HoverIndex);

        return true;
    }

    return false;
}

defaultproperties
{
    MaxPerRow=6
    ItemMargin=0.03
    PulsePeriod=4.0
    PulseScaleAmount=0.03
    HoverIndex=INDEX_NONE

    IconMaterial=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Icon_Mat'
}
