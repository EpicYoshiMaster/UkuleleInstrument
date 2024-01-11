//Credit to the Timbres of Heaven Soundfont - Honky Tonk
class Yoshi_MusicalInstrument_HonkyTonkPiano extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=4
    InstrumentName="Honky-Tonk Piano"
    ShortName="HTP"

    Icon=Texture2D'HatInTime_Hud_Loadout.Item_Icons.itemicon_badge_sprint'

    CanReleaseNote=true
    FadeOutTime=0.3

    MinOctave=1 //B0
    MaxOctave=6 //E7
    DefaultOctave=4

    Pitches.Add((Name = "B0", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_b0'));

    Pitches.Add((Name = "C1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_c1'));
    Pitches.Add((Name = "Db1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_db1'));
    Pitches.Add((Name = "D1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_d1'));
    Pitches.Add((Name = "Eb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_eb1'));
    Pitches.Add((Name = "E1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_e1'));
    Pitches.Add((Name = "F1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_f1'));
    Pitches.Add((Name = "Gb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_gb1'));
    Pitches.Add((Name = "G1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_g1'));
    Pitches.Add((Name = "Ab1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_ab1'));
    Pitches.Add((Name = "A1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_a1'));
    Pitches.Add((Name = "Bb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_bb1'));
    Pitches.Add((Name = "B1", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_b1'));
    
    Pitches.Add((Name = "C2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_c2'));
    Pitches.Add((Name = "Db2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_db2'));
    Pitches.Add((Name = "D2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_d2'));
    Pitches.Add((Name = "Eb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_eb2'));
    Pitches.Add((Name = "E2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_e2'));
    Pitches.Add((Name = "F2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_f2'));
    Pitches.Add((Name = "Gb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_gb2'));
    Pitches.Add((Name = "G2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_g2'));
    Pitches.Add((Name = "Ab2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_ab2'));
    Pitches.Add((Name = "A2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_a2'));
    Pitches.Add((Name = "Bb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_bb2'));
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_e6'));
    Pitches.Add((Name = "F6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_f6'));
    Pitches.Add((Name = "Gb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_gb6'));
    Pitches.Add((Name = "G6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_g6'));
    Pitches.Add((Name = "Ab6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_ab6'));
    Pitches.Add((Name = "A6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_a6'));
    Pitches.Add((Name = "Bb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_bb6'));
    Pitches.Add((Name = "B6", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_b6'));

    Pitches.Add((Name = "C7", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_c7'));
    Pitches.Add((Name = "Db7", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_db7'));
    Pitches.Add((Name = "D7", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_d7'));
    Pitches.Add((Name = "Eb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_eb7'));
    Pitches.Add((Name = "E7", Sound = SoundCue'Yoshi_MusicalUkulele_Content17.HonkyTonkSoundCues.HonkyTonk_e7'));
}