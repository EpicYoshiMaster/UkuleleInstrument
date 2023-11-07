class Yoshi_HUDComponent_Base extends Component;

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

var bool DebugMode;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
	GameMod = MyGameMod;
    Menu = MyMenu;
	Owner = MyOwner;
}

function Tick(HUD H, float delta) {

}

function Render(HUD H) {
	if(PositionAbsolute || Owner == None) {
		CurTopLeftX = TopLeftX;
		CurTopLeftY = TopLeftY;
		CurScaleX = ScaleX;
		CurScaleY = ScaleY;
	}
	else {
		CurTopLeftX = Owner.CurTopLeftX + (TopLeftX * Owner.CurScaleX);
		CurTopLeftY = Owner.CurTopLeftY + (TopLeftY * Owner.CurScaleY);
		CurScaleX = Owner.CurScaleX * ScaleX;
		CurScaleY = Owner.CurScaleY * ScaleY;
	}

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

	DebugMode=true
}