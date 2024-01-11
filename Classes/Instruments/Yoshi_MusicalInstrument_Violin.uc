//Credit to TripleS, using the All-Around Violin Soundfont - Fast Violin
class Yoshi_MusicalInstrument_Violin extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=17
    InstrumentName="Violin"
    ShortName="Vln"

    CanReleaseNote=true
    FadeOutTime=0.3

    MinOctave=4 //B3
    MaxOctave=6 //E7
    DefaultOctave=4
    
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_e6'));
    Pitches.Add((Name = "F6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_f6'));
    Pitches.Add((Name = "Gb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_gb6'));
    Pitches.Add((Name = "G6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_g6'));
    Pitches.Add((Name = "Ab6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_ab6'));
    Pitches.Add((Name = "A6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_a6'));
    Pitches.Add((Name = "Bb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_bb6'));
    Pitches.Add((Name = "B6", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_b6'));

    Pitches.Add((Name = "C7", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_c7'));
    Pitches.Add((Name = "Db7", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_db7'));
    Pitches.Add((Name = "D7", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_d7'));
    Pitches.Add((Name = "Eb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_eb7'));
    Pitches.Add((Name = "E7", Sound = SoundCue'Yoshi_MusicalUkulele_Content5.ViolinSoundCues.Violin_e7'));
}