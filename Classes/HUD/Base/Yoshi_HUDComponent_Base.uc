class Yoshi_HUDComponent_Base extends Component
	abstract;

const HatConfirm = "Hat_Menu_Confirm";
const HatCancel = "Hat_Menu_Cancel";
const HatPageLeft = "Hat_Menu_PageLeft";
const HatPageRight = "Hat_Menu_PageRight";
const HatUp = "Hat_Hotkey_Up";
const HatDown = "Hat_Hotkey_Down";
const HatLeft = "Hat_Hotkey_Left";
const HatRight = "Hat_Hotkey_Right";

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
var bool AbsoluteMargin;
var float MarginX;
var float MarginY;

//Within subcomponents of this component, specifies the subcomponents scale to not include the padding region
var bool AbsolutePadding;
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
		CurTopLeftX = CalcBoxModelTopLeft(0.0, 1.0, 0.0, TopLeftX, ScaleX, MarginX, false, AbsoluteMargin);
		CurTopLeftY = CalcBoxModelTopLeft(0.0, 1.0, 0.0, TopLeftY, ScaleY, MarginY, false, AbsoluteMargin);
		CurScaleX = CalcBoxModelScale(1.0, 0.0, ScaleX, MarginX, false, AbsoluteMargin);
		CurScaleY = CalcBoxModelScale(1.0, 0.0, ScaleY, MarginY, false, AbsoluteMargin);
	}
	else {
		CurTopLeftX = CalcBoxModelTopLeft(Owner.CurTopLeftX, Owner.CurScaleX, Owner.PaddingX, TopLeftX, ScaleX, MarginX, Owner.AbsolutePadding, AbsoluteMargin);
		CurTopLeftY = CalcBoxModelTopLeft(Owner.CurTopLeftY, Owner.CurScaleY, Owner.PaddingY, TopLeftY, ScaleY, MarginY, Owner.AbsolutePadding, AbsoluteMargin);
		CurScaleX = CalcBoxModelScale(Owner.CurScaleX, Owner.PaddingX, ScaleX, MarginX, Owner.AbsolutePadding, AbsoluteMargin);
		CurScaleY = CalcBoxModelScale(Owner.CurScaleY, Owner.PaddingY, ScaleY, MarginY, Owner.AbsolutePadding, AbsoluteMargin);
	}
}

static function float CalcBoxModelTopLeft(float OwnerTopLeft, float OwnerScale, float OwnerPadding, float TopLeft, float Scale, float Margin, bool AbsPadding, bool AbsMargin) {
	local float PaddingTopLeft, PaddingScale, PaddingAmount, MarginTopLeft, MarginAmount;

	PaddingAmount = (AbsPadding ? 1.0f : OwnerScale) * OwnerPadding;
	PaddingTopLeft = OwnerTopLeft + PaddingAmount;
	PaddingScale = OwnerScale - (2 * PaddingAmount);

	TopLeft = PaddingTopLeft + (TopLeft * PaddingScale);
	Scale = Scale * PaddingScale;

	MarginAmount = (AbsMargin ? 1.0f : Scale) * Margin;
	MarginTopLeft = TopLeft + MarginAmount;

	return MarginTopLeft;
}

static function float CalcBoxModelScale(float OwnerScale, float OwnerPadding, float Scale, float Margin, bool AbsPadding, bool AbsMargin) {
	local float PaddingScale, PaddingAmount, MarginScale, MarginAmount;

	PaddingAmount = (AbsPadding ? 1.0f : OwnerScale) * OwnerPadding;
	PaddingScale = OwnerScale - (2 * PaddingAmount);

	Scale = Scale * PaddingScale;

	MarginAmount = (AbsMargin ? 1.0f : Scale) * Margin;
	MarginScale = Scale - (2 * MarginAmount);

	return MarginScale;
}

function Render(HUD H) {
	local float PadX, PadY, PadScaleX, PadScaleY, MarX, MarY, MarScaleX, MarScaleY;

	if(DebugMode) {
		PadX = CalcBoxModelTopLeft(Owner.CurTopLeftX, Owner.CurScaleX, Owner.PaddingX, 0.0, 1.0, 0.0, Owner.AbsolutePadding, AbsoluteMargin);
		PadY = CalcBoxModelTopLeft(Owner.CurTopLeftY, Owner.CurScaleY, Owner.PaddingY, 0.0, 1.0, 0.0, Owner.AbsolutePadding, AbsoluteMargin);
		PadScaleX = CalcBoxModelScale(Owner.CurScaleX, Owner.PaddingX, 1.0, 0.0, Owner.AbsolutePadding, AbsoluteMargin);
		PadScaleY = CalcBoxModelScale(Owner.CurScaleY, Owner.PaddingY, 1.0, 0.0, Owner.AbsolutePadding, AbsoluteMargin);

		H.Canvas.SetDrawColor(255, 0, 0, 255);
		H.Canvas.SetPos(PadX * H.Canvas.ClipX, PadY * H.Canvas.ClipY);
		H.Canvas.DrawBox(PadScaleX * H.Canvas.ClipX, PadScaleY * H.Canvas.ClipY);

		MarX = CalcBoxModelTopLeft(Owner.CurTopLeftX, Owner.CurScaleX, Owner.PaddingX, 0.0, 1.0, MarginX, Owner.AbsolutePadding, AbsoluteMargin);
		MarY = CalcBoxModelTopLeft(Owner.CurTopLeftY, Owner.CurScaleY, Owner.PaddingY, 0.0, 1.0, MarginY, Owner.AbsolutePadding, AbsoluteMargin);
		MarScaleX = CalcBoxModelScale(Owner.CurScaleX, Owner.PaddingX, 1.0, MarginX, Owner.AbsolutePadding, AbsoluteMargin);
		MarScaleY = CalcBoxModelScale(Owner.CurScaleY, Owner.PaddingY, 1.0, MarginY, Owner.AbsolutePadding, AbsoluteMargin);

		H.Canvas.SetDrawColor(0, 255, 0, 255);
		H.Canvas.SetPos(MarX * H.Canvas.ClipX, MarY * H.Canvas.ClipY);
		H.Canvas.DrawBox(MarScaleX * H.Canvas.ClipX, MarScaleY * H.Canvas.ClipY);

		H.Canvas.SetDrawColor(255, 255, 255, 255);
		H.Canvas.SetPos(CurTopLeftX * H.Canvas.ClipX, CurTopLeftY * H.Canvas.ClipY);
		H.Canvas.DrawBox(CurScaleX * H.Canvas.ClipX, CurScaleY * H.Canvas.ClipY);
	}
}

//Generic event for getting any input key
function bool OnInputKey(string KeyName, EInputEvent EventType) {

	switch(KeyName) {
		case HatConfirm: return OnClick(EventType);
		case HatCancel: return OnAltClick(EventType);
		case HatUp: return OnPressUp(EventType);
		case HatDown: return OnPressDown(EventType);
		case HatLeft: return OnPressLeft(EventType);
		case HatRight: return OnPressRight(EventType);
	}

	return false;
}

function bool OnClick(EInputEvent EventType) {
	return false;
}

function bool OnAltClick(EInputEvent EventType) {
    return false;
}

function bool OnPressUp(EInputEvent EventType) {
	return false;
}

function bool OnPressDown(EInputEvent EventType) {
	return false;
}

function bool OnPressLeft(EInputEvent EventType) {
	return false;
}

function bool OnPressRight(EInputEvent EventType) {
	return false;
}

defaultproperties
{
	PositionAbsolute=false
	StandardFont=Font'Yoshi_UkuleleMats_Content.Fonts.LatoBlackStandard'

	DebugMode=false
}