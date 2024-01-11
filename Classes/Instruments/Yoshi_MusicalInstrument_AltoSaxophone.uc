//Credit to Alex's GM Soundfont Version 1.3 on Musical Artifacts - Alto Sax
class Yoshi_MusicalInstrument_AltoSaxophone extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=11
    InstrumentName="Alto Saxophone"
    ShortName="ASx"

    CanReleaseNote=true
    FadeOutTime=0.3

    MinOctave=3 //B2
    MaxOctave=5 //E6
    DefaultOctave=4

    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content15.AltoSaxSoundCues.AltoSax_e6'));
}