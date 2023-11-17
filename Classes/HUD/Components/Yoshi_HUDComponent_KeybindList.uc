class Yoshi_HUDComponent_KeybindList extends Yoshi_HUDComponent;

var Texture2D KeyboardButton;
var Texture2D KeyboardButtonWide;

var Color TextColor;

var float MarginSpaceX;

//Display a row of keybinds, pressing on one allows you to rebind that key to something else

//Pulsate the row

var array<string> KeyNames;

struct ShortKeyName {
    var string Key;
    var string ShortKey;
};

var const array<ShortKeyName> ShortKeyNames;
var const array<string> ModifierKeys;

var float PulseScaleAmount;
var float PulsePeriod;
var float MaximumOffset;

var delegate<GetStringArrayValueDelegate> GetValue;
var delegate<SetStringArrayValueDelegate> SetValue;

//These delegates should be overridden with functions to link together external data
delegate array<string> GetStringArrayValueDelegate();
delegate SetStringArrayValueDelegate(array<string> NewValue);

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Super.Init(MyGameMod, MyMenu, MyOwner);

    KeyNames = GetValue();
}

function float GetPulseSize(float BaseSize, float WorldTime, float Offset) {
    local float minSize, maxSize;
    local float alpha;

    minSize = BaseSize * (1 - PulseScaleAmount);
    maxSize = BaseSize * (1 + PulseScaleAmount);

    alpha = WorldTime / PulsePeriod;
    alpha += Offset / MaximumOffset;

    return Lerp(minSize, maxSize, 0.5 + 0.5 * Sin(2 * Pi * alpha));
}

function Render(HUD H) {
    local float posx, posy, keySize, pulseKeySize, marginSize;
    local int i;
    local WorldInfo wi;

    posx = CurTopLeftX * H.Canvas.ClipX;
    posy = CurTopLeftY * H.Canvas.ClipY;

    KeyNames = GetValue();

    marginSize = MarginSpaceX * CurScaleX * H.Canvas.ClipX;

    //First try dividing the total X space and see if this is reasonable
    keySize = ((CurScaleX * H.Canvas.ClipX) - (marginSize * (KeyNames.Length - 1))) / KeyNames.Length;

    //If not, just use the Y-Size
    if(keySize > CurScaleY * H.Canvas.ClipY) {
        keySize = CurScaleY * H.Canvas.ClipY;
    }

    wi = class'WorldInfo'.static.GetWorldInfo();

    for(i = 0; i < KeyNames.Length; i++) {
        pulseKeySize = GetPulseSize(keySize, wi.TimeSeconds, i);

        RenderButtonCenter(H, KeyNames[i], posx + 0.5 * keySize, posy + 0.5 * keySize, pulseKeySize);

        posx += keySize + marginSize;
    }
}

function RenderButtonCenter(HUD H, string ButtonName, float posx, float posy, float size) {
    local float TextSize, buttonscalemax;
	local string KeyName;
	local Texture2D KeyTexture;
	local Color PrevColor;
	local Vector buttonscale;
	local Font PrevFont;
	
	PrevFont = H.Canvas.Font;
	PrevColor = H.Canvas.DrawColor;
	
	KeyTexture = GetButtonIcon(ButtonName);

    buttonscale = (KeyTexture == default.KeyboardButton) ? vect(1.1,1.1,0) : vect(1.1,0.7359,0);

	class'Hat_HUDElement'.static.DrawCenter(H, posx, posy, size*buttonscale.X, size*buttonscale.Y, KeyTexture);
	buttonscalemax = FMax(buttonscale.X, buttonscale.Y);

    if(ButtonName == "") {
        ButtonName = "???";
    }

	KeyName = Caps(GetShortKeyName(ButtonName));
	TextSize = GetTextScale(KeyName);

    H.Canvas.SetDrawColorStruct(default.TextColor);
	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(KeyName);

	class'Hat_HUDElement'.static.DrawCenterText(H.Canvas, KeyName, posx, posy + (size * -0.05), size*0.015*TextSize*buttonscalemax, size*0.015*TextSize*buttonscalemax);

	H.Canvas.SetDrawColor(PrevColor.R, PrevColor.G, PrevColor.B, PrevColor.A);
	H.Canvas.Font = PrevFont;
}

function string GetShortKeyName(string ButtonName) {
    local int i;

    for(i = 0; i < ShortKeyNames.Length; i++) {
        if(ButtonName ~= ShortKeyNames[i].Key) {
            return ShortKeyNames[i].ShortKey;
        }
    }

    return ButtonName;
}

function Texture2D GetButtonIcon(string ButtonName)
{
    local int i;

    for(i = 0; i < ModifierKeys.Length; i++) {
        if(ButtonName ~= ModifierKeys[i]) {
            return KeyboardButtonWide;
        }
    }

    return KeyboardButton;
}

static function float GetTextScale(string msg)
{
	local float s;
	if (Len(msg) <= 1) return 1.0;
	
	s = 1.0;
	s -= (Len(msg) -1)*0.13;
	s = FMax(s, 0.01);
	return s;
}

defaultproperties
{
    KeyboardButton=Texture2D'HatInTime_Hud.Buttons.Keyboard.button_keyboard';
    KeyboardButtonWide=Texture2D'HatInTime_Hud.Buttons.Keyboard.button_keyboard_wide';

    TextColor=(R=255,G=255,B=255,A=255)

    ShortKeyNames.Add((Key="comma", ShortKey=","))
    ShortKeyNames.Add((Key="period", ShortKey="."))
    ShortKeyNames.Add((Key="semicolon", ShortKey=";"))
    ShortKeyNames.Add((Key="slash", ShortKey="/"))
    ShortKeyNames.Add((Key="minus", ShortKey="-"))
    ShortKeyNames.Add((Key="plus", ShortKey="+"))

    ModifierKeys=("Ctrl", "Shift", "Caps", "Tab", "Alt")

    PulsePeriod=4.0
    MaximumOffset=6
    PulseScaleAmount=0.03

    MarginSpaceX=0.03
}