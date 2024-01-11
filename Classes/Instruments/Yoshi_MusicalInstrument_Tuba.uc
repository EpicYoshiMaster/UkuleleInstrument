//Credit to Alex's GM Soundfont Version 1.3 on Musical Artifacts - Tuba
class Yoshi_MusicalInstrument_Tuba extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=8
    InstrumentName="Tuba"
    ShortName="Tba"

    CanReleaseNote=true
    FadeOutTime=0.3

    MinOctave=1 //B0
    MaxOctave=3 //E4
    DefaultOctave=2

    Pitches.Add((Name = "B0", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_b0'));

    Pitches.Add((Name = "C1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_c1'));
    Pitches.Add((Name = "Db1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_db1'));
    Pitches.Add((Name = "D1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_d1'));
    Pitches.Add((Name = "Eb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_eb1'));
    Pitches.Add((Name = "E1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_e1'));
    Pitches.Add((Name = "F1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_f1'));
    Pitches.Add((Name = "Gb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_gb1'));
    Pitches.Add((Name = "G1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_g1'));
    Pitches.Add((Name = "Ab1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_ab1'));
    Pitches.Add((Name = "A1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_a1'));
    Pitches.Add((Name = "Bb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_bb1'));
    Pitches.Add((Name = "B1", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_b1'));
    
    Pitches.Add((Name = "C2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_c2'));
    Pitches.Add((Name = "Db2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_db2'));
    Pitches.Add((Name = "D2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_d2'));
    Pitches.Add((Name = "Eb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_eb2'));
    Pitches.Add((Name = "E2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_e2'));
    Pitches.Add((Name = "F2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_f2'));
    Pitches.Add((Name = "Gb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_gb2'));
    Pitches.Add((Name = "G2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_g2'));
    Pitches.Add((Name = "Ab2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_ab2'));
    Pitches.Add((Name = "A2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_a2'));
    Pitches.Add((Name = "Bb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_bb2'));
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.TubaSoundCues.Tuba_e4'));
}