//Credit to Alex's GM Soundfont Version 1.3 on Musical Artifacts - Standard Drums
class Yoshi_MusicalInstrument_DrumSet extends Yoshi_MusicalInstrument;

defaultproperties
{
    InstrumentID=13
    InstrumentName="Drum Set"
    ShortName="Drm"

    CanReleaseNote=false

    MinOctave=2 //B1
    MaxOctave=5 //Eb6
    DefaultOctave=2

    //Drums are interesting, since they're not actually using the pitch system at all.
    //We do treat them like they do though!
    
    //I have them mapped according to the General MIDI Percussion Key Map, mirroring the octaves used by the soundfont
    //as I noticed none that I found actually matched starting at B0.
    //https://musescore.org/sites/musescore.org/files/General%20MIDI%20Standard%20Percussion%20Set%20Key%20Map.pdf

    Pitches.Add((Name = "B1", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_b1')); //Acoustic Bass Drum

    Pitches.Add((Name = "C2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_c2')); //Bass Drum 1
    Pitches.Add((Name = "Db2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_db2')); //Side Stick
    Pitches.Add((Name = "D2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_d2')); //Acoustic Snare
    Pitches.Add((Name = "Eb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_eb2')); //Hand Clap
    Pitches.Add((Name = "E2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_e2')); //Electric Snare
    Pitches.Add((Name = "F2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_f2')); //Low Floor Tom
    Pitches.Add((Name = "Gb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_gb2')); //Closed Hi Hat
    Pitches.Add((Name = "G2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_g2')); //High Floor Tom
    Pitches.Add((Name = "Ab2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_ab2')); //Pedal Hi-Hat
    Pitches.Add((Name = "A2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_a2')); //Low Tom
    Pitches.Add((Name = "Bb2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_bb2')); //Open Hi-Hat
    Pitches.Add((Name = "B2", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_b2')); //Low Mid Tom

    Pitches.Add((Name = "C3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_c3')); //Hi Mid Tom
    Pitches.Add((Name = "Db3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_db3')); //Crash Cymbal 1
    Pitches.Add((Name = "D3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_d3')); //High Tom
    Pitches.Add((Name = "Eb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_eb3')); //Ride Cymbal 1
    Pitches.Add((Name = "E3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_e3')); //Chinese Cymbal
    Pitches.Add((Name = "F3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_f3')); //Ride Bell
    Pitches.Add((Name = "Gb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_gb3')); //Tambourine
    Pitches.Add((Name = "G3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_g3')); //Splash Cymbal 
    Pitches.Add((Name = "Ab3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_ab3')); //Cowbell 
    Pitches.Add((Name = "A3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_a3')); //Crash Cymbal 2
    Pitches.Add((Name = "Bb3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_bb3')); //Vibraslap
    Pitches.Add((Name = "B3", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_b3')); //Ride Cymbal 2

    Pitches.Add((Name = "C4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_c4')); //Hi Bongo
    Pitches.Add((Name = "Db4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_db4')); //Low Bongo
    Pitches.Add((Name = "D4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_d4')); //Mute Hi Conga
    Pitches.Add((Name = "Eb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_eb4')); //Open Hi Conga
    Pitches.Add((Name = "E4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_e4')); //Low Conga
    Pitches.Add((Name = "F4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_f4')); //High Timbale
    Pitches.Add((Name = "Gb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_gb4')); //Low Timbale
    Pitches.Add((Name = "G4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_g4')); //High Agogo
    Pitches.Add((Name = "Ab4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_ab4')); //Low Agogo
    Pitches.Add((Name = "A4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_a4')); //Cabasa
    Pitches.Add((Name = "Bb4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_bb4')); //Maracas
    Pitches.Add((Name = "B4", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_b4')); //Short Whistle

    Pitches.Add((Name = "C5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_c5')); //Long Whistle
    Pitches.Add((Name = "Db5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_db5')); //Short Guiro
    Pitches.Add((Name = "D5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_d5')); //Long Guiro
    Pitches.Add((Name = "Eb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_eb5')); //Claves
    Pitches.Add((Name = "E5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_e5')); //Hi Wood Block
    Pitches.Add((Name = "F5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_f5')); //Low Wood Block
    Pitches.Add((Name = "Gb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_gb5')); //Mute Cuica
    Pitches.Add((Name = "G5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_g5')); //Open Cuica
    Pitches.Add((Name = "Ab5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_ab5')); //Mute Triangle
    Pitches.Add((Name = "A5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_a5')); //Open Triangle
    Pitches.Add((Name = "Bb5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_bb5')); //Cabasa
    Pitches.Add((Name = "B5", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_b5')); //Sleigh Bells

    Pitches.Add((Name = "C6", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_c6')); //Chimes
    Pitches.Add((Name = "Db6", Sound = SoundCue'Yoshi_MusicalUkulele_Content6.DrumSetSoundCues.DrumSet_db6')); //Castanets
    Pitches.Add((Name = "D6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.MetronomeSoundCues.Perc_MetronomeQuartz_hi')); //High Metronome (Not SF)
    Pitches.Add((Name = "Eb6", Sound = SoundCue'Yoshi_MusicalUkulele_Content.MetronomeSoundCues.Perc_MetronomeQuartz_lo')); //Low Metronome (Not SF)
}