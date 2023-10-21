class Yoshi_HUDElement_DebugMode extends Hat_HUDElement
	dependsOn(Yoshi_UkuleleInstrument_GameMod);

var array<string> PrintStrings;
var Yoshi_UkuleleInstrument_GameMod GM;

function bool Render(HUD H)
{
	local float scale, scaleX, scaleY, stepY;
    local int i;
    local string s;
    local Yoshi_InstrumentManager Manager;
    if (!Super.Render(H)) return false;
    if (Hat_HUD(H) != None && Hat_HUD(H).bForceHideHud) return false;
    if(GM == None) GM = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

    PrintStrings.Length = 0;
    scale = FMin(H.Canvas.ClipX, H.Canvas.ClipY)*0.00045;
    scaleX = H.Canvas.ClipX*0.01;
    scaleY = H.Canvas.ClipY*0.15;
    stepY = H.Canvas.ClipY*0.05;

    H.Canvas.SetDrawColor(255,255,255,255);
    H.Canvas.Font = class'Hat_FontInfo'.static.GetDefaultFont("");

    Manager = GM.InstrumentManager;

    s = "Player";
    s $= ": (Class:" @ Manager.EquippedClass;
    s $= ", Mesh:" @ Manager.InstrumentMesh.Name;
    s $=", Equipped:" @ Manager.IsPlayerEquipped $ ")";

    PrintStrings.AddItem(s);

    for(i = 0; i < Manager.OPInstruments.Length; i++) {

        s = "[" $ i $ "]" @ Manager.OPInstruments[i].GPP.UserName;
        s $= ": (Class:" @ Manager.OPInstruments[i].EquippedClass;
        s $= ", Mesh:" @ Manager.OPInstruments[i].InstrumentMesh.Name;
        s $= ", Equipped:" @ Manager.OPInstruments[i].IsEquipped $ ")";

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