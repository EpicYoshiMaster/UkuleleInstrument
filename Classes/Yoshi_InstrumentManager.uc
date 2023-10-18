class Yoshi_InstrumentManager extends Object;

var Hat_Player Player;
var Yoshi_UkuleleInstrument_GameMod GameMod;
var class<Yoshi_MusicalInstrument> EquippedClass;
var SkeletalMeshComponent InstrumentMesh;
var bool IsPlayerEquipped;

struct OPInstrument {
    var Hat_GhostPartyPlayer GPP;
    var class<Yoshi_MusicalInstrument> EquippedClass;
    var SkeletalMeshComponent InstrumentMesh;
    var bool IsEquipped;
};

var array<OPInstrument> OPInstruments;

function AddPlayerInstrument(Hat_Player Ply, class<Yoshi_MusicalInstrument> InstrumentClass) {
    local bool WasPlayerEquipped;

    if(Ply == None) return;
    if(GameMod == None) GameMod = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

    Player = Ply;

    WasPlayerEquipped = IsPlayerEquipped;

    IsPlayerEquipped = CheckInstrumentStatus(Ply.Mesh, EquippedClass, InstrumentClass, instrumentMesh, IsPlayerEquipped);

    if(!WasPlayerEquipped && IsPlayerEquipped) {
        GameMod.Sync(InstrumentClass.default.InstrumentName $ "|false", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument);
    }

    if(IsPlayerEquipped) return;

    //If we get this far, we are ready to add a new instrument
    UpdateAnimSet(Player.Mesh, InstrumentClass.default.AnimSet, true);
    EquippedClass = InstrumentClass;
    IsPlayerEquipped = true;
    InstrumentMesh = AttachInstrument(Player.Mesh, InstrumentClass.default.Mesh);
    GameMod.Sync(InstrumentClass.default.InstrumentName $ "|false", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument);
}

function RemovePlayerInstrument() {
    if(Player == None) return;
    if(GameMod == None) GameMod = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

    StopStrumAnim(Player.Mesh);

    if(InstrumentMesh != None && InstrumentMesh.bAttached) {
        DetachInstrument(Player.Mesh, InstrumentMesh);
    }

    UpdateAnimSet(Player.Mesh, EquippedClass.default.AnimSet, false);

    IsPlayerEquipped = false;

    GameMod.Sync("Hello there :D", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiRemoveInstrument);
}

function bool IsPlayerInstrumentEquipped() {
    return Player != None && IsPlayerEquipped;
}

function PlayerTickInstrument() {
    local Hat_AnimNodeRandomIdle Anim;

    if(Player == None) return;
    if(!IsPlayerEquipped) return;

	foreach Player.Mesh.AllAnimNodes(class'Hat_AnimNodeRandomIdle', Anim) {
		Anim.CurrentCountdown = Anim.TimeUntilIdle;
	}
}

//for each player we need to be checking
//Do they have this instrument class (ignore that there's only the ukulele mesh I want to future proof)
//If it is a different class, we should remove

function AddOPInstrument(Hat_GhostPartyPlayer GPP, class<Yoshi_MusicalInstrument> InstrumentClass, optional bool ForceAnim = false) {
    local int i;
    local OPInstrument NewUser;

    CleanUpInstruments();

    if(GPP == None) return;

    for(i = 0; i < OPInstruments.Length; i++) {
        //This player already has an Instrument but it needs to be attached again
        if(OPInstruments[i].GPP == GPP) {

            OPInstruments[i].IsEquipped = CheckInstrumentStatus(GPP.SkeletalMeshComponent, OPInstruments[i].EquippedClass, InstrumentClass, OPInstruments[i].InstrumentMesh, OPInstruments[i].IsEquipped);

            if(OPInstruments[i].IsEquipped) {
                if(ForceAnim) PlayStrumAnim(GPP.SkeletalMeshComponent, true);
                return;
            }

            //If we're not ready by now, get rid of this entry and make a new one
            OPInstruments.Remove(i, 1);
            break;
        }
    }
    
    UpdateAnimSet(GPP.SkeletalMeshComponent, InstrumentClass.default.AnimSet, true);
    NewUser.GPP = GPP;
    NewUser.EquippedClass = InstrumentClass;
    NewUser.InstrumentMesh = AttachInstrument(GPP.SkeletalMeshComponent, InstrumentClass.default.Mesh);
    NewUser.IsEquipped = true;

    if(ForceAnim) PlayStrumAnim(GPP.SkeletalMeshComponent, true);

    OPInstruments.AddItem(NewUser);
}

function RemoveOPInstrument(Hat_GhostPartyPlayer GPP) {
    local int i;

    if(GPP == None) return;

    for(i = 0; i < OPInstruments.Length; i++) {
        if(OPInstruments[i].GPP == GPP && OPInstruments[i].IsEquipped) {
            OPInstruments[i].IsEquipped = false;
            if(OPInstruments[i].InstrumentMesh != None) {
                UpdateAnimSet(GPP.SkeletalMeshComponent, OPInstruments[i].EquippedClass.default.AnimSet, false);
                DetachInstrument(GPP.SkeletalMeshComponent, OPInstruments[i].InstrumentMesh);
            }
        }

        if(OPInstruments[i].GPP == None) {
            OPInstruments.Remove(i, 1);
            i--;
        }
    }
}

function CleanUpInstruments() {
    local int i;
    for(i = 0; i < OPInstruments.Length; i++) {
        if(OPInstruments[i].GPP == None) {
            OPInstruments.Remove(i, 1);
            i--;
        }
    }
}

//Checks our current instrument status and determines if we need to add a new instrument
//Returns true if we are now equipped correctly, and false if we need a new instrument
//Updates equip status as well
function bool CheckInstrumentStatus(SkeletalMeshComponent ActorComp, class<Yoshi_MusicalInstrument> CurrentClass, class<Yoshi_MusicalInstrument> NewClass, SkeletalMeshComponent MeshComp, bool IsEquipped) {

    if(NewClass == CurrentClass) {
        if(IsEquipped) return true; //Already equipped and is the correct class

        if(MeshComp != None) {
            //We can reattach
            UpdateAnimSet(ActorComp, CurrentClass.default.AnimSet, true);
            ReAttachInstrument(ActorComp, MeshComp);
            return true;
        }
    }
    else {
        //Different class, we may need to remove
        if(IsPlayerEquipped && MeshComp != None) {
            DetachInstrument(ActorComp, MeshComp);
            UpdateAnimSet(ActorComp, CurrentClass.default.AnimSet, false);
        }
    }

    return false;
}

static function PlayStrumAnim(SkeletalMeshComponent Comp, optional bool FixAnim = false) {
	local AnimNodeBlendBase anim;

	if (Comp == None) return;

	anim = AnimNodeBlend(Comp.FindAnimNode('TicketScan'));
    if(anim == None) return;

	AnimNodeBlend(anim).SetBlendTarget(1, 0.3f); 

    //FixAnim uses a play rate of 1000.0 to do a "fake strum" to make sure OP players aren't holding the ukulele like a weapon
    //The standard play rate is 2.0 as it was a bit too slow originally
    anim.Children[1].Anim.PlayAnim(false, FixAnim ? 1000.0 : 2.0, 0.0);
}

function StopStrumAnim(SkeletalMeshComponent Comp) {
	local AnimNodeBlendBase anim;
	if (Comp == None) return;

    anim = AnimNodeBlend(Comp.FindAnimNode('TicketScan'));
    if(anim == None) return;

	AnimNodeBlend(anim).SetBlendTarget(0, 0.0f);
}

static function SkeletalMeshComponent AttachInstrument(SkeletalMeshComponent Comp, SkeletalMesh Instrument) {
    local SkeletalMeshComponent InstrumentMeshComp;

    InstrumentMeshComp = new class'SkeletalMeshComponent';
    InstrumentMeshComp.SetSkeletalMesh(Instrument);
    InstrumentMeshComp.SetLightEnvironment(Comp.LightEnvironment);
    Comp.AttachComponentToSocket(InstrumentMeshComp, 'Umbrella');

    return InstrumentMeshComp;
}

static function ReAttachInstrument(SkeletalMeshComponent Comp, SkeletalMeshComponent InstrumentMeshComp) {
    Comp.AttachComponentToSocket(InstrumentMeshComp, 'Umbrella');
}

static function DetachInstrument(SkeletalMeshComponent Comp, SkeletalMeshComponent InstrumentMeshComp) {
    Comp.DetachComponent(InstrumentMeshComp);
}

static function UpdateAnimSet(SkeletalMeshComponent Comp, AnimSet CurrAnimSet, bool bGive)
{
	if (bGive) {
		if (Comp.AnimSets.Find(CurrAnimSet) == INDEX_NONE) {
			Comp.AnimSets.AddItem(CurrAnimSet);
		}
	}
	else {
		if (Comp.AnimSets.Find(CurrAnimSet) != INDEX_NONE) {
			Comp.AnimSets.RemoveItem(CurrAnimSet);
		}
	}

	Comp.UpdateAnimations();
}