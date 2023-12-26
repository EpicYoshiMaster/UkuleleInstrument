class Yoshi_HUDComponent_PianoRoll extends Yoshi_HUDComponent;

var int BeginNoteOffset;
var int BeginOctave;
var int TotalKeys;

var float WhiteKeyWidthRatio;

var MaterialInterface PianoWhiteKey;
var MaterialInterface PianoBlackKey;

var MaterialInstanceConstant WhiteKey;
var MaterialInstanceConstant WhiteKeyPressed;
var MaterialInstanceConstant BlackKey;
var MaterialInstanceConstant BlackKeyPressed;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod, Yoshi_HUDMenu_MusicMenu MyMenu, optional Yoshi_HUDComponent MyOwner) {
    Super.Init(MyGameMod, MyMenu, MyOwner);

    WhiteKey = new class'MaterialInstanceConstant';
    WhiteKey.SetParent(PianoWhiteKey);

    WhiteKeyPressed = new class'MaterialInstanceConstant';
    WhiteKeyPressed.SetParent(PianoWhiteKey);
    WhiteKeyPressed.SetScalarParameterValue('Pressed', 1.0);

    BlackKey = new class'MaterialInstanceConstant';
    BlackKey.SetParent(PianoBlackKey);

    BlackKeyPressed = new class'MaterialInstanceConstant';
    BlackKeyPressed.SetParent(PianoBlackKey);
    BlackKeyPressed.SetScalarParameterValue('Pressed', 1.0);
}

function Render(HUD H) {
    RenderKeyboard(H, BeginNoteOffset, BeginOctave, TotalKeys);
}

function string GetNoteName(int NoteOffset, int Octave) {
    return class'Yoshi_UkuleleInstrument_GameMod'.static.GetNoteName(NoteOffset, Octave);
}

function RenderKeyboard(HUD H, int StartingNote, int StartingOctave, int NumKeys) {
    local string CurrentNote;
    local bool QueuedFlat;
    local float posx, posy;
    local float KeyHeight, KeyWidth;

    KeyHeight = CurScaleY * H.Canvas.ClipY;
    KeyWidth = KeyHeight * WhiteKeyWidthRatio;

    posx = (CurTopLeftX * H.Canvas.ClipX) + (KeyWidth * 0.5);
    posy = (CurTopLeftY * H.Canvas.ClipY) + (KeyHeight * 0.5);

    QueuedFlat = false;

    while(NumKeys > 0) {

        CurrentNote = GetNoteName(StartingNote, StartingOctave);

        //Need to know about flats to resemble black keys (just look for "b")
        if(InStr(CurrentNote, "b") != INDEX_NONE) {
            QueuedFlat = true;

            StartingNote++;
            NumKeys--;
            continue;
        }

        class'Hat_HUDMenu'.static.DrawCenter(H, posx, posy, KeyHeight, KeyHeight, WhiteKey);

        //Look for "C" to locate beginnings of octaves to place text
        if(InStr(CurrentNote, "C") != INDEX_NONE) {
            //Hi
        }

        StartingNote++;
        NumKeys--;

        if(QueuedFlat) {

            class'Hat_HUDMenu'.static.DrawCenter(H, posx - (KeyWidth * 0.5), posy, KeyHeight, KeyHeight, BlackKey);

            QueuedFlat = false;
        }

        posx += KeyWidth;
    }

    if(QueuedFlat) {
        class'Hat_HUDMenu'.static.DrawCenter(H, posx - (KeyWidth * 0.5), posy, KeyHeight, KeyHeight, WhiteKey);
    }
}

defaultproperties
{
    PianoWhiteKey=Material'Yoshi_UkuleleMats_Content.Materials.PianoKey_White'
    PianoBlackKey=MaterialInstanceConstant'Yoshi_UkuleleMats_Content.Materials.PianoKey_Black'

    WhiteKeyWidthRatio=0.35

    BeginNoteOffset=0
    BeginOctave=3
    TotalKeys=17
}