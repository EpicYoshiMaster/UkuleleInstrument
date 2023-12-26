class Yoshi_HUDComponent_KeybindList extends Yoshi_HUDComponent_Parent
    dependsOn(Yoshi_KeyManager);

var Texture2D KeyboardButton;
var Texture2D KeyboardButtonWide;
var KeybindType KeybindListType;
var int IndexOffset;

var Color TextColor;

var float MarginSpaceX;

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

var int HoverIndex;
var bool RecordingKey;

var delegate<GetStringArrayValueDelegate> GetValue;
var delegate<SetKeybindValueDelegate> SetValue;
var delegate<RemoveKeybindValueDelegate> RemoveValue;

//These delegates should be overridden with functions to link together external data
delegate array<string> GetStringArrayValueDelegate();
delegate bool SetKeybindValueDelegate(string NewValue, KeybindType KeyType, optional int Index = -1);
delegate bool RemoveKeybindValueDelegate(KeybindType KeyType, optional int Index = -1);

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

    if(!RecordingKey) {
        HoverIndex = INDEX_NONE;
    }

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

        if(!RecordingKey && IsPointInSpace(H, Menu.GetMousePos(H), posx, posy, keySize, keySize, false)) {
            HoverIndex = i;
        }

        RenderButtonCenter(H, i, KeyNames[i], posx, posy, pulseKeySize);

        posx += keySize + marginSize;
    }
}

function RenderButtonCenter(HUD H, int i, string ButtonName, float posx, float posy, float size) {
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

    if(RecordingKey && i == HoverIndex) {
        ButtonName = "[...]";
    }

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

function bool OnClick(EInputEvent EventType)
{
    if(Super.OnClick(EventType)) return true;
    if(EventType != IE_Pressed) return false;
    if(HoverIndex == INDEX_NONE) return false;

    if(RecordingKey) return false;

    RecordingKey = true;

    return true;
}

function bool OnAltClick(EInputEvent EventType) {
    if(Super.OnAltClick(EventType)) return true;
    if(EventType != IE_Pressed) return false;

    if(RecordingKey) {
        RecordingKey = false;
        return true;
    }
    else if(HoverIndex != INDEX_NONE) {
        RemoveValue(KeybindListType, HoverIndex + IndexOffset);
        return true;
    }

    return false;
}

function bool OnInputKey(string KeyName, EInputEvent EventType) {
    if(Super.OnInputKey(KeyName, EventType)) return true;
    if(EventType != IE_Pressed) return false;
    if(!RecordingKey) return false;

    if(SetValue(KeyName, KeybindListType, HoverIndex + IndexOffset)) {
        RecordingKey = false;
        return true;
    }

    return false;
}

function bool IsPointContainedWithin(HUD H, Vector2D TargetPos) {
    //Steal thine control
    if(RecordingKey) return true;

    return Super.IsPointContainedWithin(H, TargetPos);
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

    ModifierKeys=("Space", "BackSpace", "Control", "Shift", "CapsLock", "Tab", "Alt", "Enter")

    PulsePeriod=4.0
    MaximumOffset=6
    PulseScaleAmount=0.06

    MarginSpaceX=0.03
}