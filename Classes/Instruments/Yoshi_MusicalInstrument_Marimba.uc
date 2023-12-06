//Credit to Versilian Studios
class Yoshi_MusicalInstrument_Marimba extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=5
    InstrumentName="Marimba"
    ShortName="Mba"

    Icon=Texture2D'HatInTime_Hud_Loadout.Overview.cloth_points'

    MinOctave=3 //B2
    MaxOctave=5 //E6
    DefaultOctave=4

    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_e4'));
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_f4'));
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_gb4'));
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_g4'));
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_ab4'));
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_a4'));
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_bb4'));
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_b4'));

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_c5'));
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_db5'));
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_d5'));
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_eb5'));
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_e5'));
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_f5'));
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_gb5'));
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_g5'));
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_ab5'));
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_a5'));
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_bb5'));
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_b5'));

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_c6'));
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_db6'));
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_d6'));
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_eb6'));
    Pitches.Add((Name = "E6", Sound = SoundCue'Yoshi_MusicalUkulele_Content3.MarimbaSoundCues.Marimba_e6'));
}