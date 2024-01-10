//Credit to Doka, sourced from the MuseScore Piano
class Yoshi_MusicalInstrument_Piano extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=1
    InstrumentName="Piano"
    ShortName="Pno"

    Icon=Texture2D'HatInTime_Hud_Loadout.Item_Icons.itemicon_badge_sprint'

    CanReleaseNote=true
    FadeOutTime=0.3

    MinOctave=2 //C2
    MaxOctave=6 //E7
    DefaultOctave=4
    
    Pitches.Add((Name = "C2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_c2'));
    Pitches.Add((Name = "Db2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_db2'));
    Pitches.Add((Name = "D2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_d2'));
    Pitches.Add((Name = "Eb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_eb2'));
    Pitches.Add((Name = "E2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_e2'));
    Pitches.Add((Name = "F2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_f2'));
    Pitches.Add((Name = "Gb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_gb2'));
    Pitches.Add((Name = "G2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_g2'));
    Pitches.Add((Name = "Ab2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_ab2'));
    Pitches.Add((Name = "A2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_a2'));
    Pitches.Add((Name = "Bb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_bb2'));
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_e6'));
    Pitches.Add((Name = "F6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_f6'));
    Pitches.Add((Name = "Gb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_gb6'));
    Pitches.Add((Name = "G6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_g6'));
    Pitches.Add((Name = "Ab6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_ab6'));
    Pitches.Add((Name = "A6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_a6'));
    Pitches.Add((Name = "Bb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_bb6'));
    Pitches.Add((Name = "B6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_b6'));

    Pitches.Add((Name = "C7", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_c7'));
    Pitches.Add((Name = "Db7", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_db7'));
    Pitches.Add((Name = "D7", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_d7'));
    Pitches.Add((Name = "Eb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_eb7'));
    Pitches.Add((Name = "E7", Sound = SoundCue'Yoshi_MusicalUkulele_Content.PianoSoundCues.Piano_e7'));
}