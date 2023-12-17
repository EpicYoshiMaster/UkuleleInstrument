class Yoshi_HUDElement_RecordingMode extends Hat_HUDElement
	dependsOn(Yoshi_KeyManager)
	dependsOn(Yoshi_SongManager)
	dependsOn(Yoshi_RecordManager);

var array<string> DisplayStrings;
var Yoshi_UkuleleInstrument_GameMod GameMod;
var Yoshi_RecordManager RecordManager;
var Yoshi_SongManager SongManager;
var Yoshi_KeyManager KeyManager;

//Press Left or Right to change which layer to record
//Display if a layer has previous been recorded or is a new layer
//Display how many notes a previously recorded layer has
//Display to press Ctrl to end recording

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod) {
	GameMod = MyGameMod;
	RecordManager = GameMod.RecordManager;
	SongManager = GameMod.SongManager;
	KeyManager = GameMod.KeyManager;
}

function bool OnPressLeft(HUD H, bool menu, bool release)
{
	RecordManager.SetRecordingLayer(RecordManager.RecordingLayer - 1);

	return true;
}

function bool OnPressRight(HUD H, bool menu, bool release)
{
	RecordManager.SetRecordingLayer(RecordManager.RecordingLayer + 1);

	return true;
}

static function string FormatTime(int Seconds) {
	local int Hours;
	local int Minutes;

	Hours = Seconds / 3600;
	
	Seconds = Seconds % 3600;
	Minutes = Seconds / 60;

	Seconds = Seconds % 60;

	if(Hours > 0) {
		return Hours $ ":" $ ((Minutes < 10) ? "0" : "") $ Minutes $ ":" $ ((Seconds < 10) ? "0" : "") $ Seconds;
	}
	else {
		return Minutes $ ":" $ ((Seconds < 10) ? "0" : "") $ Seconds;
	}	
}

function bool Render(HUD H)
{
	local InstrumentKeyboardLayout CurrentLayout;
	local SongLayer OldLayer;
	local float scale, scaleX, scaleY, stepY;
	local int i;
	local string s;

    if (!Super.Render(H)) return false;
    if (Hat_HUD(H) != None && Hat_HUD(H).bForceHideHud) return false;
	if(!RecordManager.InRecordingMode) return false;

	DisplayStrings.Length = 0;

	scale = FMin(H.Canvas.ClipX, H.Canvas.ClipY)*0.0008;
	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont("");
	H.Canvas.SetDrawColor(255,255,255,255);

	scaleX = H.Canvas.ClipX * 0.5;
	scaleY = H.Canvas.ClipY * 0.15;
	stepY = H.Canvas.ClipY * 0.07;

	CurrentLayout = KeyManager.GetCurrentLayout();

	if(SongManager.IsPlayingPlayerSong() && !RecordManager.IsRecording) {
		DisplayStrings.AddItem("Cannot Record during Emote Playback");
	}
	else if(!RecordManager.IsRecording) {
		if(RecordManager.RecordingLayer < SongManager.PlayerSong.Layers.Length) {
			OldLayer = SongManager.PlayerSong.Layers[RecordManager.RecordingLayer];
		}

		s = "Ready to Record for Layer " $ (RecordManager.RecordingLayer + 1);
		s @= OldLayer.Notes.Length > 0 ? "(" $ OldLayer.Instrument.default.InstrumentName @ "-" @ OldLayer.Notes.Length @ "Notes)" : "(New)";

		DisplayStrings.AddItem(s); 
		DisplayStrings.AddItem("Press Left or Right to change Recording Layer");

		if((GameMod.Settings.MetronomeCountIn)) {
			if(!GameMod.Metronome.IsUpdating()) {
				DisplayStrings.AddItem("Press " $ CurrentLayout.ControlRecording $ " or a Note Key to Begin the Metronome Count-In");
			}
			else {
				DisplayStrings.AddItem("Press " $ CurrentLayout.ControlRecording $ " or a Note Key to Begin the Metronome Count-In");
			}
		}
		else {
			DisplayStrings.AddItem("Press " $ CurrentLayout.ControlRecording $ " or a Note Key to Begin Recording");
		}
	}
	else {
		s = "Now Recording for Layer " $ (RecordManager.RecordingLayer + 1);
		s @= "(" $ RecordManager.RecordLayer.Instrument.default.InstrumentName @ "-" @ RecordManager.RecordLayer.Notes.Length @ "Notes)";

		DisplayStrings.AddItem(s);
		DisplayStrings.AddItem("Total Song Notes: " $ SongManager.GetPlayerSongNoteCount() $ " | Time Elapsed: " $ FormatTime(int(SongManager.PlayerSong.Time)));
		DisplayStrings.AddItem("Press " $ CurrentLayout.ControlRecording $ " to End Recording");
	}

	for(i = 0; i < DisplayStrings.Length; i++) {
        class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, DisplayStrings[i], scaleX, scaleY, scale, true, TextAlign_Center);
        scaleY += stepY;
    }
	
    return true;
}