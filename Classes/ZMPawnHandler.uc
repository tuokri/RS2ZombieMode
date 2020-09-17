class ZMPawnHandler extends ROPawnHandler;

static function SkeletalMesh GetFPArmsMesh(int Team, int ArmyIndex, byte bPilot,
    byte TunicMeshID, byte TunicMaterialID, byte SkinToneID, out MaterialInstanceConstant SkinMIC,
    out MaterialInstanceConstant SleeveMIC)
{
    local array<TunicInfo> Tunics;

    Tunics = GetTunicArray(Team, ArmyIndex, bPilot);

    if (Team == `AXIS_TEAM_INDEX)
    {
        // SkinToneID + length of original skin tone MIC array.
        SkinToneID = byte(SkinToneID + 3);
    }

    // Set the skintone first.
    SkinMIC = default.FPSkinToneMICs[SkinToneID];
    SleeveMIC = Tunics[TunicMeshID].BodyMICS[TunicMaterialID].SleeveMICFP;
    return Tunics[TunicMeshID].ArmsMeshFP;
}

DefaultProperties
{
    VietnameseHeads(0)=(HeadMesh=SkeletalMesh'CHR_VN_VN_Heads.Mesh.VN_Head1_Mesh',HeadMICTemplates=(MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_01_Long_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_01_Tied_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_01_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_01_Tied_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_01_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_01_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_01_Torn_INST'),SkinToneID=2,HairColours=49,ThumbnailImage=Texture2D'VN_UI_Textures_Character.Heads.Head_Viet_01')
    VietnameseHeads(1)=(HeadMesh=SkeletalMesh'CHR_VN_VN_Heads.Mesh.VN_Head2_Mesh',HeadMICTemplates=(MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_02_Long_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_02_Tied_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_02_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_02_Tied_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_02_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_02_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_02_Torn_INST'),SkinToneID=2,HairColours=49,ThumbnailImage=Texture2D'VN_UI_Textures_Character.Heads.Head_Viet_02')
    VietnameseHeads(2)=(HeadMesh=SkeletalMesh'CHR_VN_VN_Heads.Mesh.VN_Head3_Mesh',HeadMICTemplates=(MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Long_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Tied_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Tied_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Torn_INST'),SkinToneID=2,HairColours=49,ThumbnailImage=Texture2D'VN_UI_Textures_Character.Heads.Head_Viet_03')
    VietnameseHeads(3)=(HeadMesh=SkeletalMesh'CHR_VN_VN_Heads.Mesh.VN_Head4_Mesh',HeadMICTemplates=(MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Long_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Tied_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Tied_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Torn_INST'),SkinToneID=2,HairColours=49,ThumbnailImage=Texture2D'VN_UI_Textures_Character.Heads.Head_Viet_04')
    VietnameseHeads(4)=(HeadMesh=SkeletalMesh'CHR_VN_VN_Heads.Mesh.VN_Head5_Mesh',HeadMICTemplates=(MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Long_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Tied_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Tied_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Torn_INST'),SkinToneID=2,HairColours=49,ThumbnailImage=Texture2D'VN_UI_Textures_Character.Heads.Head_Viet_05')
    VietnameseHeads(5)=(HeadMesh=SkeletalMesh'CHR_VN_VN_Heads.Mesh.VN_Head3_Mesh',HeadMICTemplates=(MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Long_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Tied_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Tied_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_03_Torn_Pants_INST'),SkinToneID=2,HairColours=49,ThumbnailImage=Texture2D'VN_UI_Textures_Character.Heads.Head_Viet_06')
    VietnameseHeads(6)=(HeadMesh=SkeletalMesh'CHR_VN_VN_Heads.Mesh.VN_Head4_Mesh',HeadMICTemplates=(MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Long_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Tied_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Tied_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_04_Torn_Pants_INST'),SkinToneID=2,HairColours=49,ThumbnailImage=Texture2D'VN_UI_Textures_Character.Heads.Head_Viet_07')
    VietnameseHeads(7)=(HeadMesh=SkeletalMesh'CHR_VN_VN_Heads.Mesh.VN_Head5_Mesh',HeadMICTemplates=(MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Long_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Tied_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Torn_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Tied_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Torn_Pants_INST',MaterialInstanceConstant'ZM_CHR_VN_VN_Heads_Z.Materials.M_VN_Head_05_Torn_Pants_INST'),SkinToneID=2,HairColours=49,ThumbnailImage=Texture2D'VN_UI_Textures_Character.Heads.Head_Viet_08')

    FPSkinToneMICs(3)=MaterialInstanceConstant'ZM_CHR_VN_1stP_Hands_Master.Materials.M_VN_1stP_Bare_Z_Green_INST'
	FPSkinToneMICs(4)=MaterialInstanceConstant'ZM_CHR_VN_1stP_Hands_Master.Materials.M_VN_1stP_Bare_Tone2_Z_Green_INST'
	FPSkinToneMICs(5)=MaterialInstanceConstant'ZM_CHR_VN_1stP_Hands_Master.Materials.M_VN_1stP_Bare_Tone3_Z_Green_INST'
}
