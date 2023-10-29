class Yoshi_InstrumentManager extends Yoshi_InstrumentManager_Base;

var Hat_Player Player;
var Yoshi_UkuleleInstrument_GameMod GameMod;
var class<Yoshi_MusicalInstrument> EquippedClass;
var SkeletalMeshComponent InstrumentMesh;
var bool IsPlayerEquipped;

var SkeletalMeshComponent InstrumentTemplate;

struct OPInstrument {
    var Hat_GhostPartyPlayer GPP;
    var class<Yoshi_MusicalInstrument> EquippedClass;
    var SkeletalMeshComponent InstrumentMesh;
    var bool IsEquipped;
};

var array<OPInstrument> OPInstruments;

struct MaterialCount {
    var int Count;
    var MaterialInterface Mat;
};

function AddPlayerInstrument(Hat_Player Ply, class<Yoshi_MusicalInstrument> InstrumentClass) {
    local bool WasPlayerEquipped;

    if(Ply == None) return;
    if(GameMod == None) GameMod = class'Yoshi_UkuleleInstrument_GameMod'.static.GetGameMod();

    Player = Ply;

    WasPlayerEquipped = IsPlayerEquipped;

    IsPlayerEquipped = CheckInstrumentStatus(Ply.Mesh, EquippedClass, InstrumentClass, instrumentMesh, IsPlayerEquipped);

    if(!WasPlayerEquipped && IsPlayerEquipped) {
        GameMod.Sync(InstrumentClass.default.InstrumentName $ "|false", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument);
        UpdateInstrumentColors(ply, InstrumentMesh, class<Hat_Collectible_Skin>(Hat_PlayerController(Player.Controller).GetLoadout().MyLoadout.Skin.BackpackClass), InstrumentClass);
    }

    if(IsPlayerEquipped) return;

    //If we get this far, we are ready to add a new instrument
    UpdateAnimSet(Player.Mesh, InstrumentClass.default.AnimSet, true);
    EquippedClass = InstrumentClass;
    IsPlayerEquipped = true;
    InstrumentMesh = AttachInstrument(Player.Mesh, InstrumentClass.default.Mesh);
    GameMod.Sync(InstrumentClass.default.InstrumentName $ "|false", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiAddInstrument);

    UpdateInstrumentColors(ply, InstrumentMesh, class<Hat_Collectible_Skin>(Hat_PlayerController(Player.Controller).GetLoadout().MyLoadout.Skin.BackpackClass), InstrumentClass);
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
                UpdateInstrumentColors(GPP, OPInstruments[i].InstrumentMesh, GPP.CurrentSkin, InstrumentClass);
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

    UpdateInstrumentColors(GPP, NewUser.InstrumentMesh, GPP.CurrentSkin, InstrumentClass);

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

function UpdateInstrumentColors(Actor a, SkeletalMeshComponent MeshComp, class<Hat_Collectible_Skin> Skin, class<Yoshi_MusicalInstrument> InstrumentClass) {
    local array<Texture2D> TextureSlots;
    local MaterialInterface FullBodyMaterial;
    local LinearColor LinearSkinColor;
	local Color SkinColor;
    local SkinColors iSkinColor;
    local Texture2D Tex;
    local Name ParameterName;
    local int i;

    GameMod.Print("UpdateInstrumentColors" @ MeshComp.Name $ "," @ Skin);

    if(MeshComp == None) return;
    if(Skin == None) return;

    FullBodyMaterial = GetFullBodyMaterial(a, Skin);

    SetFullbodyMaterial(MeshComp, InstrumentClass, FullBodyMaterial);

    Skin.static.GetTextureSlotList(TextureSlots);
    SetTextureSlots(MeshComp, Skin, TextureSlots);

    for(i = 0; i < class'Hat_Collectible_Skin'.const.SkinColorNum; i++) {
        iSkinColor = SkinColors(i);

        ParameterName = Name(Skin.static.GetSkinColorName(iSkinColor));

        SkinColor = Skin.default.SkinColor[iSkinColor];
        Tex = Skin.default.SkinTextureInfo[iSkinColor].Texture;

        if(Skin.static.IsSlotEmpty(SkinColor, Tex)) {
            ClearMaterialVectorValueMesh(InstrumentMesh, ParameterName);
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

            SetMaterialVectorValueMesh(MeshComp, ParameterName, LinearSkinColor);
        }

        GameMod.Print("[" $ i $ "]" @ ParameterName $ ", (R=" $ SkinColor.R $ ", G=" $ SkinColor.G $ ", B=" $ SkinColor.B $ ", A=" $ SkinColor.A $ ")," @ Tex.Name $ "," @ LinearSkinColor.R);
    }

    GameMod.Sync("ColorsWeaveIntoASpiralOfFlame", class'YoshiPrivate_MusicalInstruments_Commands'.const.YoshiUpdatePlayerInstrumentColors);
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
		}
	}
	else {
		if (Comp.AnimSets.Find(CurrAnimSet) != INDEX_NONE) {
			Comp.AnimSets.RemoveItem(CurrAnimSet);
		}
	}

	Comp.UpdateAnimations();
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
}