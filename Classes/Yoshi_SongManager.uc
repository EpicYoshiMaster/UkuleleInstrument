class Yoshi_SongManager extends Object;

const MinimumSongTime = 1.5;
const OnlineSongNotesLimit = 250;

const DelimiterLayer = "&";
const DelimiterInstrument = "=";
const DelimiterNote = "/";
const DelimiterPitch = "|";

const SavedSongsPath = "MusicalInstruments/EmoteSong.Song";
const SongFormatVersion = 3;

//One note consists of a certain Pitch and Timestamp
struct SingleNote {
    var string Pitch;
    var float Timestamp;
    var bool Hold;
    var float Duration;
    var string KeyName;
};

//One layer consists of several notes assigned to a specific instrument
struct SongLayer {
    var class<Yoshi_MusicalInstrument> Instrument;
    var int LastPlayedNoteIndex;
    var array<SingleNote> Notes;
};

//Holds Song Data + Playback Information
struct SongPlaybackStatus {
    var float Time;
    var float FurthestTimestamp;
    var Actor Player;
    var string SongName;
    var array<SongLayer> Layers;
};

struct SavedSong {
    var string SongName;
    var array<SongLayer> Layers;
};

var Yoshi_UkuleleInstrument_GameMod GameMod;
var Yoshi_NoteManager NoteManager;
var Yoshi_RecordManager RecordManager;

var bool PlayingPlayerSong;
var int SkipLayer;

var SongPlaybackStatus PlayerSong; //Holds the player's saved song
var array<SongPlaybackStatus> OPSongs; //Holds all active Emote Songs being played

var array<SavedSong> SavedSongs;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod) {
    local int SongIndex;

    GameMod = MyGameMod;
    NoteManager = GameMod.NoteManager;
    RecordManager = GameMod.RecordManager;

    LoadSongs();

    SongIndex = GameMod.Settings.SongIndex;

    if(SongIndex < SavedSongs.Length) {
        PlayerSong.SongName = SavedSongs[SongIndex].SongName;
        PlayerSong.Layers = SavedSongs[SongIndex].Layers;
    }
}

function PlayPlayerSong(Hat_Player Ply, optional int RecordingSkipLayer = -1) {
    local int i;

    SkipLayer = RecordingSkipLayer;
    PlayingPlayerSong = true;

    PlayerSong.Player = Ply;
    PlayerSong.Time = 0.0;
    PlayerSong.FurthestTimestamp = GetFurthestSongTimestamp(PlayerSong);
    
    for(i = 0; i < PlayerSong.Layers.Length; i++) {
        PlayerSong.Layers[i].LastPlayedNoteIndex = 0;
    }
}

function StopPlayerSong() {
    SkipLayer = -1;

    PlayingPlayerSong = false;
}

function SaveRecordedLayer(SongLayer RecordLayer, int LayerIndex, int SongIndex) {
    local SongLayer NewLayer;
    local SavedSong NewSong;

    while(PlayerSong.Layers.Length <= LayerIndex) {
        PlayerSong.Layers.AddItem(NewLayer);
    }

    PlayerSong.Layers[LayerIndex] = RecordLayer;

    //This shouldn't be needed technically
    while(SavedSongs.Length <= SongIndex) {
        NewSong.SongName = "Song " $ (SongIndex + 1);
        SavedSongs.AddItem(NewSong);
    }

    SavedSongs[SongIndex].SongName = PlayerSong.SongName;
    SavedSongs[SongIndex].Layers = PlayerSong.Layers;

    SaveSongs();
}

function SetSongIndex(int NewIndex) {
    local SavedSong NewSong;

    while(NewIndex >= SavedSongs.Length) {
        NewSong.SongName = "Song " $ (NewIndex + 1);
        SavedSongs.AddItem(NewSong);
    }

    PlayerSong.SongName = SavedSongs[NewIndex].SongName;
    PlayerSong.Layers = SavedSongs[NewIndex].Layers;
}

function bool IsPlayingPlayerSong() {
    return PlayingPlayerSong;
}

function PlayOnlineSong(string Command, Actor Player) {
    local SongPlaybackStatus NewOnlineSong;

    NewOnlineSong = DecodeOnlineSongPackage(Command, Player);

    OPSongs.AddItem(NewOnlineSong);
}

function Tick(float delta) {
    local int i;

    if(PlayingPlayerSong) {
        PlayerSong = TickSong(PlayerSong, delta, SkipLayer);
        if(!RecordManager.IsRecording && PlayerSong.Time >= PlayerSong.FurthestTimestamp) {
            PlayingPlayerSong = false;
        }
    }

    for(i = 0; i < OPSongs.Length; i++) {
        OPSongs[i] = TickSong(OPSongs[i], delta);
        if(OPSongs[i].Time >= OPSongs[i].FurthestTimestamp) {
            OPSongs.Remove(i, 1);
            i--;
        }
    }
}

//Updates for the current tick, plays all associated notes, and updates the last played index for each layer
function SongPlaybackStatus TickSong(SongPlaybackStatus Song, float Delta, optional int RecordingSkipLayer = -1) {
    local int i;
    local SingleNote CurrentNote;

    Song.Time += Delta;

    for(i = 0; i < Song.Layers.Length; i++) {
        if(i == RecordingSkipLayer) continue;

        while(Song.Layers[i].LastPlayedNoteIndex < Song.Layers[i].Notes.Length && Song.Time >= Song.Layers[i].Notes[Song.Layers[i].LastPlayedNoteIndex].Timestamp) {
            CurrentNote = Song.Layers[i].Notes[Song.Layers[i].LastPlayedNoteIndex];
            NoteManager.PlaySongNote(Song.Player, Song.Layers[i].Instrument, CurrentNote.Pitch, CurrentNote.Hold, CurrentNote.Duration);
            Song.Layers[i].LastPlayedNoteIndex++;
        }
    }

    return Song;
}

function int GetPlayerSongNoteCount() {
    local int NoteCount;
    local int i;

    NoteCount = 0;

    for(i = 0; i < PlayerSong.Layers.Length; i++) {
        if(i == SkipLayer) continue;

        NoteCount += PlayerSong.Layers[i].Notes.Length;
    }

    if(RecordManager.IsRecording) {
        NoteCount += RecordManager.RecordLayer.Notes.Length;
    }

    return NoteCount;
}

function float GetFurthestSongTimestamp(SongPlaybackStatus Song) {
    local int i, j;
    local float NoteTime;
    local float FurthestTimestamp;

    FurthestTimestamp = 0.0;

    for(i = 0; i < Song.Layers.Length; i++) {
        if(Song.Layers[i].Notes.Length <= 0) continue;

        for(j = 0; j < Song.Layers[i].Notes.Length; j++) {
            NoteTime = Song.Layers[i].Notes[j].Timestamp;

            if(Song.Layers[i].Notes[j].Hold) {
                NoteTime += Song.Layers[i].Notes[j].Duration;
            }

            if(NoteTime > FurthestTimestamp) {
                FurthestTimestamp = NoteTime;
            }
        }
    }

    return FMax(FurthestTimestamp, MinimumSongTime);
}

function SendOnlineSongPackage() {
    local string SongPackage;
    local int i, j, NoteCount;

    NoteCount = GetPlayerSongNoteCount();

    if(!GameMod.Settings.OnlineSongs) return;
    if(NoteCount > OnlineSongNotesLimit || NoteCount <= 0) return;

    for(i = 0; i < PlayerSong.Layers.Length; i++) {
        //Layer&Layer&...
        if(i > 0) {
            SongPackage $= DelimiterLayer;
        }

        //ShortName=Note/Note/Note/...

        SongPackage $= PlayerSong.Layers[i].Instrument.default.ShortName $ DelimiterInstrument;

        for(j = 0; j < PlayerSong.Layers[i].Notes.Length; j++) {
            if(j > 0) {
                SongPackage $= DelimiterNote;
            }

            //Pitch|Time|Duration
            //           (Optional)

            SongPackage $= PlayerSong.Layers[i].Notes[j].Pitch $ DelimiterPitch $ int(PlayerSong.Layers[i].Notes[j].Timestamp * 1000);

            if(PlayerSong.Layers[i].Notes[j].Hold)  {
                SongPackage $= DelimiterPitch $ int(PlayerSong.Layers[i].Notes[j].Duration * 1000);
            }
        }
    }

    GameMod.Sync(SongPackage, class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiMusicSong);
}

function SongPlaybackStatus DecodeOnlineSongPackage(string SongPackage, Actor Player) {
    local SongPlaybackStatus Song;
    local SongLayer NewLayer;
    local SingleNote Note;
    local array<string> SongLayers;
    local array<string> SongInstrumentSplit;
    local array<string> SongNotes;
    local array<string> SongNote;
    local int i, j;

    //Layer&Layer&...
    SongLayers = SplitString(SongPackage, DelimiterLayer);

    if(SongLayers.Length <= 0 || Player == None) return Song;

    for(i = 0; i < SongLayers.Length; i++) {
        //ShortName=Note/Note/Note/...

        SongInstrumentSplit = SplitString(SongLayers[i], DelimiterInstrument);
        if(SongInstrumentSplit.Length != 2) continue;

        NewLayer.Instrument = GameMod.GetInstrumentClass(SongInstrumentSplit[0]); //change to class
        SongNotes = SplitString(SongInstrumentSplit[1], DelimiterNote);

        for(j = 0; j < SongNotes.Length; j++) {
            //Pitch|Time|Duration
            //           (Optional)

            SongNote = SplitString(SongNotes[j], DelimiterPitch);
            if(SongNote.Length < 2) continue;

            Note.Pitch = SongNote[0];
            Note.Timestamp = float(SongNote[1]) / 1000;

            if(SongNote.Length >= 3) {
                Note.Hold = true;
                Note.Duration = float(SongNote[2]) / 1000;
            }

            NewLayer.Notes.AddItem(Note);
        }

        Song.Layers.AddItem(NewLayer);
    }

    Song.Player = Player;
    Song.FurthestTimestamp = GetFurthestSongTimestamp(Song);

    return Song;
}

function LoadSongs() {
    local Yoshi_Storage_MusicalSong SongsStorage;

    SongsStorage = new class'Yoshi_Storage_MusicalSong';

    class'Engine'.static.BasicLoadObject(SongsStorage, SavedSongsPath, false, SongFormatVersion);

    SavedSongs = SongsStorage.Songs;

    if(GameMod.Settings.SongIndex < SavedSongs.Length) {
        PlayerSong.SongName = SavedSongs[GameMod.Settings.SongIndex].SongName;
        PlayerSong.Layers = SavedSongs[GameMod.Settings.SongIndex].Layers;
    }
}

function SaveSongs() {
    local Yoshi_Storage_MusicalSong SongsStorage;

    SongsStorage = new class'Yoshi_Storage_MusicalSong';
    SongsStorage.Songs = SavedSongs;

    class'Engine'.static.BasicSaveObject(SongsStorage, SavedSongsPath, false, SongFormatVersion);
}

function DeleteSong(int RemoveSongIndex) {
    PlayerSong.SongName = "Song " $ (RemoveSongIndex + 1);
    PlayerSong.Layers.Length = 0;

    if(RemoveSongIndex < SavedSongs.Length) {
        SavedSongs.Remove(RemoveSongIndex, 1);
    }

    SaveSongs();
}

defaultproperties
{
    PlayerSong=(SongName="Song 1")
}