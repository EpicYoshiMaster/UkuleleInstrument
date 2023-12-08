class Yoshi_HUDComponent_KeybindList extends Yoshi_HUDComponent_Parent;

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
var const array<string> BannedKeys; //We should not bind to any of these
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
    maxSize = BaseSize;

    alpha = WorldTime / PulsePeriod;
    alpha += Offset / MaximumOffset;

    return Lerp(minSize, maxSize, 0.5 + 0.5 * Sin(2 * Pi * alpha));
}

function Render(HUD H) {
    Super.Render(H);

    RenderKeys(H, CurTopLeftX * H.Canvas.ClipX, CurTopLeftY * H.Canvas.ClipY, CurScaleX * H.Canvas.ClipX, CurScaleY * H.Canvas.ClipY);
}

function RenderKeys(HUD H, float PosX, float PosY, float SpaceX, float SpaceY) {
    local float keySize, pulseKeySize, marginSize;
    local int i;
    local WorldInfo wi;

    

    KeyNames = GetValue();

    marginSize = MarginSpaceX * SpaceX;

    //First try dividing the total X space and see if this is reasonable
    keySize = (SpaceX - (marginSize * (KeyNames.Length - 1))) / KeyNames.Length;

    //If not, just use the Y-Size
    if(keySize > SpaceY) {
        keySize = SpaceY;
    }

    //Move to centered
    PosY += 0.5 * SpaceY;
    PosX += 0.5 * keySize;

    wi = class'WorldInfo'.static.GetWorldInfo();

    for(i = 0; i < KeyNames.Length; i++) {
        pulseKeySize = GetPulseSize(keySize, wi.TimeSeconds, i);

        RenderButtonCenter(H, KeyNames[i], posx, posy, pulseKeySize);

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
        ButtonName = "[None]";
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

    ShortKeyNames.Add((Key="tilde", ShortKey="`"))
    ShortKeyNames.Add((Key="comma", ShortKey=","))
    ShortKeyNames.Add((Key="period", ShortKey="."))
    ShortKeyNames.Add((Key="quote", ShortKey="'"))
    ShortKeyNames.Add((Key="semicolon", ShortKey=";"))
    ShortKeyNames.Add((Key="slash", ShortKey="/"))
    ShortKeyNames.Add((Key="backslash", ShortKey="\\"))
    ShortKeyNames.Add((Key="underscore", ShortKey="_"))
    ShortKeyNames.Add((Key="divide", ShortKey="/"))
    ShortKeyNames.Add((Key="multiply", ShortKey="*"))
    ShortKeyNames.Add((Key="subtract", ShortKey="-"))
    ShortKeyNames.Add((Key="add", ShortKey="+"))
    ShortKeyNames.Add((Key="equals", ShortKey="="))
    ShortKeyNames.Add((Key="leftbracket", ShortKey="["))
    ShortKeyNames.Add((Key="rightbracket", ShortKey="]"))
    ShortKeyNames.Add((Key="capslock", ShortKey="Caps Lock"))
    ShortKeyNames.Add((Key="Control", ShortKey="Ctrl"))

    ShortKeyNames.Add((Key="zero", ShortKey="0"))
    ShortKeyNames.Add((Key="one", ShortKey="1"))
    ShortKeyNames.Add((Key="two", ShortKey="2"))
    ShortKeyNames.Add((Key="three", ShortKey="3"))
    ShortKeyNames.Add((Key="four", ShortKey="4"))
    ShortKeyNames.Add((Key="five", ShortKey="5"))
    ShortKeyNames.Add((Key="six", ShortKey="6"))
    ShortKeyNames.Add((Key="seven", ShortKey="7"))
    ShortKeyNames.Add((Key="eight", ShortKey="8"))
    ShortKeyNames.Add((Key="nine", ShortKey="9"))

    ModifierKeys=("Space", "BackSpace", "Control", "Shift", "CapsLock", "Tab", "Alt")

    PulsePeriod=4.0
    MaximumOffset=6
    PulseScaleAmount=0.06

    MarginSpaceX=0.03
}