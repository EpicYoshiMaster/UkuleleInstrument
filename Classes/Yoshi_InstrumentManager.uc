class Yoshi_InstrumentManager extends Yoshi_InstrumentManager_Base;

var float ParticleRotationTime;
var float ParticleRadius;
var float ParticleHeightOffset;

var SkeletalMesh InstrumentSkeletalMesh;
var AnimSet InstrumentAnimSet;
var MaterialInterface InstrumentParticleMat;
var ParticleSystem InstrumentParticleSystem;

var Yoshi_UkuleleInstrument_GameMod GameMod;

var SkeletalMeshComponent InstrumentTemplate;

struct InstrumentSet {
    var Actor Player;
    var SkeletalMeshComponent MeshComp;
    var class<Yoshi_MusicalInstrument> Instrument;
    var SkeletalMeshComponent InstrMeshComp;
    var ParticleSystemComponent Particle;
    var float OffsetTime;
    var class<Hat_Collectible_Skin> Skin;
};

var array<InstrumentSet> Instruments;

var bool PlayerEquipped;

struct MaterialCount {
    var int Count;
    var MaterialInterface Mat;
};

function Init(Yoshi_UkuleleInstrument_GameMod MyGameMod) {
    GameMod = MyGameMod;
}

//Returns true if instrument was added
function bool AddInstrument(Actor Player, SkeletalMeshComponent MeshComp, class<Yoshi_MusicalInstrument> Instrument, class<Hat_Collectible_Skin> Skin, optional bool ForceAnim = false) {    
    local InstrumentSet NewInstrument;

    if(Instruments.Find('Player', Player) != INDEX_NONE) return false;
    
    UpdateAnimSet(MeshComp, InstrumentAnimSet, true);

    NewInstrument.Player = Player;
    NewInstrument.MeshComp = MeshComp;
    NewInstrument.Instrument = Instrument;
    NewInstrument.InstrMeshComp = AttachInstrument(MeshComp, InstrumentSkeletalMesh);
    NewInstrument.Particle = AttachParticle(MeshComp, Instrument);
    NewInstrument.OffsetTime = RandRange(0, ParticleRotationTime);
    NewInstrument.Skin = Skin;

    if(ForceAnim) PlayStrumAnim(MeshComp, true);

    Instruments.AddItem(NewInstrument);

    if(Hat_Player(Player) != None) {
        GameMod.Sync(Instrument.default.ShortName $ "|false", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument);
        PlayerEquipped = true;
    }   

    UpdateInstrumentColors(Player, NewInstrument.InstrMeshComp, Skin, Instrument);

    return true;
}

function RemoveInstrument(Actor Player, SkeletalMeshComponent MeshComp) {
    local int i;

    i = Instruments.Find('Player', Player);

    if(i == INDEX_NONE) return;

    StopStrumAnim(Instruments[i].MeshComp);

    if(Instruments[i].Particle != None) {
        Instruments[i].Particle.DetachFromAny();
    }

    DetachInstrument(Instruments[i].MeshComp, Instruments[i].InstrMeshComp);
    UpdateAnimSet(Instruments[i].MeshComp, InstrumentAnimSet, false);

    Instruments.Remove(i, 1);

    if(Hat_Player(Player) != None) {
        GameMod.Sync("Hello there :D", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiRemoveInstrument);
        PlayerEquipped = false;
    }
}

function UpdateInstrument(Actor Player, SkeletalMeshComponent MeshComp, class<Yoshi_MusicalInstrument> Instrument, class<Hat_Collectible_Skin> Skin) {
    local int i;

    if(AddInstrument(Player, MeshComp, Instrument, Skin, false)) return;

    i = Instruments.Find('Player', Player);

    if(i == INDEX_NONE) return; //This shouldn't happen :<

    if(Instrument != Instruments[i].Instrument) {
        Instruments[i].Instrument = Instrument;
        UpdateParticle(Instruments[i].Particle, Instrument);
    }
    
    if(Skin != None && Skin != Instruments[i].Skin) {
        Instruments[i].Skin = Skin;
        UpdateInstrumentColors(Player, Instruments[i].InstrMeshComp, Skin, Instrument);
    }
}

function Tick(float delta) {
    local Hat_AnimNodeRandomIdle Anim;
    local WorldInfo wi;
    local int i;
    local float Angle;
    local Vector v;

    wi = class'WorldInfo'.static.GetWorldInfo();

    for(i = 0; i < Instruments.Length; i++) {
        if(Instruments[i].Player == None) {
            Instruments.Remove(i, 1);
            i--;
            continue;
        }

        if(Hat_Player(Instruments[i].Player) != None) {
            foreach Instruments[i].MeshComp.AllAnimNodes(class'Hat_AnimNodeRandomIdle', Anim) {
		        Anim.CurrentCountdown = Anim.TimeUntilIdle;
	        }
        }

        if(Instruments[i].Particle != None) {
            Angle = (Instruments[i].OffsetTime + wi.TimeSeconds) / ParticleRotationTime;
            
            v.X = Sin(Angle) * ParticleRadius;
            v.Y = Cos(Angle) * ParticleRadius;
            v.Z = ParticleHeightOffset;

            Instruments[i].Particle.SetTranslation(v);
        }
    }
}

function UpdateInstrumentColors(Actor a, SkeletalMeshComponent InstrumentMeshComp, class<Hat_Collectible_Skin> Skin, class<Yoshi_MusicalInstrument> InstrumentClass) {
    local array<Texture2D> TextureSlots;
    local MaterialInterface FullBodyMaterial;
    local LinearColor LinearSkinColor;
	local Color SkinColor;
    local SkinColors iSkinColor;
    local Texture2D Tex;
    local Name ParameterName;
    local int i;

    GameMod.Print("UpdateInstrumentColors" @ InstrumentMeshComp.Name $ "," @ Skin);

    if(InstrumentMeshComp == None) return;
    if(Skin == None) return;

    FullBodyMaterial = GetFullBodyMaterial(a, Skin);

    SetFullbodyMaterial(InstrumentMeshComp, InstrumentClass, FullBodyMaterial);

    Skin.static.GetTextureSlotList(TextureSlots);
    SetTextureSlots(InstrumentMeshComp, Skin, TextureSlots);

    for(i = 0; i < class'Hat_Collectible_Skin'.const.SkinColorNum; i++) {
        iSkinColor = SkinColors(i);

        ParameterName = Name(Skin.static.GetSkinColorName(iSkinColor));

        SkinColor = Skin.default.SkinColor[iSkinColor];
        Tex = Skin.default.SkinTextureInfo[iSkinColor].Texture;

        if(Skin.static.IsSlotEmpty(SkinColor, Tex)) {
            ClearMaterialVectorValueMesh(InstrumentMeshComp, ParameterName);
        }
        else {
            if(Tex != None) {
                LinearSkinColor.R = Skin.default.SkinTextureInfo[iSkinColor].UVScale * (Skin.default.SkinTextureInfo[iSkinColor].DisableNormalMap ? -1 : 1);
				LinearSkinColor.G = Skin.default.SkinTextureInfo[iSkinColor].Angle;
				LinearSkinColor.B = 0;
				LinearSkinColor.A = TextureSlots.Find(Tex);
            }
            else {
                LinearSkinColor.R = (float(SkinColor.R)/255.f) ** 2;
				LinearSkinColor.G = (float(SkinColor.G)/255.f) ** 2;
				LinearSkinColor.B = (float(SkinColor.B)/255.f) ** 2;
				LinearSkinColor.A = -1;
            }

            SetMaterialVectorValueMesh(InstrumentMeshComp, ParameterName, LinearSkinColor);
        }

        GameMod.Print("[" $ i $ "]" @ ParameterName $ ", (R=" $ SkinColor.R $ ", G=" $ SkinColor.G $ ", B=" $ SkinColor.B $ ", A=" $ SkinColor.A $ ")," @ Tex.Name $ "," @ LinearSkinColor.R);
    }

    if(Hat_Player(a) != None) {
        GameMod.Sync("ColorsWeaveIntoASpiralOfFlame", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiUpdatePlayerInstrumentColors);
    }   
}

static function InitMaterialInstancesMesh(Meshcomponent MeshComp) {
	local int i;
	local MaterialInstance Mat;

	if (MeshComp == None) return;

	for (i = 0; i < MeshComp.GetNumElements(); i++)
	{
		if (MaterialInstanceTimeVarying(MeshComp.GetMaterial(i)) != None || Material(MeshComp.GetMaterial(i)) != None)
			Mat = MeshComp.CreateAndSetMaterialInstanceTimeVarying(i);

		else if (MaterialInstanceConstant(MeshComp.GetMaterial(i)) != None)
			Mat = MeshComp.CreateAndSetMaterialInstanceConstant(i);

		else
			continue;

		MeshComp.SetMaterial(i, Mat);
	}
}

static function SetFullbodyMaterial(SkeletalMeshComponent InstrumentComp, class<Yoshi_MusicalInstrument> InstrumentClass, optional MaterialInterface Mat) {
    local int i;

    //Apply
    if(Mat != None) {
        for(i = 0; i < InstrumentComp.GetNumElements(); i++) {
            if(InstrumentComp.GetMaterial(i) == Material'HatInTime_Characters.Materials.Invisible') continue;

            InstrumentComp.SetMaterial(i, Mat);

            InitMaterialInstancesMesh(InstrumentComp);
        }
    }
    //Remove
    else {
        InitMaterialInstancesMesh(InstrumentComp);

        for(i = 0; i < InstrumentComp.GetNumElements(); i++) {
            InstrumentComp.SetMaterial(i, default.InstrumentTemplate.GetMaterial(i));
        }

        InitMaterialInstancesMesh(InstrumentComp);
    }
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

    InstrumentMeshComp = new class'SkeletalMeshComponent'(default.InstrumentTemplate);
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
            Comp.UpdateAnimations();
		}
	}
	else {
		if (Comp.AnimSets.Find(CurrAnimSet) != INDEX_NONE) {
			Comp.AnimSets.RemoveItem(CurrAnimSet);
            Comp.UpdateAnimations();
		}
	}
}

function ParticleSystemComponent AttachParticle(SkeletalMeshComponent InstrumentMeshComp, class<Yoshi_MusicalInstrument> InstrumentClass) {
    local MaterialInstanceConstant MatInst;
    local ParticleSystemComponent NewParticle;

    MatInst = new class'MaterialInstanceConstant';
    MatInst.SetParent(InstrumentParticleMat);
    MatInst.SetTextureParameterValue('Texture', InstrumentClass.default.Icon);

    NewParticle = new class'ParticleSystemComponent';
    NewParticle.SetTemplate(InstrumentParticleSystem);
    NewParticle.SetMaterialParameter('Override', MatInst);
    NewParticle.SetScale(0.3);

    InstrumentMeshComp.AttachComponent(NewParticle, 'Root', vect(0,0,0));

    return NewParticle;
}

function UpdateParticle(ParticleSystemComponent Particle, class<Yoshi_MusicalInstrument> InstrumentClass) {
    local MaterialInstanceConstant MatInst;

    MatInst = new class'MaterialInstanceConstant';
    MatInst.SetParent(InstrumentParticleMat);
    MatInst.SetTextureParameterValue('Texture', InstrumentClass.default.Icon);

    Particle.SetMaterialParameter('Override', MatInst);
}

// Function to approximate determining the fullbody material of a given skin, if present
// - The material must be used more than 3 times
// - The material cannot be the Invisible material or Badge Metal Back material
// - The material cannot be a default material for the player's meshes, ex. HatKidBody
// - If more than one material is used more than 3 times, the material is the highest counted one
function MaterialInterface GetFullbodyMaterial(Actor a, class<Hat_Collectible_Skin> SkinClass) {
    local int i, j, MatCountIndex, HighestCount, HighestIndex;
    local MaterialCount NewCount;
    local array<MaterialCount> MatCounts;
    local array<MeshComponent> AllMeshComponents;
    local array<MaterialInterface> DefaultMaterials;
    local MaterialInterface CurrMat;
    
    if(a == None || SkinClass == None || SkinClass == class'Hat_Collectible_Skin') return None;
    
    if(Hat_Player(a) != None) {
        AllMeshComponents = Hat_Player(a).GetMyMaterialMeshComponents();

        //Remove head mesh, gets false positives for bow kid
        AllMeshComponents.RemoveItem(Hat_Player(a).Mesh);
    }
    else if(Hat_GhostPartyPlayer(a) != None) {
        AllMeshComponents = Hat_GhostPartyPlayer(a).GetMyMaterialMeshComponents();
    }

    if(AllMeshComponents.Length <= 0) return None;

    //Gather default materials
    DefaultMaterials = GetDefaultMaterials(AllMeshComponents);

    DefaultMaterials.AddItem(Material'HatInTime_Characters.Materials.Invisible'); //You shall not count on this day
    DefaultMaterials.AddItem(Material'HatInTime_Items.Materials.Badges.badge_Metal_Back'); //You also shall not count on this day

    for(i = 0; i < AllMeshComponents.Length; i++) {
        for(j = 0; j < AllMeshComponents[i].GetNumElements(); j++) {

            CurrMat = GetActualMaterial(AllMeshComponents[i].GetMaterial(j));

            if(DefaultMaterials.Find(CurrMat) != INDEX_NONE) continue;

            MatCountIndex = MatCounts.Find('Mat', CurrMat);

            if(MatCountIndex != INDEX_NONE) {
                MatCounts[MatCountIndex].Count += 1;
            }
            else {
                NewCount.Count = 1;
                NewCount.Mat = GetActualMaterial(AllMeshComponents[i].GetMaterial(j));

                MatCounts.AddItem(NewCount);
            }
        }
    }

    HighestCount = 0;
    HighestIndex = -1;

    //GameMod.Print("Material Count");

    for(i = 0; i < MatCounts.Length; i++) {
        //GameMod.Print("[" $ i $ "]" @ MatCounts[i].Count $ "," @ MatCounts[i].Mat);

        if(MatCounts[i].Count > HighestCount) {
            HighestCount = MatCounts[i].Count;
            HighestIndex = i;
        }
    }

    if(HighestIndex == INDEX_NONE || HighestCount <= 3) return None;

    return MatCounts[HighestIndex].Mat;
}

defaultproperties
{
    Begin Object Class=SkeletalMeshComponent Name=InstrTemplate
        bUsePrecomputedShadows=false
        SkeletalMesh=SkeletalMesh'Ctm_Ukulele.Ukulele'
    End Object 
    InstrumentTemplate=InstrTemplate

    InstrumentAnimSet=AnimSet'Ctm_Ukulele.Ukulele_playing'
	InstrumentSkeletalMesh=SkeletalMesh'Ctm_Ukulele.Ukulele'
    InstrumentParticleMat=Material'Yoshi_UkuleleMats_Content.Materials.Instrument_Orb_Mat'

    InstrumentParticleSystem=ParticleSystem'Yoshi_UkuleleMats_Content.ParticleSystems.Instrument_Icon_PS_Copy'
    //InstrumentParticleSystem=ParticleSystem'HatInTime_HUB_Decorations.Particles.DreamBubble'

    ParticleRotationTime=3.0
    ParticleRadius=75.0
    ParticleHeightOffset=10.0
}