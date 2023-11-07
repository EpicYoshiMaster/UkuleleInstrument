//Credit to 快乐爱的小精灵 (Elf of Happy and Love) on FreePats - Synth Bass + Lead
class Yoshi_MusicalInstrument_SynthLead extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=12
    InstrumentName="Synth Lead"

    CanReleaseNote=true
    FadeOutTime=0.3

    MinOctave=1 //B0
    MaxOctave=6 //E7
    DefaultOctave=4

    Pitches.Add((Name = "B0", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_b0'));

    Pitches.Add((Name = "C1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_c1'));
    Pitches.Add((Name = "Db1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_db1'));
    Pitches.Add((Name = "D1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_d1'));
    Pitches.Add((Name = "Eb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_eb1'));
    Pitches.Add((Name = "E1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_e1'));
    Pitches.Add((Name = "F1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_f1'));
    Pitches.Add((Name = "Gb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_gb1'));
    Pitches.Add((Name = "G1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_g1'));
    Pitches.Add((Name = "Ab1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_ab1'));
    Pitches.Add((Name = "A1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_a1'));
    Pitches.Add((Name = "Bb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_bb1'));
    Pitches.Add((Name = "B1", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_b1'));
    
    Pitches.Add((Name = "C2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_c2'));
    Pitches.Add((Name = "Db2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_db2'));
    Pitches.Add((Name = "D2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_d2'));
    Pitches.Add((Name = "Eb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_eb2'));
    Pitches.Add((Name = "E2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_e2'));
    Pitches.Add((Name = "F2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_f2'));
    Pitches.Add((Name = "Gb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_gb2'));
    Pitches.Add((Name = "G2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_g2'));
    Pitches.Add((Name = "Ab2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_ab2'));
    Pitches.Add((Name = "A2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_a2'));
    Pitches.Add((Name = "Bb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_bb2'));
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_e6'));
    Pitches.Add((Name = "F6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_f6'));
    Pitches.Add((Name = "Gb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_gb6'));
    Pitches.Add((Name = "G6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_g6'));
    Pitches.Add((Name = "Ab6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_ab6'));
    Pitches.Add((Name = "A6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_a6'));
    Pitches.Add((Name = "Bb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_bb6'));
    Pitches.Add((Name = "B6", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_b6'));

    Pitches.Add((Name = "C7", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_c7'));
    Pitches.Add((Name = "Db7", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_db7'));
    Pitches.Add((Name = "D7", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_d7'));
    Pitches.Add((Name = "Eb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_eb7'));
    Pitches.Add((Name = "E7", Sound = SoundCue'Yoshi_MusicalUkulele_Content7.SynthLeadSoundCues.SynthLead_e7'));
}