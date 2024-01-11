//Credit to Saul Cross's VST Super Spook Keys
class Yoshi_MusicalInstrument_Theremin extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=29
    InstrumentName="Theremin"
    ShortName="Thm"

    Icon=Texture2D'HatInTime_Hud_Loadout.Item_Icons.itemicon_badge_sprint'

    CanReleaseNote=true
    FadeOutTime=0.3

    MinOctave=3 //B2
    MaxOctave=7 //E8
    DefaultOctave=5
    
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_e6'));
    Pitches.Add((Name = "F6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_f6'));
    Pitches.Add((Name = "Gb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_gb6'));
    Pitches.Add((Name = "G6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_g6'));
    Pitches.Add((Name = "Ab6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_ab6'));
    Pitches.Add((Name = "A6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_a6'));
    Pitches.Add((Name = "Bb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_bb6'));
    Pitches.Add((Name = "B6", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_b6'));

    Pitches.Add((Name = "C7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_c7'));
    Pitches.Add((Name = "Db7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_db7'));
    Pitches.Add((Name = "D7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_d7'));
    Pitches.Add((Name = "Eb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_eb7'));
    Pitches.Add((Name = "E7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_e7'));
    Pitches.Add((Name = "F7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_f7'));
    Pitches.Add((Name = "Gb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_gb7'));
    Pitches.Add((Name = "G7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_g7'));
    Pitches.Add((Name = "Ab7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_ab7'));
    Pitches.Add((Name = "A7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_a7'));
    Pitches.Add((Name = "Bb7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_bb7'));
    Pitches.Add((Name = "B7", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_b7'));

    Pitches.Add((Name = "C8", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_c8'));
    Pitches.Add((Name = "Db8", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_db8'));
    Pitches.Add((Name = "D8", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_d8'));
    Pitches.Add((Name = "Eb8", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_eb8'));
    Pitches.Add((Name = "E8", Sound = SoundCue'Yoshi_MusicalUkulele_Content13.ThereminSoundCues.Theremin_e8'));
}