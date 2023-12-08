class Yoshi_NoteManager extends Object;

//This is for live notes, we don't know when they'll end
struct PlayerNote {
    var string KeyName;
    var AudioComponent Component;
};

struct PlayerNoteSet {
    var Actor Player;
    var array<PlayerNote> Notes;
};

//This is for song notes which have a defined start and end time
struct SongNote {
    var float Duration;
    var float FadeOutTime;
    var AudioComponent Component;
};

var Yoshi_UkuleleInstrument_GameMod GameMod;

var array<PlayerNoteSet> NoteSets;
var array<SongNote> SongNotes;

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod) {
    GameMod = MyGameMod;
}

function PlayNote(Actor Player, class<Yoshi_MusicalInstrument> Instrument, string KeyName, string NoteName) {
    local PlayerNoteSet NewNoteSet;
    local PlayerNote NewNote;
    local int i;

    NewNote.KeyName = KeyName;
    NewNote.Component = Instrument.static.PlayNote(Player, NoteName);

    if(!Instrument.default.CanReleaseNote) return;

    for(i = 0; i < NoteSets.Length; i++) {
        if(NoteSets[i].Player == Player) {
            NoteSets[i].Notes.AddItem(NewNote);
            return;
        }
    }

    NewNoteSet.Player = Player;
    NewNoteSet.Notes.AddItem(NewNote);

    NoteSets.AddItem(NewNoteSet);
}

function StopNote(Actor Player, string KeyName, float FadeOutTime) {
    local int i, j;

    for(i = 0; i < NoteSets.Length; i++) {
        if(NoteSets[i].Player != Player) continue;

        for(j = 0; j < NoteSets[i].Notes.Length; j++) {
            if(NoteSets[i].Notes[j].KeyName != KeyName) continue;

            if(NoteSets[i].Notes[j].Component != None) {
                NoteSets[i].Notes[j].Component.FadeOut(FadeOutTime, 0.0);
                
                NoteSets[i].Notes.Remove(j, 1);
                j--;
            }
        }

        return;
    }
}

function PlaySongNote(Actor Player, class<Yoshi_MusicalInstrument> Instrument, string NoteName, bool Hold, optional float Duration) {
    local SongNote NewNote;

    NewNote.Duration = Duration;
    NewNote.FadeOutTime = Instrument.default.FadeOutTime;
    NewNote.Component = Instrument.static.PlayNote(Player, NoteName);

    if(Hold && NewNote.Component != None) {
        SongNotes.AddItem(NewNote);
    }
}

function Tick(float delta) {
    local int i, j;

    for(i = 0; i < NoteSets.Length; i++) {
        //No notes? get out of here
        if(NoteSets[i].Notes.Length <= 0) {
            NoteSets.Remove(i, 1);
            i--;
            continue;
        }

        for(j = 0; j < NoteSets[i].Notes.Length; j++) {

            if(NoteSets[i].Notes[j].Component == None) {
                //No component!!!!!!!
                NoteSets[i].Notes.Remove(j, 1);
                j--;
                continue;
            }

            //No player? get this note out of here.
            if(NoteSets[i].Player == None) {
                NoteSets[i].Notes[j].Component.Stop();
                
                NoteSets[i].Notes.Remove(j, 1);
                j--;
                continue;
            }
            else {
                if(!NoteSets[i].Notes[j].Component.IsPlaying()) {
                    //You are done playing!!!!!!
                    NoteSets[i].Notes.Remove(j, 1);
                    j--;
                    continue;
                }
            }
        }
    }

    for(i = 0; i < SongNotes.Length; i++) {
        SongNotes[i].Duration -= delta;

        if(SongNotes[i].Duration <= 0) {
            if(SongNotes[i].Component != None) {
                SongNotes[i].Component.FadeOut(SongNotes[i].FadeOutTime, 0.0);
            }

            SongNotes.Remove(i, 1);
            i--;
        }
    }
}