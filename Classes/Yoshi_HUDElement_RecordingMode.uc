class Yoshi_HUDElement_RecordingMode extends Hat_HUDElement;
var string RecordingModeString;
var string StatsString;
var Yoshi_UkuleleInstrument_GameMod GM;

function OnOpenHUD(HUD H, optional String command)
{
	RecordingModeString = "Ready to Record for Layer " $ command;
}

function bool Tick(HUD H, float d)
{
	local int PlayingSongStatus;
	local int RecordingMode;
	local int NotesRecorded;
    if (!Super.Tick(H, d)) return false;
	if(GM == None) GM = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

	if(GM != None) {
		PlayingSongStatus = GM.GetPlayingSong();
		RecordingMode = class'GameMod'.static.GetConfigValue(class'Yoshi_UkuleleInstrument_GameMod', 'RecordingMode');
		NotesRecorded = GM.GetSongNoteCount();
		if(RecordingMode == 0) return false;
		if(PlayingSongStatus == 0) {
			RecordingModeString = "Cannot Record during Emote Playback";
			StatsString = "";
		}
		else if(PlayingSongStatus == -1) {
			RecordingModeString = "Ready to Record for Layer " $ RecordingMode;
			StatsString = "";
		}
		else {
			RecordingModeString = "Now Recording for Layer " $ RecordingMode;
			StatsString = "Total Song Notes: " $ NotesRecorded $ " | Time Remaining: " $ string(int(class'Yoshi_UkuleleInstrument_GameMod'.const.MaxRecordingTime - GM.TimePassed));
		}

	}	

	return true;
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