class Yoshi_GhostPartyEmote_JammingOut extends Hat_GhostPartyEmote;

event static Activate(Actor Player, bool bPlaySound) {
    local PlayerTauntInfo PTI;
    local Yoshi_UkuleleInstrument_GameMod GM;

    if (Hat_Player(Player) != None) {
        GM = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

        if(GM.PlayingState == PS_IdleMode) {
            if(Player.Physics == Phys_Walking) {
                GM.InstrumentManager.AddPlayerInstrument(Hat_Player(Player), GM.CurrentInstrument.class);

                PTI.TauntDuration = GM.GetFurthestSongTimestamp(GM.PlayerSong);
                PTI.PlayerCanExit = false;
                PTI.TauntEndDelegate = GM.OnTauntEnd;

                Hat_Player(Player).Taunt("Ukulele_Play", PTI);
                Hat_Player(Player).PlayCustomAnimation('Ukulele_Play', true);
            }

            GM.SendOnlineSongPackage();
            GM.SetPlayingState(PS_PlaybackMode);
        }
    }

    Super.Activate(Player, bPlaySound);
}

defaultproperties
{
	DisplayName = "Yoshi_JammingOut_Emote_Name"
	WheelIndex = 8
}
