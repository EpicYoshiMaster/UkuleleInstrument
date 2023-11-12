class Yoshi_BubbleTalker_InputText_Ukulele extends Hat_BubbleTalker_InputText;

var string CurrentInput;

var Hat_HUD LobbyMenuHUD;
var Hat_SMenuItem_TextInput TextInput;
var string ValidCharacters;

defaultproperties
{
	KeyboardKeySound = SoundCue'HatinTime_SFX_UI.SoundCues.keyboard_key'
	KeyboardSpacebarSound = SoundCue'HatinTime_SFX_UI.SoundCues.keyboard_space'
	KeyboardBackspaceSound = SoundCue'HatinTime_SFX_UI.SoundCues.keyboard_backspace'
    CharacterLength=3
	ValidCharacters="1234567890"
}

function DrawInputText(HUD H, Hat_BubbleTalkerQuestion element, float fTime, float fX, float fY) { return; }
function TickInputText(Hat_BubbleTalkerQuestion element, float d) { return; }

function bool InputKey( int ControllerId, name Key, EInputEvent EventType, float AmountDepressed = 1.f, bool bGamepad = FALSE )
{
	if (!Super.InputKey(ControllerId, Key, EventType, AmountDepressed, bGamepad) && (EventType == IE_Pressed || EventType == IE_Repeat)) return false;
	
	if (TextInput != None)
	{
		if (Key == 'BackSpace' && Len(CurrentInput) > 0 && (EventType == IE_Pressed || EventType == IE_Repeat))
		{
			CurrentInput = Left(CurrentInput, Len(CurrentInput)-1);
		}
		else if (Key == 'Enter' && EventType == IE_Released)
		{
			TextInput.OnCommand(LobbyMenuHUD);
		}
	}
	
	return true;
}

function AddCharacter(string s)
{
	Result = "";
	Super.AddCharacter(s);
	if (InStr(ValidCharacters, Locs(Result)) == INDEX_NONE) return;
	if (TextInput != None && (CharacterLength <= 0 || Len(CurrentInput) < CharacterLength))
	{
		CurrentInput $= Locs(Result);
	}
}

function PlaySoundToPlayerControllers(SoundCue c)
{
	if (IsUsingGamepad) Super.PlaySoundToPlayerControllers(c);
}

function string GetInput() {
	return CurrentInput;
}

function SetInput(string NewInput) {
	CurrentInput = NewInput;
}