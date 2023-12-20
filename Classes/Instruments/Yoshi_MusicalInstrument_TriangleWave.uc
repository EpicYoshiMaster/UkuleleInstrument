//Credit to LMMS's NEScaline, Triangle Wave
class Yoshi_MusicalInstrument_TriangleWave extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=19
    InstrumentName="Triangle Wave"
    ShortName="TrW"

    CanReleaseNote=true
    FadeOutTime=0.0

    MinOctave=1 //B0
    MaxOctave=5 //E6
    DefaultOctave=3

    Pitches.Add((Name = "B0", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_b0'));

    Pitches.Add((Name = "C1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_c1'));
    Pitches.Add((Name = "Db1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_db1'));
    Pitches.Add((Name = "D1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_d1'));
    Pitches.Add((Name = "Eb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_eb1'));
    Pitches.Add((Name = "E1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_e1'));
    Pitches.Add((Name = "F1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_f1'));
    Pitches.Add((Name = "Gb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_gb1'));
    Pitches.Add((Name = "G1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_g1'));
    Pitches.Add((Name = "Ab1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_ab1'));
    Pitches.Add((Name = "A1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_a1'));
    Pitches.Add((Name = "Bb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_bb1'));
    Pitches.Add((Name = "B1", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_b1'));
    
    Pitches.Add((Name = "C2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_c2'));
    Pitches.Add((Name = "Db2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_db2'));
    Pitches.Add((Name = "D2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_d2'));
    Pitches.Add((Name = "Eb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_eb2'));
    Pitches.Add((Name = "E2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_e2'));
    Pitches.Add((Name = "F2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_f2'));
    Pitches.Add((Name = "Gb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_gb2'));
    Pitches.Add((Name = "G2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_g2'));
    Pitches.Add((Name = "Ab2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_ab2'));
    Pitches.Add((Name = "A2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_a2'));
    Pitches.Add((Name = "Bb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_bb2'));
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content11.TriangleSoundCues.Triangle_e6'));
}