class Yoshi_InstrumentManager_Base extends Object
    abstract;

function SetTextureSlots(MeshComponent MeshComp, class<Hat_Collectible_Skin> Skin, Array<Texture2D> TextureSlots)
{
	local Name ParameterName;
	local int i;
	for (i = 0; i < Min(TextureSlots.Length, class'Hat_MaterialExpressionDynamicLUT'.const.SupportedTextureSlots); i++)
	{
		ParameterName = Name(Skin.static.GetTextureSlotName(i));
		SetMaterialTextureValueMesh(MeshComp, ParameterName, TextureSlots[i]);
	}
}

function SetMaterialTextureValueMesh(MeshComponent MeshComp, Name ParameterName, Texture Tex)
{
    local int i;
    local MaterialInstance Mat;

	if (Tex == None) {
		ClearMaterialTextureValueMesh(MeshComp, ParameterName);
		return;
	}

    for (i = 0; i < MeshComp.GetNumElements(); i++)
    {
        Mat = MaterialInstance(MeshComp.GetMaterial(i));
        if (Mat != None) Mat.SetTextureParameterValue(ParameterName, Tex);
    }
}

function ClearMaterialTextureValueMesh(MeshComponent MeshComp, Name ParameterName)
{
    local int i;
    local MaterialInstance Mat;

  	if (MeshComp == None) return;

    for (i = 0; i < MeshComp.GetNumElements(); i++)
    {
        Mat = MaterialInstance(MeshComp.GetMaterial(i));
        if (Mat != None)
        {
            Mat.ClearTextureParameterValue(ParameterName);
        }
    }
}

function ClearMaterialVectorValueMesh(MeshComponent MeshComp, Name ParameterName)
{
    local int i;
    local MaterialInstance Mat;

  	if (MeshComp == None) return;

    for (i = 0; i < MeshComp.GetNumElements(); i++)
    {
        Mat = MaterialInstance(MeshComp.GetMaterial(i));
        if (Mat != None)
        {
            Mat.ClearVectorParameterValue(ParameterName);
        }
    }
}

function SetMaterialVectorValueMesh(MeshComponent MeshComp, Name ParameterName, LinearColor LinearColorValue)
{
    local int i;
    local MaterialInstance Mat;

	if (MeshComp == None) return;

    for (i = 0; i < MeshComp.GetNumElements(); i++)
    {
        Mat = MaterialInstance(MeshComp.GetMaterial(i));
        if (Mat == None) continue;

		Mat.SetVectorParameterValue(ParameterName, LinearColorValue);
    }
}

function SetMaterialScalarValueMesh(MeshComponent MeshComp, Name ParameterName, float ScalarValue)
{
    local int i;
    local MaterialInstance Mat;

	if (MeshComp == None) return;

    for (i = 0; i < MeshComp.GetNumElements(); i++)
    {
        Mat = MaterialInstance(MeshComp.GetMaterial(i));
        if (Mat == None) continue;

		Mat.SetScalarParameterValue(ParameterName, ScalarValue);
    }
}

//Credit to Shararamosh for this function
function MaterialInterface GetActualMaterial(MaterialInterface mat) {
    local MaterialInstance inst;
    inst = MaterialInstance(mat);
    if (inst == None)
        return mat;
    if (inst.IsInMapOrTransientPackage())
        return GetActualMaterial(inst.Parent);
    return inst;
}

// Finds all of the default materials for a set of mesh components
function array<MaterialInterface> GetDefaultMaterials(array<MeshComponent> AllMeshComponents) {
    local int i, j;
    local MaterialInterface CurrMat;
    local SkeletalMeshComponent SkelComp;
    local array<MaterialInterface> DefaultMaterials;

    for(i = 0; i < AllMeshComponents.Length; i++) {

        SkelComp = SkeletalMeshComponent(AllMeshComponents[i]);

        if(SkelComp == None) continue;

        for(j = 0; j < SkelComp.default.SkeletalMesh.Materials.Length; j++) {
            CurrMat = GetActualMaterial(SkelComp.default.SkeletalMesh.Materials[j]);

            if(CurrMat != None && DefaultMaterials.Find(CurrMat) == INDEX_NONE) {
                DefaultMaterials.AddItem(CurrMat);
                //GameMod.Print("Default Material:" @ CurrMat);
            }
        }
    }
    
    return DefaultMaterials;
}