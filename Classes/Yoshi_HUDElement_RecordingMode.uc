class Yoshi_HUDElement_RecordingMode extends Hat_HUDElement
	dependsOn(Yoshi_UkuleleInstrument_GameMod);

var string RecordingModeString;
var string StatsString;
var Yoshi_UkuleleInstrument_GameMod GM;

function bool Tick(HUD H, float d)
{
    if(!Super.Tick(H, d)) return false;
	if(GM == None) GM = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();
	if(GM == None) return true;

	if(GM.RecordingMode == 0) return false; //We are not recording

	switch(GM.PlayingState) {
		case PS_PlaybackMode: 
			RecordingModeString = "Cannot Record during Emote Playback"; 
			StatsString = ""; 
			break;
		case PS_IdleMode: 
			RecordingModeString = "Ready to Record for Layer " $ (GM.RecordingLayer + 1); 
			StatsString = ""; 
			break;
		case PS_RecordMode: 
			RecordingModeString = "Now Recording for Layer " $ (GM.RecordingLayer + 1);
			StatsString = "Total Song Notes: " $ GM.GetPlayerSongNoteCount() $ " | Time Remaining: " $ FormatTime(int(GM.GetMaxRecordingTime() - GM.PlayerSong.Time));
			break;
	}

	return true;
}

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
	local float scale;
    if (!Super.Render(H)) return false;
    if (Hat_HUD(H) != None && Hat_HUD(H).bForceHideHud) return false;

	scale = FMin(H.Canvas.ClipX, H.Canvas.ClipY)*0.001;
	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(RecordingModeString);
	H.Canvas.SetDrawColor(255,255,255,255);
	class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, RecordingModeString, H.Canvas.ClipX/2, H.Canvas.ClipY*0.15, scale, true, TextAlign_Center);

	H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont(StatsString);
	H.Canvas.SetDrawColor(255,255,255,255);
	class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, StatsString, H.Canvas.ClipX/2, H.Canvas.ClipY*0.22, scale, true, TextAlign_Center);
	
    return true;
}