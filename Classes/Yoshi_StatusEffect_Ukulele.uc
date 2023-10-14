class Yoshi_StatusEffect_Ukulele extends Hat_StatusEffect;

var AnimSet instrumentAnimSet;
var SkeletalMesh instrumentMesh;
var SkeletalMeshComponent Instrument;

defaultproperties
{
	Duration = 0 // Infinite
	RemoveOnReapply = false
	
	instrumentAnimSet = AnimSet'Ctm_Ukulele.Ukulele_playing'
	instrumentMesh = SkeletalMesh'Ctm_Ukulele.Ukulele'
}

// StatusEffect Functions
function OnAdded(Actor a)
{
	Super.OnAdded(a);
	GiveAnimSet(instrumentAnimSet, true);
	GiveInstrumentMesh(true);
}

simulated function OnRemoved(Actor a)
{
	PlayStrumAnim(false);
	GiveAnimSet(instrumentAnimSet, false);
	GiveInstrumentMesh(false);
	Super.OnRemoved(a);
}

function bool OnAttack()
{
	SetDuration(0.001);
	return false;
}

function bool Update(float delta) {
	local Hat_AnimNodeRandomIdle Anim;
	foreach Hat_Player(Owner).Mesh.AllAnimNodes(class'Hat_AnimNodeRandomIdle', Anim) {
		Anim.CurrentCountdown = Anim.TimeUntilIdle;
	}
	return Super.Update(delta);
}

// Instrument Functions

// Repurposed Hat_MetroTicketGate->PlayScanAnim()
function PlayStrumAnim(optional bool play = true)
{
	local AnimNodeBlendBase anim;
	if (Hat_Player(Owner) == None) return;
	
	if (play) Hat_Player(Owner).PutAwayWeapon();
	// Maybe add some other checks to prevent animation overlap (e.g. brewing hat, idle animations)

	anim = AnimNodeBlend(Hat_Player(Owner).Mesh.FindAnimNode('TicketScan'));
	if (anim != None)
	{
		AnimNodeBlend(anim).SetBlendTarget(play ? 1 : 0, play ? 0.3f : 0.0f); // Need blend time of 0 when removing, otherwise the real TicketScan anim is visible for a few frames. Sharp blend looks kinda bad though.
		if (play) anim.Children[1].Anim.PlayAnim(false, 2.0, 0.0); // Using a rate of 2.0 because original animation is slightly too slow.
		// if (play) anim.Children[1].Anim.ReplayAnim();
	}
}

function GiveAnimSet(AnimSet inAnimSet, bool give)
{
	if (give)
	{
		if (Hat_Player(Owner).Mesh.AnimSets.Find(inAnimSet) == INDEX_NONE)
		{
			Hat_Player(Owner).Mesh.AnimSets.AddItem(inAnimSet);
		}
	}
	else
	{
		if (Hat_Player(Owner).Mesh.AnimSets.Find(inAnimSet) != INDEX_NONE)
		{
			Hat_Player(Owner).Mesh.AnimSets.RemoveItem(inAnimSet);
		}
	}
	Hat_Player(Owner).Mesh.UpdateAnimations();
}

/*
function Vector SetUkeLot(Vector Offset) {
    local Vector NewLocation;
    NewLocation = Instrument.Translation + Offset;
    Instrument.SetTranslation(NewLocation);
    return NewLocation;
}

function Rotator SetUkeRot(Rotator Offset) {
	local Rotator NewRotation;
	NewRotation = Instrument.Rotation + Offset;
	if(Abs(NewRotation.Pitch) == 65536) NewRotation.Pitch = 0;
	if(Abs(NewRotation.Yaw) == 65536) NewRotation.Yaw = 0;
	if(Abs(NewRotation.Roll) == 65536) NewRotation.Roll = 0;
	Instrument.SetRotation(NewRotation);
	return NewRotation;
}*/

// todo
function GiveInstrumentMesh(bool give) { 
	local Yoshi_UkuleleInstrument_GameMod GM;
	if (Hat_Player(Owner) == None || instrumentMesh == None) return;

	if(Instrument == None) {
		Instrument = new class'SkeletalMeshComponent';
		Instrument.SetSkeletalMesh(instrumentMesh);
	}

	GM = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

	if(give) {
		if(Instrument != None) {

			GM.SendOnlinePartyCommand("THISISEPIC", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddUkulele);
			Instrument.SetLightEnvironment(Hat_Player(Owner).Mesh.LightEnvironment);
			Hat_Player(Owner).Mesh.AttachComponentToSocket(Instrument, 'Umbrella');
		}
	}
	else {
		if(Instrument.bAttached && Instrument.Owner == Owner) {
			GM.SendOnlinePartyCommand("THISISALSOEPIC", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiRemoveUkulele);
			Hat_Player(Owner).Mesh.DetachComponent(Instrument);
		}
	}
}