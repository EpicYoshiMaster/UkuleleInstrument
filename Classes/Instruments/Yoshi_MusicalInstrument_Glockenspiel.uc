//Credit to Ethan Winer
class Yoshi_MusicalInstrument_Glockenspiel extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=3
    InstrumentName="Glockenspiel"
    ShortName="Gsp"

    Icon=Texture2D'HatInTime_Hud_ItemIcons3.DYE_obnoxious'

    MinOctave=5 //C5
    MaxOctave=7 //E8
    DefaultOctave=5

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_e6'));
    Pitches.Add((Name = "F6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_f6'));
    Pitches.Add((Name = "Gb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_gb6'));
    Pitches.Add((Name = "G6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_g6'));
    Pitches.Add((Name = "Ab6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_ab6'));
    Pitches.Add((Name = "A6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_a6'));
    Pitches.Add((Name = "Bb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_bb6'));
    Pitches.Add((Name = "B6", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_b6'));

    Pitches.Add((Name = "C7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_c7'));
    Pitches.Add((Name = "Db7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_db7'));
    Pitches.Add((Name = "D7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_d7'));
    Pitches.Add((Name = "Eb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_eb7'));
    Pitches.Add((Name = "E7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_e7'));
    Pitches.Add((Name = "F7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_f7'));
    Pitches.Add((Name = "Gb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_gb7'));
    Pitches.Add((Name = "G7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_g7'));
    Pitches.Add((Name = "Ab7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_ab7'));
    Pitches.Add((Name = "A7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_a7'));
    Pitches.Add((Name = "Bb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_bb7'));
    Pitches.Add((Name = "B7", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_b7'));

    Pitches.Add((Name = "C8", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_c8'));
    Pitches.Add((Name = "Db8", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_db8'));
    Pitches.Add((Name = "D8", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_d8'));
    Pitches.Add((Name = "Eb8", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_eb8'));
    Pitches.Add((Name = "E8", Sound = SoundCue'Yoshi_MusicalUkulele_Content2.GlockSoundCues.Glock_e8'));
}