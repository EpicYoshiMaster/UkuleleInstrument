//Credit to Alex's GM Soundfont Version 1.3 on Musical Artifacts - Cello
class Yoshi_MusicalInstrument_Cello extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=27
    InstrumentName="Cello"
    ShortName="Clo"

    Icon=Texture2D'HatInTime_Hud_Loadout.Item_Icons.itemicon_badge_sprint'

    CanReleaseNote=true
    FadeOutTime=0.15

    MinOctave=1 //B0
    MaxOctave=3 //E4
    DefaultOctave=2

    Pitches.Add((Name = "B0", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_b0'));

    Pitches.Add((Name = "C1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_c1'));
    Pitches.Add((Name = "Db1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_db1'));
    Pitches.Add((Name = "D1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_d1'));
    Pitches.Add((Name = "Eb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_eb1'));
    Pitches.Add((Name = "E1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_e1'));
    Pitches.Add((Name = "F1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_f1'));
    Pitches.Add((Name = "Gb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_gb1'));
    Pitches.Add((Name = "G1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_g1'));
    Pitches.Add((Name = "Ab1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_ab1'));
    Pitches.Add((Name = "A1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_a1'));
    Pitches.Add((Name = "Bb1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_bb1'));
    Pitches.Add((Name = "B1", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_b1'));
    
    Pitches.Add((Name = "C2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_c2'));
    Pitches.Add((Name = "Db2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_db2'));
    Pitches.Add((Name = "D2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_d2'));
    Pitches.Add((Name = "Eb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_eb2'));
    Pitches.Add((Name = "E2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_e2'));
    Pitches.Add((Name = "F2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_f2'));
    Pitches.Add((Name = "Gb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_gb2'));
    Pitches.Add((Name = "G2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_g2'));
    Pitches.Add((Name = "Ab2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_ab2'));
    Pitches.Add((Name = "A2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_a2'));
    Pitches.Add((Name = "Bb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_bb2'));
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_b2'));

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_c3'));
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_db3'));
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_d3'));
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_eb3'));
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_e3'));
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_f3'));
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_gb3'));
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_g3'));
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_ab3'));
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_a3'));
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_bb3'));
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_b3'));

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_c4'));
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_db4'));
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_d4'));
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_eb4'));
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content16.CelloSoundCues.Cello_e4'));
}