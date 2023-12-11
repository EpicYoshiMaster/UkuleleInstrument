class Yoshi_HUDElement_DebugMode extends Hat_HUDElement
	dependsOn(Yoshi_UkuleleInstrument_GameMod);

var array<string> PrintStrings;
var Yoshi_UkuleleInstrument_GameMod GameMod;

function bool Render(HUD H)
{
	local float scale, scaleX, scaleY, stepY;
    local int i;
    local string s;
    local Yoshi_InstrumentManager Manager;
    //local Yoshi_NoteManager NoteManager;

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

    /*
    for(i = 0; i < NoteManager.NoteSets.Length; i++) {
        s = "[" $ i $ "]" @ NoteManager.NoteSets[i].Player $ ":";

        PrintStrings.AddItem(s);
        
        for(j = 0; j < NoteManager.NoteSets[i].Notes.Length; j++) {
            s = "   " $ NoteManager.NoteSets[i].Notes[j].KeyName $ "," @ NoteManager.NoteSets[i].Notes[j].Component $ "," @ NoteManager.NoteSets[i].Notes[j].Component.IsPlaying();
            PrintStrings.AddItem(s);
        }
    }*/

    Manager = GameMod.InstrumentManager;

    for(i = 0; i < Manager.Instruments.Length; i++) {
        s = "[" $ i $ "]" @ Manager.Instruments[i].Player;
        s $= ": (Instrument:" @ Manager.Instruments[i].Instrument;
        s $= ", Mesh:" @ Manager.Instruments[i].InstrMeshComp.Name;
        s $= ", Skin:" @ Manager.Instruments[i].Skin $ ")";

        PrintStrings.AddItem(s);
    }

    /* 
    PrintStrings.AddItem("Recording Layer: " $ GM.RecordingLayer);
    PrintStrings.AddItem("Record Layer:" @ GM.RecordLayer.LastPlayedNoteIndex $ "/" $ (GM.RecordLayer.Notes.Length - 1));

    for(i = 0; i < GM.PlayerSong.Layers.Length; i++) {
        PrintStrings.AddItem("Layer " $ i $ ":" @ GM.PlayerSong.Layers[i].LastPlayedNoteIndex $ "/" $ (GM.PlayerSong.Layers[i].Notes.Length - 1));
    }*/

    for(i = 0; i < PrintStrings.Length; i++) {
        class'Hat_HUDMenu'.static.DrawBorderedText(H.Canvas, PrintStrings[i], scaleX, scaleY, scale, true, TextAlign_Left);
        scaleY += stepY;
    }
	
    return true;
}