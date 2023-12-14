class Yoshi_HUDElement_DebugMode extends Hat_HUDElement
	dependsOn(Yoshi_UkuleleInstrument_GameMod);

var array<string> PrintStrings;
var Yoshi_UkuleleInstrument_GameMod GameMod;

var bool NoteDebug;
var bool SongDebug;
var bool KeyDebug;
var bool RecordDebug;
var bool InstrumentDebug;

function bool Render(HUD H)
{
	local float scale, scaleX, scaleY, stepY;
    local int i;

    if (!Super.Render(H)) return false;
    if (Hat_HUD(H) != None && Hat_HUD(H).bForceHideHud) return false;
    if(GameMod == None) GameMod = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

    //NoteManager = GameMod.NoteManager;

    PrintStrings.Length = 0;
    scale = FMin(H.Canvas.ClipX, H.Canvas.ClipY)*0.00045;
    scaleX = H.Canvas.ClipX*0.01;
    scaleY = H.Canvas.ClipY*0.15;
    stepY = H.Canvas.ClipY*0.05;

    H.Canvas.SetDrawColor(255,255,255,255);
    H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont("");

    if(KeyDebug) {
        GameMod.KeyManager.GetDebugStrings(PrintStrings);
    }

    if(RecordDebug) {
        GameMod.RecordManager.GetDebugStrings(PrintStrings);
    }

    if(SongDebug) {
        GameMod.SongManager.GetDebugStrings(PrintStrings);
    }

    if(InstrumentDebug) {
        GameMod.InstrumentManager.GetDebugStrings(PrintStrings);
    }

    if(NoteDebug) {
        GameMod.NoteManager.GetDebugStrings(PrintStrings);
    }

    for(i = 0; i < PrintStrings.Length; i++) {
        class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, PrintStrings[i], scaleX, scaleY, scale, true, TextAlign_Left);
        scaleY += stepY;
    }
	
    return true;
}

defaultproperties
{
    NoteDebug=true
    SongDebug=true
    KeyDebug=true
    RecordDebug=true
    InstrumentDebug=true
}