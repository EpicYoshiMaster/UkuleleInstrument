//Credit to Bedjka on the MuseScore Forums - Tenor Sax Soft
class Yoshi_MusicalInstrument_TenorSaxophone extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=11
    InstrumentName="Tenor Saxophone"

    CanReleaseNote=true
    FadeOutTime=0.3

    MinOctave=2 //B1
    MaxOctave=5 //E6
    DefaultOctave=3

    Pitches.Add((Name = "B1", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_b1'));

    Pitches.Add((Name = "C2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_c2'));
    Pitches.Add((Name = "Db2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_db2'));
    Pitches.Add((Name = "D2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_d2'));
    Pitches.Add((Name = "Eb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_eb2'));
    Pitches.Add((Name = "E2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_e2'));
    Pitches.Add((Name = "F2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_f2'));
    Pitches.Add((Name = "Gb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_gb2'));
    Pitches.Add((Name = "G2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_g2'));
    Pitches.Add((Name = "Ab2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_ab2'));
    Pitches.Add((Name = "A2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_a2'));
    Pitches.Add((Name = "Bb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_bb2'));
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.TenorSaxSoundCues.TenorSax_e6'));
}