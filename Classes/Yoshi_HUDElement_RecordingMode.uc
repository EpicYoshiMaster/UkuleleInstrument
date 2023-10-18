class Yoshi_HUDElement_RecordingMode extends Hat_HUDElement
	dependsOn(Yoshi_UkuleleInstrument_GameMod);

var array<string> DisplayStrings;
var Yoshi_UkuleleInstrument_GameMod GM;

//Press Left or Right to change which layer to record
//Display if a layer has previous been recorded or is a new layer
//Display how many notes a previously recorded layer has
//Display to press Ctrl to end recording

function bool OnPressLeft(HUD H, bool menu, bool release)
{
	GM.SetRecordingLayer(GM.RecordingLayer - 1);

	return true;
}

function bool OnPressRight(HUD H, bool menu, bool release)
{
	GM.SetRecordingLayer(GM.RecordingLayer + 1);

	return true;
}

static function string FormatTime(int Seconds) {
	local int Minutes;

	Minutes = Seconds / 60;
	Seconds = Seconds % 60;

	return Minutes $ ":" $ ((Seconds < 10) ? "0" : "") $ Seconds;
}

function bool Render(HUD H)
{
	local float scale, scaleX, scaleY, stepY;
	local int i;
	local string s;

    if (!Super.Render(H)) return false;
    if (Hat_HUD(H) != None && Hat_HUD(H).bForceHideHud) return false;
	if(GM == None) GM = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();
	if(GM == None) return true;

	if(GM.RecordingMode != 1) return false;

	DisplayStrings.Length = 0;

	scale = FMin(H.Canvas.ClipX, H.Canvas.ClipY)*0.0008;
	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont("");
	H.Canvas.SetDrawColor(255,255,255,255);

	scaleX = H.Canvas.ClipX * 0.5;
	scaleY = H.Canvas.ClipY * 0.15;
	stepY = H.Canvas.ClipY * 0.07;

	if(GM.PlayingState == PS_IdleMode) {

		s = "Ready to Record for Layer " $ (GM.RecordingLayer + 1);
		s @= GM.PlayerSong.Layers[GM.RecordingLayer].Notes.Length > 0 ? "(" $ GM.PlayerSong.Layers[GM.RecordingLayer].InstrumentName @ "-" @ GM.PlayerSong.Layers[GM.RecordingLayer].Notes.Length @ "Notes)" : "(New)";

		DisplayStrings.AddItem(s); 
		DisplayStrings.AddItem("Press Left or Right to change Recording Layer");
		DisplayStrings.AddItem("Press Ctrl or a Note Key to Begin Recording");
	}
	else if(GM.PlayingState == PS_PlaybackMode) {
		DisplayStrings.AddItem("Cannot Record during Emote Playback");
	}
	else {
		s = "Now Recording for Layer " $ (GM.RecordingLayer + 1);
		s @= "(" $ GM.RecordLayer.InstrumentName @ "-" @ GM.RecordLayer.Notes.Length @ "Notes)";

		DisplayStrings.AddItem(s);
		DisplayStrings.AddItem("Total Song Notes: " $ GM.GetPlayerSongNoteCount() $ " | Time Elapsed: " $ FormatTime(int(GM.PlayerSong.Time)) $ "/" $ FormatTime(GM.MaxRecordingLength));
		DisplayStrings.AddItem("Press Ctrl to End Recording");
	}

	for(i = 0; i < DisplayStrings.Length; i++) {
        class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, DisplayStrings[i], scaleX, scaleY, scale, true, TextAlign_Center);
        scaleY += stepY;
    }
	
    return true;
}