class Yoshi_HUDComponent_Base extends Component
	abstract;

var const Font StandardFont;

var Yoshi_UkuleleInstrument_GameMod GameMod;
var Yoshi_HUDMenu_MusicMenu Menu;
var Yoshi_HUDComponent Owner;

//Coordinates are pre-scale
var bool PositionAbsolute;

//State values set relative to owner positions
var float CurTopLeftX;
var float CurTopLeftY;
var float CurScaleX;
var float CurScaleY;

//Internal values determining starting positioning
var float TopLeftX;
var float TopLeftY;
var float ScaleX;
var float ScaleY;
var float TextScale;

//Within the given space of a component, specifies scale to not include the margin region
var float MarginX;
var float MarginY;

//Within subcomponents of this component, specifies the subcomponents scale to not include the padding region
var float PaddingX;
var float PaddingY;

var bool DebugMode;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
	GameMod = MyGameMod;
    Menu = MyMenu;
	Owner = MyOwner;
}

function Close() {
	GameMod = None;
	Menu = None;
	Owner = None;
}

function Tick(HUD H, float delta) {
	
	if(PositionAbsolute || Owner == None) {
		CurTopLeftX = CalcBoxModelTopLeft(0.0, 1.0, 0.0, TopLeftX, MarginX);
		CurTopLeftY = CalcBoxModelTopLeft(0.0, 1.0, 0.0, TopLeftY, MarginY);
		CurScaleX = CalcBoxModelScale(1.0, 0.0, ScaleX, MarginX);
		CurScaleY = CalcBoxModelScale(1.0, 0.0, ScaleY, MarginY);
	}
	else {

		CurTopLeftX = CalcBoxModelTopLeft(Owner.CurTopLeftX, Owner.CurScaleX, Owner.PaddingX, TopLeftX, MarginX);
		CurTopLeftY = CalcBoxModelTopLeft(Owner.CurTopLeftY, Owner.CurScaleY, Owner.PaddingY, TopLeftY, MarginY);
		CurScaleX = CalcBoxModelScale(Owner.CurScaleX, Owner.PaddingX, ScaleX, MarginX);
		CurScaleY = CalcBoxModelScale(Owner.CurScaleY, Owner.PaddingY, ScaleY, MarginY);
	}
}

static function float CalcBoxModelTopLeft(float OwnerTopLeft, float OwnerScale, float OwnerPadding, float TopLeft, float Margin) {
	local float PaddingTopLeft, PaddingScale, PaddingAmount, MarginTopLeft, MarginScale, MarginAmount;

	PaddingAmount = OwnerScale * OwnerPadding;
	PaddingTopLeft = OwnerTopLeft + PaddingAmount;
	PaddingScale = OwnerScale - (2 * PaddingAmount);

	MarginAmount = PaddingScale * Margin;
	MarginTopLeft = PaddingTopLeft + MarginAmount;
	MarginScale = PaddingScale - (2 * MarginAmount);

	return MarginTopLeft + (TopLeft * MarginScale);
}

static function float CalcBoxModelScale(float OwnerScale, float OwnerPadding, float Scale, float Margin) {
	local float PaddingScale, PaddingAmount, MarginScale, MarginAmount;

	PaddingAmount = OwnerScale * OwnerPadding;
	PaddingScale = OwnerScale - (2 * PaddingAmount);

	MarginAmount = PaddingScale * Margin;
	MarginScale = PaddingScale - (2 * MarginAmount);

	return Scale * MarginScale;
}

function Render(HUD H) {
	if(DebugMode) {
		H.Canvas.SetDrawColor(255, 255, 255, 255);
		H.Canvas.SetPos(CurTopLeftX * H.Canvas.ClipX, CurTopLeftY * H.Canvas.CLipY);
		H.Canvas.DrawBox(CurScaleX * H.Canvas.ClipX, CurScaleY * H.Canvas.ClipY);
	}
}

function bool OnPressUp(HUD H, bool bMenu, bool release)
{
	return false;
}

function bool OnPressDown(HUD H, bool bMenu, bool release)
{
	return false;
}

function bool OnPressLeft(HUD H, bool bMenu, bool release)
{
	return false;
}

function bool OnPressRight(HUD H, bool bMenu, bool release)
{
	return false;
}

function bool OnClick(HUD H, bool release)
{
    return false;
}

function bool OnAltClick(HUD H, bool release)
{
    return false;
}

defaultproperties
{
	PositionAbsolute=false
	StandardFont=Font'Yoshi_UkuleleMats_Content.Fonts.LatoBlackStandard'

	DebugMode=false
}