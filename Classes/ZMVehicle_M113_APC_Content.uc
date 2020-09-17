class ZMVehicle_M113_APC_Content extends ZMVehicle_M113_APC
	placeable;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

    PeriscopeLenseMIC2 = new class'MaterialInstanceConstant';
	PeriscopeLenseMIC2.SetParent(PeriscopeLenseMICTemplate2);
	PeriscopeLenseMIC2.SetTextureParameterValue('RenderToTextureMap', PeriscopeTextureTarget2);
	// PeriscopeLenseMIC2.SetScalarParameterValue(InterpParamName, 0.0);
	GetVehicleMeshAttachment('IntBodyComponent').SetMaterial(2 + 3, PeriscopeLenseMIC2);

    PeriscopeTextureTarget2 = class'TextureRenderTarget2D'.static.Create(2048, 2048, PF_A8R8G8B8);
    SceneCapture2.SetCaptureParameters(PeriscopeTextureTarget2);
    PeriscopeLenseMIC2.SetTextureParameterValue('RenderToTextureMap', PeriscopeTextureTarget2);

    Mesh.AttachComponent(SceneCapture2, 'Periscope_02');
    `zmlog("SceneCapture2=" $ SceneCapture2);
}


DefaultProperties
{
	// ------------------------------- Mesh --------------------------------------------------------------

	Begin Object Name=ROSVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_VN_Drivable_M113_APC.Mesh.US_M113_Rig_Master'
		LightingChannels=(Dynamic=TRUE,Unnamed_1=TRUE,bInitialized=TRUE)
		AnimTreeTemplate=AnimTree'VH_VN_ARVN_M113_APC.Anim.AT_VH_M113_APC'
		PhysicsAsset=PhysicsAsset'VH_VN_ARVN_M113_APC.Phys.ARVN_M113_Physics'
		AnimSets.Add(AnimSet'VH_VN_ARVN_M113_APC.Anim.VH_M113_Anim_Master')
		//AnimSets.Add(AnimSet'VH_Sov_UniversalCarrier.Anim.Sov_UC_Destroyed_Anims')
	End Object

	// // -------------------------------- Sounds -----------------------------------------------------------

	// // Engine start sounds
	// Begin Object Class=AudioComponent Name=StartEngineLSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Engine_Start_Cabin_L_Cue'
	// End Object
	// EngineStartLeftSound=StartEngineLSound

	// Begin Object Class=AudioComponent Name=StartEngineRSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Engine_Start_Cabin_R_Cue'
	// End Object
	// EngineStartRightSound=StartEngineRSound

	// Begin Object Class=AudioComponent Name=StartEngineExhaustSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Transport_UC.Movement.UC_Movement_Engine_Start_Exhaust_Cue'
	// End Object
	// EngineStartExhaustSound=StartEngineExhaustSound

	// Begin Object Class=AudioComponent Name=StopEngineSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Transport_UC.Movement.UC_Movement_Engine_Stop_Cue'
	// End Object
	// EngineStopSound=StopEngineSound

	// // Engine idle sounds
	// Begin Object Class=AudioComponent Name=IdleEngineLeftSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Engine_Run_Cabin_L_Cue'
	// 	bShouldRemainActiveIfDropped=TRUE
	// End Object
	// EngineIntLeftSound=IdleEngineLeftSound

	// Begin Object Class=AudioComponent Name=IdleEngineRighSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Engine_Run_Cabin_R_Cue'
	// 	bShouldRemainActiveIfDropped=TRUE
	// End Object
	// EngineIntRightSound=IdleEngineRighSound

	// Begin Object Class=AudioComponent Name=IdleEngineExhaustSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Transport_UC.Movement.UC_Movement_Engine_Run_Exhaust_Cue'
	// 	bShouldRemainActiveIfDropped=TRUE
	// End Object
	// EngineSound=IdleEngineExhaustSound

	// // Track sounds
	// Begin Object Class=AudioComponent Name=TrackLSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Treads_L_Cue'
	// End Object
	// TrackLeftSound=TrackLSound

	// Begin Object Class=AudioComponent Name=TrackRSound
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Treads_R_Cue'
	// End Object
	// TrackRightSound=TrackRSound

	// // Brake sounds
	// Begin Object Class=AudioComponent Name=BrakeLeftSnd
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Treads_Brake_Cue'
	// End Object
	// BrakeLeftSound=BrakeLeftSnd

	// Begin Object Class=AudioComponent Name=BrakeRightSnd
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Treads_Brake_Cue'
	// End Object
	// BrakeRightSound=BrakeRightSnd

	// // Damage sounds
	// EngineIdleDamagedSound=SoundCue'AUD_Vehicle_Tank_PanzerIV.Movement.Panzer_Movement_Engine_Broken_Cue'
	// TrackTakeDamageSound=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Treads_Brake_Cue'
	// TrackDamagedSound=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Treads_Broken_Cue'
	// TrackDestroyedSound=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Treads_Skid_Cue'

	// // Destroyed tranmission
	// Begin Object Class=AudioComponent Name=BrokenTransmissionSnd
	// 	SoundCue=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Transmission_Broken_Cue'
	// 	bStopWhenOwnerDestroyed=TRUE
	// End Object
	// BrokenTransmissionSound=BrokenTransmissionSnd

	// // Gear shift sounds
	// ShiftUpSound=SoundCue'AUD_Vehicle_Transport_UC.Movement.UC_Movement_Engine_Exhaust_ShiftUp_Cue'
	// ShiftDownSound=SoundCue'AUD_Vehicle_Tank_T34.Movement.T34_Movement_Engine_Exhaust_ShiftDown_Cue'
	// ShiftLeverSound=SoundCue'AUD_Vehicle_Tank_PanzerIV.Foley.Panzer_Lever_GearShift_Cue'


	// ExplosionSound=SoundCue'AUD_EXP_Tanks.A_CUE_Tank_Explode'

	// Begin Object Class=AudioComponent name=HullMGSoundComponent
	// 	bShouldRemainActiveIfDropped=true
	// 	bStopWhenOwnerDestroyed=true
	// 	SoundCue=SoundCue'AUD_Firearms_MG_DP28.Fire_3P.MG_DP28_Tank_Fire_Loop_M_Cue'
	// End Object
	// HullMGAmbient=HullMGSoundComponent
	// Components.Add(HullMGSoundComponent)

	// HullMGStopSound=SoundCue'AUD_Firearms_MG_DP28.Fire_3P.MG_DP28_Tank_Fire_Loop_Tail_M_Cue'

	// // -------------------------------- Dead -----------------------------------------------------------

	DestroyedSkeletalMesh=SkeletalMesh'VH_VN_ARVN_M113_APC.Mesh.ARVN_M113_Destroyed_Master'
	// DestroyedSkeletalMeshWithoutTurret=SkeletalMesh'VH_Sov_UniversalCarrier.Mesh.Sov_UC_Destroyed_Master'
	DestroyedPhysicsAsset=PhysicsAsset'VH_VN_ARVN_M113_APC.Phys.ARVN_M113_Destroyed_Physics'
	DestroyedMaterial=MaterialInstanceConstant'VH_VN_M113.Materials.M_M113_DAM'
	// DestroyedMaterial2=MaterialInstanceConstant'VH_Sov_UniversalCarrier.Materials.M_DT28_3rd'
	// DestroyedMaterial3=MaterialInstanceConstant'VH_Sov_UniversalCarrier.Materials.M_DT28_Ammo_3rd'
	// DestroyedTurretClass=none

	// // HUD
	// HUDBodyTexture=Texture2D'UI_Textures_VehiclePack.HUD.Vehicles.UniC.ui_hud_uc_VehicleBase'
	// HUDTurretTexture=none
	// DriverOverlayTexture=none

	// HUDMainCannonTexture=none
	// HUDGearBoxTexture=Texture2D'UI_Textures_VehiclePack.HUD.Vehicles.UniC.ui_hud_uc_Transmission'
	// HUDFrontArmorTexture=Texture2D'UI_Textures_VehiclePack.HUD.Vehicles.UniC.ui_hud_uc_FrontArmor'
	// HUDBackArmorTexture=Texture2D'UI_Textures_VehiclePack.HUD.Vehicles.UniC.ui_hud_uc_RearArmor'
	// HUDLeftArmorTexture=Texture2D'UI_Textures_VehiclePack.HUD.Vehicles.UniC.ui_hud_uc_LeftArmor'
	// HUDRightArmorTexture=Texture2D'UI_Textures_VehiclePack.HUD.Vehicles.UniC.ui_hud_uc_RightArmor'

	// RoleSelectionImage=Texture2D'UI_Textures_VehiclePack.Textures.Sov_tank_UC'

	// Driver
	SeatProxies(0)={(
		TunicMeshType=SkeletalMesh'CHR_VN_US_Army.Mesh.US_Tunic_Long_Mesh',
		HeadGearMeshType=SkeletalMesh'CHR_VN_US_Headgear.Mesh.US_headgear_var1',
		HeadAndArmsMeshType=SkeletalMesh'CHR_VN_US_Heads.Mesh.US_Head1_Mesh',
		HeadphonesMeshType=none,
		HeadAndArmsMICTemplate=MaterialInstanceConstant'CHR_VN_US_Heads.Materials.M_US_Head_01_Long_INST',
		BodyMICTemplate=MaterialInstanceConstant'CHR_VN_US_Army.Materials.M_US_Tunic_Long_INST',
		SeatIndex=0,
		PositionIndex=1)}

	// Hull MG
	SeatProxies(1)={(
		TunicMeshType=SkeletalMesh'CHR_VN_US_Army.Mesh.US_Tunic_Long_Mesh',
		HeadGearMeshType=SkeletalMesh'CHR_VN_US_Headgear.Mesh.US_headgear_var1',
		HeadAndArmsMeshType=SkeletalMesh'CHR_VN_US_Heads.Mesh.US_Head1_Mesh',
		HeadphonesMeshType=none,
		HeadAndArmsMICTemplate=MaterialInstanceConstant'CHR_VN_US_Heads.Materials.M_US_Head_01_Long_INST',
		BodyMICTemplate=MaterialInstanceConstant'CHR_VN_US_Army.Materials.M_US_Tunic_Long_INST',
		SeatIndex=1,
		PositionIndex=1)}

	//PASS1
	SeatProxies(2)={(
		TunicMeshType=SkeletalMesh'CHR_VN_US_Army.Mesh.US_Tunic_Long_Mesh',
		HeadGearMeshType=SkeletalMesh'CHR_VN_US_Headgear.Mesh.US_headgear_var1',
		HeadAndArmsMeshType=SkeletalMesh'CHR_VN_US_Heads.Mesh.US_Head1_Mesh',
		HeadphonesMeshType=none,
		HeadAndArmsMICTemplate=MaterialInstanceConstant'CHR_VN_US_Heads.Materials.M_US_Head_01_Long_INST',
		BodyMICTemplate=MaterialInstanceConstant'CHR_VN_US_Army.Materials.M_US_Tunic_Long_INST',
		SeatIndex=2,
		PositionIndex=0)}

	//PASS2
	SeatProxies(3)={(
		TunicMeshType=SkeletalMesh'CHR_VN_US_Army.Mesh.US_Tunic_Long_Mesh',
		HeadGearMeshType=SkeletalMesh'CHR_VN_US_Headgear.Mesh.US_headgear_var1',
		HeadAndArmsMeshType=SkeletalMesh'CHR_VN_US_Heads.Mesh.US_Head1_Mesh',
		HeadphonesMeshType=none,
		HeadAndArmsMICTemplate=MaterialInstanceConstant'CHR_VN_US_Heads.Materials.M_US_Head_01_Long_INST',
		BodyMICTemplate=MaterialInstanceConstant'CHR_VN_US_Army.Materials.M_US_Tunic_Long_INST',
		SeatIndex=3,
		PositionIndex=0)}
	//PASS3
	SeatProxies(4)={(
		TunicMeshType=SkeletalMesh'CHR_VN_US_Army.Mesh.US_Tunic_Long_Mesh',
		HeadGearMeshType=SkeletalMesh'CHR_VN_US_Headgear.Mesh.US_headgear_var1',
		HeadAndArmsMeshType=SkeletalMesh'CHR_VN_US_Heads.Mesh.US_Head1_Mesh',
		HeadphonesMeshType=none,
		HeadAndArmsMICTemplate=MaterialInstanceConstant'CHR_VN_US_Heads.Materials.M_US_Head_01_Long_INST',
		BodyMICTemplate=MaterialInstanceConstant'CHR_VN_US_Army.Materials.M_US_Tunic_Long_INST',
		SeatIndex=4,
		PositionIndex=0)}
	//PASS4
	SeatProxies(5)={(
		TunicMeshType=SkeletalMesh'CHR_VN_US_Army.Mesh.US_Tunic_Long_Mesh',
		HeadGearMeshType=SkeletalMesh'CHR_VN_US_Headgear.Mesh.US_headgear_var1',
		HeadAndArmsMeshType=SkeletalMesh'CHR_VN_US_Heads.Mesh.US_Head1_Mesh',
		HeadphonesMeshType=none,
		HeadAndArmsMICTemplate=MaterialInstanceConstant'CHR_VN_US_Heads.Materials.M_US_Head_01_Long_INST',
		BodyMICTemplate=MaterialInstanceConstant'CHR_VN_US_Army.Materials.M_US_Tunic_Long_INST',
		SeatIndex=5,
		PositionIndex=0)}

	// Seat proxy animations
	SeatProxyAnimSet=AnimSet'VH_VN_ARVN_M113_APC.Anim.CHR_M113_Anim_Master'


	//----------------------------------------------------------------
	//                 Tank Attachments
	//
	// Exterior attachments use the exterior light environment,
	// accept light from the dominant directional light only and
	// cast shadows
	//
	// Interior attachments use the interior light environment,
	// accept light from both the dominant directional light and
	// the vehicle interior lights. They do not usually cast shadows.
	// Exceptions are attachments which share a part of the mesh with
	// the exterior.
	//----------------------------------------------------------------

	// -------------- Exterior attachments ------------------//

	Begin Object class=StaticMeshComponent name=ExtBodyAttachment0
		StaticMesh=StaticMesh'VH_VN_Drivable_M113_APC.Mesh.VH_SM_M113_Body_Ext_02'
		LightingChannels=(Dynamic=TRUE,Unnamed_1=FALSE,bInitialized=TRUE)
		LightEnvironment = MyLightEnvironment
		CastShadow=true
		DepthPriorityGroup=SDPG_Foreground
		HiddenGame=true
		CollideActors=false
		BlockActors=false
		BlockZeroExtent=false
		BlockNonZeroExtent=false
	End Object

	Begin Object class=StaticMeshComponent name=ExtBodyAttachment1
		StaticMesh=StaticMesh'VH_VN_Drivable_M113_APC.Mesh.VH_SM_M113_extra_Ext'
		LightingChannels=(Dynamic=TRUE,Unnamed_1=FALSE,bInitialized=TRUE)
		LightEnvironment = MyLightEnvironment
		CastShadow=false
		DepthPriorityGroup=SDPG_World
		HiddenGame=false
		CollideActors=false
		BlockActors=false
		BlockZeroExtent=false
		BlockNonZeroExtent=false
	End Object
	ExtExtraMesh=ExtBodyAttachment1

	// -------------- Interior attachments ------------------//

	Begin Object class=StaticMeshComponent name=IntBodyAttachment0
		StaticMesh=StaticMesh'ZM_VH_Drivable_M113_APC.Mesh.VH_SM_M113_Body_Int'
		LightingChannels=(Dynamic=TRUE,Unnamed_1=TRUE,bInitialized=TRUE)
		LightEnvironment = MyInteriorLightEnvironment
		CastShadow=false
		DepthPriorityGroup=SDPG_Foreground
		HiddenGame=true
		CollideActors=false
		BlockActors=false
		BlockZeroExtent=false
		BlockNonZeroExtent=false
	End Object



	/*Begin Object class=StaticMeshComponent name=IntBodyAttachment1
		StaticMesh=StaticMesh'VH_Sov_UniC.Mesh.VH_SM_UC_Driver_MG'
		LightingChannels=(Dynamic=TRUE,Unnamed_1=TRUE,bInitialized=TRUE)
		LightEnvironment = MyInteriorLightEnvironment
		CastShadow=false
		DepthPriorityGroup=SDPG_Foreground
		HiddenGame=true
		CollideActors=false
		BlockActors=false
		BlockZeroExtent=false
		BlockNonZeroExtent=false
	End Object*/

	MeshAttachments(0)={(AttachmentName=ExtBodyComponent,Component=ExtBodyAttachment0,AttachmentTargetName=chassis)}
	//MeshAttachments(1)={(AttachmentName=ExtExtraComponent,Component=ExtBodyAttachment1,AttachmentTargetName=chassis)}
	MeshAttachments(2)={(AttachmentName=IntBodyComponent,Component=IntBodyAttachment0,AttachmentTargetName=chassis)}
	//MeshAttachments(2)={(AttachmentName=IntBodyComponent2,Component=IntBodyAttachment1,AttachmentTargetName=chassis)}
	//MeshAttachments(3)={(AttachmentName=IntHullSide1Component,Component=IntBodyAttachment2,AttachmentTargetName=chassis)}
	//MeshAttachments(5)={(AttachmentName=TurretComponent,Component=TurretAttachment0,AttachmentTargetName=turret)}
	//MeshAttachments(6)={(AttachmentName=TurretGunGaseComponent,Component=TurretAttachment1,AttachmentTargetName=turret)}

	// 2D scene capture
    Begin Object Class=ROSceneCapture2DDPGComponent Name=PeriscopeSceneCapture2
        NearPlane=10
        FarPlane=0
        bEnabled=True
        ViewMode=SceneCapView_Lit
        FrameRate=60
        // bUseMainScenePostProcessSettings=true
        // bEnablePostProcess=true
        bEnableFog=True
        bUpdateMatrices=true
        bRenderWorldDPG=True
        bRenderForegroundDPG=True
        TextureTarget=TextureRenderTarget2D'ZM_VH_Drivable_M113_APC.Texture.PeriscopeRT_2'
        FieldOfView=90
        // "3.5X" = 32.5 / 3.5 = 9.2857(FYI: 32.5 is our "real world" FOV on a 19" monitor
    End Object
    SceneCapture2=PeriscopeSceneCapture2
}
