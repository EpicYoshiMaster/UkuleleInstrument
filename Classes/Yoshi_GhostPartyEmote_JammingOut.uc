class Yoshi_GhostPartyEmote_JammingOut extends Hat_GhostPartyEmote;

event static Activate(Actor Player, bool bPlaySound)
{
    local PlayerTauntInfo PTI;
    local Yoshi_UkuleleInstrument_GameMod GM;
    Super.Activate(Player, bPlaySound);
    
    if (Player.IsA('Hat_GhostPartyPlayer'))
    {
        
        if (Hat_GhostPartyPlayer(Player).SkeletalMeshComponent.AnimSets.Find(AnimSet'Ctm_Ukulele.Ukulele_playing') == INDEX_NONE)
        {
            Hat_GhostPartyPlayer(Player).SkeletalMeshComponent.AnimSets.AddItem(AnimSet'Ctm_Ukulele.Ukulele_playing');
            Hat_GhostPartyPlayer(Player).SkeletalMeshComponent.UpdateAnimations();
        }
    }
    else if (Player.IsA('Hat_Player'))
    {
        GM = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();
        if(Hat_Player(Player).Mesh.AnimSets.Find(AnimSet'Ctm_Ukulele.Ukulele_playing') == INDEX_NONE) {
            Hat_Player(Player).Mesh.AnimSets.AddItem(AnimSet'Ctm_Ukulele.Ukulele_playing');
            Hat_Player(Player).Mesh.UpdateAnimations();
        }

        if(GM.GetPlayingSong() == -1) {
            if(Player.Physics == Phys_Walking) {
                if(!Hat_Player(Player).HasStatusEffect(class'Yoshi_StatusEffect_Ukulele', false)) {
                    Hat_Player(Player).GiveStatusEffect(class'Yoshi_StatusEffect_Ukulele');
                }

                PTI.TauntDuration = GM.GetFurthestSongTimestamp();
                PTI.PlayerCanExit = false;
                Hat_Player(Player).Taunt("Ukulele_Play", PTI);
                Hat_Player(Player).PlayCustomAnimation('Ukulele_Play', true);
            }
            
            GM.PrepareOnlineSongPackage();
            GM.SetPlayingSong(0);
        }
        
    }
}
defaultproperties
{
	DisplayName = "Yoshi_JammingOut_Emote_Name"
	WheelIndex = 8
}
