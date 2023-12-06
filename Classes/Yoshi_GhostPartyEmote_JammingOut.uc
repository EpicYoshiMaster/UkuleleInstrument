class Yoshi_GhostPartyEmote_JammingOut extends Hat_GhostPartyEmote;

event static Activate(Actor Player, bool bPlaySound) {
    local Yoshi_UkuleleInstrument_GameMod GM;

    if (Hat_Player(Player) != None) {
        GM = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();
        GM.OnActivateEmote(Hat_Player(Player));
    }

    Super.Activate(Player, bPlaySound);
}

defaultproperties
{
	DisplayName = "Yoshi_JammingOut_Emote_Name"
	WheelIndex = 8
}
