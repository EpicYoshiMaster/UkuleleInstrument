class Yoshi_KeyManager extends Object
    dependsOn(Yoshi_InputPack);

const BannedPrefix = "Hat_";
const CustomLayoutName = "Custom";

const OctaveDown = 0;
const OctaveUp = 1;
const PitchDown = 2;
const PitchUp = 3;
const StepDown = 4;
const StepUp = 5;

enum KeybindType {
    Keybind_Note,
    Keybind_FlatNote,
    Keybind_Modifier,
    Keybind_ToggleMenu,
    Keybind_ControlRecording,
    Keybind_HoldPitchDown
};

struct InstrumentKeyboardLayout {
    var string LayoutName;
    var array<string> Notes;
    var array<string> FlatNotes; //1 to 1 mapping with notes as flats of each
    var string ToggleMenu;
    var string ControlRecording;
    var string HoldPitchDown;

    // 0: Octave Down, 1: Octave Up, 2: Pitch Down, 3: Pitch Up, 4: Step Down, 5: Step Up
    var array<string> Modifiers;
};

struct KeyAlias {
    var array<Name> Aliases;
    var string KeyName;
};

var Yoshi_UkuleleInstrument_GameMod GameMod;

var const array<KeyAlias> KeyAliases;
var const array<string> BannedKeys;

var InputPack InputPack;

var array<InstrumentKeyboardLayout> DefaultLayouts;
var InstrumentKeyboardLayout CustomLayout;

var bool IsHoldingPitchDownKey;

var array< delegate<OnInputKey> > InputDelegates;

var Yoshi_HUDElement_DebugMode DebugHUD;

delegate bool OnInputKey(string KeyName, EInputEvent EventType);

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod) {
    GameMod = MyGameMod;

    CustomLayout = GameMod.Settings.CustomLayout;
}

function Tick(float delta) {
    local Hat_PlayerController KeyboardPlayer;

    KeyboardPlayer = GetKeyboardPlayer(InputPack.PlyCon);

    if(KeyboardPlayer != InputPack.PlyCon) {
        if(InputPack.PlyCon != None) {
            //Check coop instrument status with this
            class'Yoshi_InputPack'.static.DetachController(InputPack);
        }

        if(KeyboardPlayer != None) {
            class'Yoshi_InputPack'.static.AttachController(ReceivedNativeInputKey, KeyboardPlayer, InputPack);
        }
    }

    if(GameMod.DebugMode) {
        if(InputPack.PlyCon != None && DebugHUD == None) {
            DebugHUD = Yoshi_HUDElement_DebugMode(Hat_HUD(InputPack.PlyCon.MyHUD).OpenHUD(class'Yoshi_HUDElement_DebugMode'));
        }
    }
}

function Unload() {
    if(InputPack.PlyCon != None) {
        class'Yoshi_InputPack'.static.DetachController(InputPack);
    }
}

function Hat_PlayerController GetPC() {
    return InputPack.PlyCon;
}

function Hat_Player GetPlayer() {
    if(InputPack.PlyCon != None) {
        return Hat_Player(InputPack.PlyCon.Pawn);
    }

    return None;
}

//Returns true if successful, false if not
function bool SetKeybind(string NewValue, KeybindType KeyType, optional int Index = -1) {
    local int i;
    local InstrumentKeyboardLayout CurrentLayout;

    //Is this key legal to be bound to?
    if(InStr(NewValue, BannedPrefix,,true) != INDEX_NONE) return false;

    for(i = 0; i < BannedKeys.Length; i++) {
        if(NewValue ~= BannedKeys[i]) return false;
    }

    //This key is legal (or at least it better be :>)

    CurrentLayout = GetCurrentLayout();

    //Check if it's the same, if not, set the bind on our copy
    switch(KeyType) {
        case Keybind_Note:
            if(NewValue ~= CurrentLayout.Notes[Index]) return false;
            CurrentLayout.Notes[Index] = NewValue;
            break;
        case Keybind_FlatNote:
            if(NewValue ~= CurrentLayout.FlatNotes[Index]) return false;
            CurrentLayout.FlatNotes[Index] = NewValue;
            break;
        case Keybind_Modifier:
            if(NewValue ~= CurrentLayout.Modifiers[Index]) return false;
            CurrentLayout.Modifiers[Index] = NewValue;
            break;
        case Keybind_ToggleMenu:
            if(NewValue ~= CurrentLayout.ToggleMenu) return false;
            CurrentLayout.ToggleMenu = NewValue;
            break;
        case Keybind_ControlRecording:
            if(NewValue ~= CurrentLayout.ControlRecording) return false;
            CurrentLayout.ControlRecording = NewValue;
            break;
        case Keybind_HoldPitchDown:
            if(NewValue ~= CurrentLayout.HoldPitchDown) return false;
            CurrentLayout.HoldPitchDown = NewValue;
            break;
    }

    //Using a default layout, overwrite the custom one.
    if(GameMod.Settings.CurrentLayoutIndex < DefaultLayouts.length) {
        GameMod.SetKeyboardLayoutIndex(DefaultLayouts.Length);
    }

    CustomLayout = CurrentLayout;
    CustomLayout.LayoutName = CustomLayoutName;

    GameMod.SetCustomLayout(CustomLayout);

    return true;
}

function bool RemoveKeybind(KeybindType KeyType, optional int Index = -1) {
    return SetKeybind("", KeyType, Index);
}

function InstrumentKeyboardLayout GetCurrentLayout() {

    if(GameMod.Settings.CurrentLayoutIndex >= DefaultLayouts.Length) {
        return CustomLayout;
    }

    return DefaultLayouts[GameMod.Settings.CurrentLayoutIndex];
}

function array<InstrumentKeyboardLayout> GetAllLayouts() {
    local array<InstrumentKeyboardLayout> AllLayouts;

    AllLayouts = DefaultLayouts;
    AllLayouts.AddItem(CustomLayout);

    return AllLayouts;
}

function RegisterInputDelegate(delegate<OnInputKey> NewInputDelegate) {
    if(InputDelegates.Find(NewInputDelegate) == INDEX_NONE) {
        InputDelegates.AddItem(NewInputDelegate);
    }
}

function RemoveInputDelegate(delegate<OnInputKey> RemoveDelegate) {
    local int Index;

    Index = InputDelegates.Find(RemoveDelegate);

    if(Index != INDEX_NONE) {
        InputDelegates.Remove(Index, 1);
    }
}

function bool ReceivedNativeInputKey(int ControllerId, name Key, EInputEvent EventType, float AmountDepressed, bool bGamepad) {
    local Hat_PlayerController PC;
    local int i;
    local string KeyName;
    local InstrumentKeyboardLayout CurrentLayout;
    local delegate<OnInputKey> InputDelegate;

    PC = InputPack.PlyCon;
    CurrentLayout = GetCurrentLayout();

    if(PC.IsPaused()) return false;

    if(EventType == IE_Pressed) {
        GameMod.Print(`ShowVar(Key) @ `ShowVar(EventType) @ `ShowVar(bGamepad));
    }

    KeyName = string(Key);

    for(i = 0; i < KeyAliases.Length; i++) {
        if(KeyAliases[i].Aliases.Find(Key) != INDEX_NONE) {
            KeyName = KeyAliases[i].KeyName;
            break;
        }
    }

    foreach InputDelegates(InputDelegate) {
        if(InputDelegate(KeyName, EventType)) {
            return true;
        }
    }

    if(KeyName ~= CurrentLayout.HoldPitchDown) {
        if (EventType == IE_Released) IsHoldingPitchDownKey = false;
		else if (EventType == IE_Pressed || EventType == IE_Repeat) IsHoldingPitchDownKey = true;
    }

    if(EventType == IE_Released) {
        for(i = 0; i < CurrentLayout.Notes.Length; i++) {
            if(CurrentLayout.Notes[i] ~= KeyName) {
                return GameMod.OnReleaseNoteKey(Hat_Player(PC.Pawn), i, KeyName);
            }
        }

        if(!GameMod.Settings.TwoRowMode) return false;

        for(i = 0; i < CurrentLayout.FlatNotes.Length; i++) {
            if(CurrentLayout.FlatNotes[i] ~= KeyName) {
                return GameMod.OnReleaseNoteKey(Hat_Player(PC.Pawn), i, KeyName);
            }
        }
    }

    if(EventType != IE_Pressed) return false;

    if(KeyName ~= CurrentLayout.ToggleMenu) {
        return GameMod.OnPressToggleMenu(PC);
    }

    if(KeyName ~= CurrentLayout.ControlRecording) {
        return GameMod.OnPressControlRecording(PC);
    }

    //Need a smarter solution here
    if(Key == 'Hat_Player_Attack') {
        return GameMod.OnPressPlayerAttack(PC);
    }

    if(KeyName ~= CurrentLayout.Modifiers[OctaveDown]) {
        GameMod.ChangeOctave(-1);
    }
    else if(KeyName ~= CurrentLayout.Modifiers[OctaveUp]) {
        GameMod.ChangeOctave(1);
    }
    else if(KeyName ~= CurrentLayout.Modifiers[PitchDown]) {
        GameMod.ChangePitchShift(-1);
    }
    else if(KeyName ~= CurrentLayout.Modifiers[PitchUp]) {
        GameMod.ChangePitchShift(1);
    }
    else if(KeyName ~= CurrentLayout.Modifiers[StepDown]) {
        GameMod.ChangeStepShift(-1);
    }
    else if(KeyName ~= CurrentLayout.Modifiers[StepUp]) {
        GameMod.ChangeStepShift(1);
    }

    for(i = 0; i < CurrentLayout.Notes.Length; i++) {
        if(CurrentLayout.Notes[i] ~= KeyName) {
            return GameMod.OnPressNoteKey(Hat_Player(PC.Pawn), i, IsHoldingPitchDownKey, KeyName);
        }
    }

    if(!GameMod.Settings.TwoRowMode) return false;

    for(i = 0; i < CurrentLayout.FlatNotes.Length; i++) {
        if(CurrentLayout.FlatNotes[i] ~= KeyName) {
            return GameMod.OnPressNoteKey(Hat_Player(PC.Pawn), i, true, KeyName);
        }
    }

    return false;
}

static function Hat_PlayerController GetKeyboardPlayer(optional Controller CallingController)
{
	local Array<Player> GamePlayers;
	local int i;

	GamePlayers = class'Engine'.static.GetEngine().GamePlayers;

	for (i = 0; i < GamePlayers.Length; i++)
	{
		if (GamePlayers[i].Actor == None || GamePlayers[i].Actor.Pawn == None) continue;
		if (LocalPlayer(GamePlayers[i]).ControllerId >= 0) continue;
		return Hat_PlayerController(GamePlayers[i].Actor);
	}

	return CallingController != None ? Hat_PlayerController(CallingController) : None;
}

function GetDebugStrings(out array<string> PrintStrings) {
    PrintStrings.AddItem("PC:" @ InputPack.PlyCon $ ", Pitch Down:" @ IsHoldingPitchDownKey $ ", Layout Index:" @ GameMod.Settings.CurrentLayoutIndex);
}

defaultproperties
{
    KeyAliases.Add((Aliases=("LeftShift", "RightShift"), KeyName="Shift"));
    KeyAliases.Add((Aliases=("LeftControl", "RightControl"), KeyName="Control"));
    KeyAliases.Add((Aliases=("LeftAlt", "RightAlt"), KeyName="Alt"));

    DefaultLayouts[0] = {(
        LayoutName="QWERTY",
        Notes=("Z","X","C","V","B","N","M","comma","period","slash"),
        FlatNotes=("A","S","D","F","G","H","J","K","L","semicolon"),
        ToggleMenu="Y",
        HoldPitchDown="Shift",
        ControlRecording="Control",
        Modifiers=("U","I","O","P","leftbracket","rightbracket")
    )}

    DefaultLayouts[1] = {(
        LayoutName="QWERTZ",
        Notes=("Y","X","C","V","B","N","M","comma","period","underscore"),
        FlatNotes=("A","S","D","F","G","H","J","K","L","semicolon"),
        ToggleMenu="Y",
        HoldPitchDown="Shift",
        ControlRecording="Control",
        Modifiers=("U","I","O","P","leftbracket","rightbracket")
    )}

    DefaultLayouts[2] = {(
        LayoutName="AZERTY",
        Notes=("W","X","C","V","B","N","comma","period","slash", ""), //Only 9 keys, there is no ! or paragraph key input event
        FlatNotes=("Q","S","D","F","G","H","J","K","L","M"), //all 10 keys :D
        ToggleMenu="Y",
        HoldPitchDown="Shift",
        ControlRecording="Control",
        Modifiers=("U","I","O","P","rightbracket","semicolon")
    )}

    CustomLayout = {(
        LayoutName="Custom",
        Notes=("Z","X","C","V","B","N","M","comma","period","slash"),
        FlatNotes=("A","S","D","F","G","H","J","K","L","semicolon"),
        ToggleMenu="Y",
        HoldPitchDown="Shift",
        ControlRecording="Control",
        Modifiers=("U","I","O","P","leftbracket","rightbracket")
    )}

    BannedKeys.Add("leftmousebutton")
    BannedKeys.Add("rightmousebutton")
    BannedKeys.Add("middlemousebutton")
    BannedKeys.Add("escape")
    BannedKeys.Add("pause")
    BannedKeys.Add("scrolllock")
    BannedKeys.Add("printscreen")
    BannedKeys.Add("numlock")
    BannedKeys.Add("left")
    BannedKeys.Add("right")
    BannedKeys.Add("up")
    BannedKeys.Add("down")
    BannedKeys.Add("insert")
    BannedKeys.Add("delete")
    BannedKeys.Add("home")
    BannedKeys.Add("end")
    BannedKeys.Add("pageup")
    BannedKeys.Add("pagedown")
}