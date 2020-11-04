//=============================================================================
// Willy Pete Tripwire Trap
//=============================================================================
// Trap for south side to kill zombies
//=============================================================================
// Zombie mode for Rising Storm 2: Vietnam
// weapon finished by adrian! 
//=============================================================================

class ZMWeap_WillyPeteTripwireTrap extends ROPlantableTrapWeapon;

var class<TripwireTrapStake>		TrapStakeClass;

var repnotify bool	bPlantedFirstStake;		// Set to true once the first half of the trap is planted
var	bool	bShowingPlantHelper;			// Whether the helper effect is active or not

var	TripwireTrap	FirstStake;			// Stores our first stake so that we can both use its location as well as pass on the details of the second stake once planted
var vector			FirstStakeLoc;		// Location of the first stake, replicated to the client

// var SkeletalMesh FirstStakeAndChargeMesh;
// var SkeletalMesh SecondStakeMesh;

var const name SecondStakePlantAnim;
var const name SecondStakePutDownAnim;
var const name SecondStakeEquipAnim;
var const name SecondStakeDownAnim;
var const name SecondStakeUpAnim;
var const array<name> SecondStakeCrawlingAnims;
var const name SecondStakeCrawlStartAnim;
var const name SecondStakeCrawlEndAnim;
var const name SecondStakeSprintStartAnim;
var const name SecondStakeSprintLoopAnim;
var const name SecondStakeSprintEndAnim;
var const name SecondStakeMantleOverAnim;
var const name SecondStakePlaceTrapAnim;
var const name SecondStakePlaceTrapHardSurfaceAnim;
var const name SecondStakeReadyStartAnim;
var const name SecondStakeReadyEndAnim;
var const name SecondStakeReadyLoopAnim;
var const array<name> SecondStakeIdleAnims;

// end secondary animations

var	float	MaxPlantDistance;		// Max distance in UU that the second stake can be planted from the first
var	float	MaxPlantDistanceSq;		// Max distance (squared) in UU that the second stake can be planted from the first

var	StaticMeshComponent			HelperMesh;				// Static Mesh for trap helper preview
var MaterialInstanceConstant	HelperMIC;

var StaticMesh 		SecondStakeStaticMesh;

replication
{
	if( bNetDirty && Role == ROLE_Authority && bNetOwner )
		bPlantedFirstStake, FirstStakeLoc;
}

simulated event ReplicatedEvent(name VarName)
{
	if( VarName == 'bPlantedFirstStake' )
	{
		// This should be handled
		if( bPlantedFirstStake )
		{
			if( !bShowingPlantHelper && !IsInState('WeaponPuttingDown') )
				StartPlantHelper();

			if( Instigator.IsLocallyControlled() )
				SwapStakeMesh(false);
		}
		else if( !bPlantedFirstStake )
		{
			if( bShowingPlantHelper )
				StopPlantHelper();

			if( Instigator.IsLocallyControlled() )
				SwapStakeMesh(true);
		}
	}
	else
		super.ReplicatedEvent(VarName);
}


simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	MaxPlantDistanceSq = Square(MaxPlantDistance);

	HelperMIC = new class'MaterialInstanceConstant';
	HelperMIC.SetParent(MaterialInstanceConstant(HelperMesh.GetMaterial(0)));
	HelperMesh.SetMaterial(0, HelperMIC);
}

simulated function Activate()
{
	super.Activate();

	if( bPlantedFirstStake )
		StartPlantHelper();
}

simulated function PutDownWeapon()
{
	super.PutDownWeapon();

	if( bPlantedFirstStake )
		StopPlantHelper();
}

simulated function bool CanPlaceTrap()
{
	local Actor		HitActor;
	local vector	HitNormal, HitLocation, TraceEnd, TraceStart; //, TraceDir;
	local vector    ViewDirection;
	local float     VerticalAngle, LimitedVerticalAngle, TempFloat, TraceLength;
	local rotator   TempRot;
	local TraceHitInfo HitInfo;
	local ROPhysicalMaterialProperty PhysicalProperty;
	local ROPlayerController	ROPC;
	local ROPawn    ROP;
	local bool      bPhysMatSupportTraps;

	ROP = ROPawn(Instigator);
	ROPC = ROPlayerController(Instigator.Controller);
	if(ROPC == None || ROP == none || ROP.bIsProning || ROP.IsInCover() || ROP.VolumeKillTime > 0 || ROP.IsInState('SlowlyDying')
		|| ROP.IsDoingASpecialMove() || (bLockToTeam && Instigator.PlayerReplicationInfo.Team.TeamIndex != TeamIndex) || bForceLower )
	{
		HidePreviewMesh();
		return false;
	}

	TraceStart = Instigator.GetPawnViewLocation();
	ViewDirection = Vector(Instigator.GetViewRotation());
	VerticalAngle = acos(-ViewDirection.Z);

	// This shouldn't actually get called atm, as proned planting of these traps is disabled above
	if( Instigator.bIsProning )
	{
		TraceLength = 40;
		LimitedVerticalAngle = FMin(VerticalAngle, MaxAngleForViewDirForProning * DegToRad);
	}
	else if( Instigator.bIsCrouched )
	{
		TraceLength = FMax(60, 60.0 / cos(MaxAngleForViewDirForCrouching * DegToRad));
		LimitedVerticalAngle = FMin(VerticalAngle, MaxAngleForViewDirForCrouching * DegToRad);
	}
	else
	{
		TraceLength = FMax(85.f, 78.0 / cos(MaxAngleForViewDirForStanding * DegToRad));
		LimitedVerticalAngle = FMin(VerticalAngle, MaxAngleForViewDirForStanding * DegToRad);
	}

	if (LimitedVerticalAngle < VerticalAngle)
	{
		// If there is an enemy close to us, don't allow us to plant the trap
		if (IsThereAnyEnemyInFront())
		{
			HidePreviewMesh();
			return false;
		}

		ViewDirection.Z = -cos(LimitedVerticalAngle);
		TempFloat = sqrt((1 - ViewDirection.Z * ViewDirection.Z) / (ViewDirection.X * ViewDirection.X + ViewDirection.Y * ViewDirection.Y));
		ViewDirection.X *= TempFloat;
		ViewDirection.Y *= TempFloat;
	}

	TraceEnd = TraceStart + ViewDirection * TraceLength;

	//`log(self $ "  ViewDirection=" $ ViewDirection);
	//DrawDebugLine(TraceStart, TraceEnd, 255, 0, 0, true);

	HitActor = Trace(HitLocation, HitNormal, TraceEnd, TraceStart, false,, HitInfo, TRACEFLAG_PhysicsVolumes );

	// Don't allow planting in water or by aiming at the sky
	if( HitActor != none && WaterVolume(HitActor) != none || VerticalAngle > 1.4 )
	{
		HidePreviewMesh();
		return false;
	}

	HitActor = Trace(HitLocation, HitNormal, TraceEnd, TraceStart, false,, HitInfo, TRACEFLAG_Bullet | TRACEFLAG_NeedsTerrainMaterial);

	if( HitActor != none && HitActor.bWorldGeometry )
	{
		TempRot.Yaw = Instigator.GetViewRotation().Yaw - 16384;
		TrapPlaceRot = TempRot;
		TrapPlaceLoc = HitLocation;

		// Ground must be actual ground rather than a wall
		if( HitNormal.Z < 0.7 ) //|| WaterVolume(HitActor) != None )
		{
			return false;
		}
		// if we're planting the second stake don't allow it to be too far from the first
		else if( bPlantedFirstStake && VSizeSq(HitLocation - FirstStakeLoc) > MaxPlantDistanceSq )
		{
			return false;
		}

		// Workaround for floating point errors in trace locations
		// TraceDir = Normal(TraceEnd - TraceStart);
		// if( HitActor.IsA('WorldInfo') )
		// {
		// 	// BSP
		// 	HitLocation.X = HitLocation.X + 0.50f * TraceDir.X;
		// 	HitLocation.Y = HitLocation.Y + 0.50f * TraceDir.Y;
		// 	HitLocation.Z = HitLocation.Z - 0.50f * Abs(TraceDir.Z);
		// }
		// else
		// {
		// 	// Static Meshes
		// 	HitLocation.X = HitLocation.X + 3.0f * TraceDir.X;
		// 	HitLocation.Y = HitLocation.Y + 3.0f * TraceDir.Y;
		// 	HitLocation.Z = HitLocation.Z - 3.0f * Abs(TraceDir.Z);
		// }

		// Is this type of terrain suitable for burying a trap
		if (HitInfo.PhysMaterial != None)
		{
			PhysicalProperty = ROPhysicalMaterialProperty(HitInfo.PhysMaterial.GetPhysicalMaterialProperty(class'ROPhysicalMaterialProperty'));
			bPhysMatSupportTraps = PhysicalProperty != None && PhysicalMaterialSupportsTraps(PhysicalProperty, CurPlaceSurfaceStrength);

			if (bPhysMatSupportTraps || bPlaceAnywhere)
			{
				bOffsetTrap = !bPhysMatSupportTraps;

				ShowPreviewMesh();

				// Make sure we have line of sight between our stakes
				if( bPlantedFirstStake )
				{
					//FlushPersistentDebugLines();
					//DrawDebugLine(FirstStakeLoc - vect(0,0,1),HitLocation + vect(0,0,1) * (TrapOffset - 1),255,0,255,TRUE);

					// Lower the planting trace check by 1 to make sure that the wire, when planted, is visibly clear of any terrain,
					// rather than potentially touching it
					if( !FastTrace(FirstStakeLoc - vect(0,0,1), HitLocation + vect(0,0,1) * (TrapOffset - 1),,true) )
					{
						return false;
					}
				}

				ROPC.ReceiveLocalizedMessage(class'ROLocalMessagePlantedItem', ROTMSG_PlantTrap,,,ROPC);
				return true;
			}
		}
	}

	HidePreviewMesh();
	return false;
}

simulated function SpawnTrap()
{
	local ROPlantedTrap P;
	local ROPlayerController ROPC;

	if ( bDebugWeapon )
	{
		`log("ROPlantableTrapWeapon.SpawnTrap running");
	}

	// Make sure a camera shift hasn't moved our aim to somewhere that we can't plant
	if( !CanPlaceTrap() )
	{
		CancelWeaponAction(true, true);
		GotoActiveState();
		return;
	}

	// Called if the boobytrap bit is planted.
	if( bPlantedFirstStake )
	{
		ROPC = ROPlayerController(Instigator.Controller);

		if ( ROPC != none )
		{
			ROPC.TriggerHint(ROHTrig_PlantingTrapsVC);
		}

		if( Role == ROLE_Authority )
		{
			TrapStakeFire();

			ConsumeAmmo(DEFAULT_FIREMODE);

			// Clear our stored first stake
			FirstStake = none;
		}
	}
	else
	{
		if( Role == ROLE_Authority )
		{
			P = ROPlantedTrap(BoobyTrapFire());

			if( P != none )
			{
				if( bRandomiseFuse )
					P.FuseLength += FRand() * 0.5;

				ROPlayerController(Instigator.Controller).AddPlantedTrap(P);
			}
		}
	}
}

simulated function Projectile BoobyTrapFire()
{
	// local vector SpawnOffset;
	// local rotator SpawnRot;

	if ( bDebugWeapon )
		`log("ROExplosiveWeapon.ProjectileFire - FireMode:"$CurrentFireMode @ "FireStartLoc:"$GetPhysicalFireStartLoc() @ "State:"$GetStateName());

	if( Role == ROLE_Authority )
	{
		// SpawnRot.Yaw = Rotation.Yaw + 16384;
		// SpawnRot.Yaw = 32768;

		// SpawnOffset = vect(0,0,0);
		// Spawn projectile

		FirstStake = TripwireTrap(Spawn(TrapClass,,, TrapPlaceLoc + vect(0,0,1) * TrapOffset, TrapPlaceRot));

		if( FirstStake != none )
		{
			bPlantedFirstStake = true;

			FirstStake.OwningWeapon = self;
			FirstStakeLoc = FirstStake.Location;

			if( Instigator.IsLocallyControlled() )
				StartPlantHelper();

			if(WorldInfo.NetMode != NM_DedicatedServer)
			{
				SwapStakeMesh(false);
			}
		}

	}


	return FirstStake;
}

// Sets up the second stake
simulated function TrapStakeFire()
{
	// local float			RandYaw;
	// local Rotator		SpawnRot;
	// local vector SpawnOffset;
	local TripwireTrapStake TTS;

	if( Role == ROLE_Authority )
	{
		// RandYaw = RandRange(0,55535); // Randomise rotation so that if traps are marked, they don't all look identical
		// SpawnRot.Yaw = RandYaw;

		// Spawn second part of the trap
		TTS = Spawn(TrapStakeClass,,, TrapPlaceLoc + vect(0,0,1) * TrapOffset, TrapPlaceRot);
		ROTeamInfo(WorldInfo.GRI.Teams[Instigator.GetTeamNum()]).PlantedTraps.AddItem(FirstStake);

		// Tell the first part of the trap about the second. It will be handling cleanup of the second on shutdown
		if( TTS != none && FirstStake != none )
		{
			bPlantedFirstStake = false;

			TTS.MyTripwireTrap = FirstStake;
			FirstStake.CompleteTrapSetup(TTS);

			if( Instigator.IsLocallyControlled() )
				StopPlantHelper();

			if(WorldInfo.NetMode != NM_DedicatedServer)
			{
				SwapStakeMesh(true);
			}
		}
	}
}

simulated function UpdatePlantHelper()
{
	// TEMP. Replace with proper effect
	//FlushPersistentDebugLines();

	if( !bPlantedFirstStake )
	{
		StopPlantHelper();
		return;
	}

	if( VSizeSq(FirstStakeLoc - Instigator.Location) > MaxPlantDistanceSq && !bLastCheckSuccessful )
	{
		//DrawDebugSphere(FirstStakeLoc, MaxPlantDistance, 16, 255, 0, 0, true);
		HelperMIC.SetVectorParameterValue('color', RedColour);
	}
	else
	{
		//DrawDebugSphere(FirstStakeLoc, MaxPlantDistance, 16, 0, 255, 0, true);
		HelperMIC.SetVectorParameterValue('color', GreenColour);
	}
}

simulated function StartPlantHelper()
{
	if( Instigator.IsLocallyControlled() )
	{
		bShowingPlantHelper = true;
		SetTimer(0.1,true,'UpdatePlantHelper');

		if( !HelperMesh.bAttached )
		{
			AttachComponent(HelperMesh);
			HelperMesh.SetTranslation(FirstStakeLoc);
		}
	}
}

simulated function StopPlantHelper()
{
	if( Instigator.IsLocallyControlled() )
	{
		if( IsTimerActive('UpdatePlantHelper') )
			ClearTimer('UpdatePlantHelper');
		bShowingPlantHelper = false;

		if( HelperMesh.bAttached )
			DetachComponent(HelperMesh);

		//FlushPersistentDebugLines();
	}
}

simulated function Destroyed()
{
	// If something causes this weapon to be removed (like pawn death), make sure the planting effects get turned off
	StopPlantHelper();
	super.Destroyed();
}


// After placing the first stake and arming its charge, we pull out a second stake that utilizes most of the same anims but is somehow different
// in appearance (doesn't have a grenade on the end of it, for example). We also swap the planting animations; these ought to be the only different ones
simulated function SwapStakeMesh(bool bToFirst)
{
	if(bToFirst)
	{
		WeaponPutDownAnim = default.WeaponPutDownAnim;
		WeaponEquipAnim = default.WeaponEquipAnim;
		WeaponDownAnim = default.WeaponPutDownAnim;
		WeaponUpAnim = default.WeaponUpAnim;

		// Prone Crawl
		WeaponCrawlingAnims = default.WeaponCrawlingAnims;
		WeaponCrawlStartAnim = default.WeaponCrawlStartAnim;
		WeaponCrawlEndAnim = default.WeaponCrawlEndAnim;

		// Sprinting
		WeaponSprintStartAnim = default.WeaponSprintStartAnim;
		WeaponSprintLoopAnim = default.WeaponSprintLoopAnim;
		WeaponSprintEndAnim = default.WeaponSprintEndAnim;

		// Mantling
		WeaponMantleOverAnim = default.WeaponMantleOverAnim;

		// Planting
		WeaponPlaceTrapAnim = default.WeaponPlaceTrapAnim;
		WeaponPlaceTrapHardSurfaceAnim = default.WeaponPlaceTrapHardSurfaceAnim;
		WeaponReadyStartAnim = default.WeaponReadyStartAnim;
		WeaponReadyEndAnim = default.WeaponReadyEndAnim;
		WeaponReadyLoopAnim = default.WeaponReadyLoopAnim;

		WeaponIdleAnims = default.WeaponIdleAnims;

		PreviewMesh.SetStaticMesh(default.PreviewMesh.StaticMesh, true);
	}
	else
	{
		WeaponPutDownAnim = default.SecondStakePutDownAnim;
		WeaponEquipAnim = default.SecondStakeEquipAnim;
		WeaponDownAnim = default.SecondStakePutDownAnim;
		WeaponUpAnim = default.SecondStakeUpAnim;

		// Prone Crawl
		WeaponCrawlingAnims = default.SecondStakeCrawlingAnims;
		WeaponCrawlStartAnim = default.SecondStakeCrawlStartAnim;
		WeaponCrawlEndAnim = default.SecondStakeCrawlEndAnim;

		// Sprinting
		WeaponSprintStartAnim = default.SecondStakeSprintStartAnim;
		WeaponSprintLoopAnim = default.SecondStakeSprintLoopAnim;
		WeaponSprintEndAnim = default.SecondStakeSprintEndAnim;

		// Mantling
		WeaponMantleOverAnim = default.SecondStakeMantleOverAnim;

		// Planting
		WeaponPlaceTrapAnim = default.SecondStakePlaceTrapAnim;
		WeaponPlaceTrapHardSurfaceAnim = default.SecondStakePlaceTrapHardSurfaceAnim;
		WeaponReadyStartAnim = default.SecondStakeReadyStartAnim;
		WeaponReadyEndAnim = default.SecondStakeReadyEndAnim;
		WeaponReadyLoopAnim = default.SecondStakeReadyLoopAnim;

		WeaponIdleAnims = default.SecondStakeIdleAnims;

		PreviewMesh.SetStaticMesh( default.SecondStakeStaticMesh, true );
	}
}


// Called when the first stake is disarmed by the owner, before planting the second stake
function ResetByOwner(bool bCurrentWeapon)
{
	// `Log("Disarming first stake");

	bPlantedFirstStake = false;
	FirstStake = none;

	if( Instigator.IsLocallyControlled() )
	{
		SwapStakeMesh(true);
	}

	if(bCurrentWeapon)
	{
		ServerTrapWasPlanted();
	}
}

simulated state WeaponEquipping
{
	simulated function BeginState(Name PreviousStateName)
	{
		local ROPlayerController ROPC;
		super.BeginState(PreviousStateName);

		ROPC = ROPlayerController(Instigator.Controller);

		if ( ROPC != none )
		{
			ROPC.TriggerHint(ROHTrig_TripwireTrap);
		}
	}
}

// Update the postion of the Preview Mesh
simulated function UpdatePreviewMesh(optional byte IsHardSurface)
{
	if ( Instigator != none )
	{
		// Move the Static mesh into place
		PreviewMesh.SetTranslation(TrapPlaceLoc);
		PreviewMesh.SetRotation(TrapPlaceRot);

		// RS2PR-4745 - We now indicate to the player if the surface will make us take longer to plant the tunnel. -Nate
		if(bLastCheckSuccessful)
		{
			if(IsHardSurface < 1)
			{
				PreviewMeshMIC.SetVectorParameterValue('color', GreenColour);
			}
			else
			{
				PreviewMeshMIC.SetVectorParameterValue('color', YellowColour);
			}
		}
		else
		{
			PreviewMeshMIC.SetVectorParameterValue('color', RedColour);
		}
	}
}

// CLBIT-5429 - Immediately hide the preview mesh if we're switching weapons. -Nate
simulated function CancelWeaponAction(optional bool bAnimate, optional bool bReplicateToServer)
{
	HidePreviewMesh();
	Super.CancelWeaponAction(bAnimate, bReplicateToServer);
}

defaultproperties
{
	WeaponContentClass(0)"ZombieMode.ZMWeap_TripwireTrap_Content"

	RoleSelectionImage(0)=Texture2D'VN_UI_Textures.WeaponTex.VN_Weap_TripwireTrap'

	TeamIndex=`ALLIES_TEAM_INDEX
	WeaponClassType=ROWCT_BoobyTrap

	InvIndex=`ROII_TripwireTrap
	InventoryWeight=0

	PlayerViewOffset=(X=5,Y=4.5,Z=-1.75)
	ShoulderedPosition=(X=2.5,Y=2.5,Z=-0.0)
	//ShoulderRotation=(Pitch=-300,Yaw=500,Roll=1500)

	//Special things to swap between. Set meshes in content class!!
	SecondStakePlantAnim=TW02_boobyTrap
	SecondStakePutDownAnim=TW02_Putaway
	SecondStakeEquipAnim=TW02_Pullout
	SecondStakeDownAnim=TW02_Down
	SecondStakeUpAnim=TW02_Up

	SecondStakeCrawlingAnims(0)=TW02_CrawlF
	SecondStakeCrawlStartAnim=TW02_Crawl_into
	SecondStakeCrawlEndAnim=TW02_Crawl_out

	SecondStakeSprintStartAnim=TW02_sprint_into
	SecondStakeSprintLoopAnim=TW02_Sprint
	SecondStakeSprintEndAnim=TW02_sprint_out

	SecondStakeMantleOverAnim=TW02_Mantle

	SecondStakePlaceTrapAnim=TW02_boobyTrap
	SecondStakePlaceTrapHardSurfaceAnim=TW02_boobyTrap_Long
	SecondStakeReadyStartAnim=TW02_idle_to_boobytrap_idle
	SecondStakeReadyEndAnim=TW02_boobytrap_to_idle
	SecondStakeReadyLoopAnim=TW02_boobyTrap_idle

	SecondStakeIdleAnims(0)=TW02_idle
	SecondStakeIdleAnims(ALTERNATE_FIREMODE)=TW02_idle

	// Anims
	WeaponPutDownAnim=TW01_Putaway
	WeaponEquipAnim=TW01_Pullout
	WeaponDownAnim=TW01_Down
	WeaponUpAnim=TW01_Up

	// Prone Crawl
	WeaponCrawlingAnims(0)=TW01_CrawlF
	WeaponCrawlStartAnim=TW01_Crawl_into
	WeaponCrawlEndAnim=TW01_Crawl_out

	// Sprinting
	WeaponSprintStartAnim=TW01_sprint_into
	WeaponSprintLoopAnim=TW01_Sprint
	WeaponSprintEndAnim=TW01_sprint_out

	// Mantling
	WeaponMantleOverAnim=TW01_Mantle

	// Planting
	WeaponPlaceTrapAnim=TW01_boobyTrap
	WeaponPlaceTrapHardSurfaceAnim=TW01_boobyTrap_Long
	WeaponReadyStartAnim=TW01_idle_to_boobytrap_idle
	WeaponReadyEndAnim=TW01_boobytrap_to_idle
	WeaponReadyLoopAnim=TW01_boobyTrap_idle

	WeaponIdleAnims(0)=TW01_idle
	WeaponIdleAnims(ALTERNATE_FIREMODE)=TW01_idle

	// Enemy Spotting
	WeaponSpotEnemyAnim=TW01_SpotEnemy

	AmmoClass=class'ZMAmmo_WilliePeteTripwireTrap'
	//TrapClass=class'TripwireTrap'
	TrapClass=class'ZMWilliePeteTripwireTrap'
	TrapStakeClass=class'TripwireTrapStake'

	// MAIN FIREMODE
	FiringStatesArray(0)=WeaponSingleFiring
	//WeaponProjectiles(0)=class'Type97GrenadeProjectile'

	// ALT FIREMODE
	FiringStatesArray(ALTERNATE_FIREMODE)=WeaponSingleFiring
	//WeaponProjectiles(ALTERNATE_FIREMODE)=class'Type97GrenadeProjectile'

	Weight=0.00	//KG
	MaxAmmoCount=2
	InitialNumPrimaryMags=2
	MaxAllowedAtOnce=2

	// AI
	MinBurstAmount=1
	MaxBurstAmount=1
	BurstWaitTime=5.0

	bPlaceOnHardSurfaces=true

	MaxPlantDistance=400 // 8m

	Begin Object Class=StaticMeshComponent Name=TrapHelperMeshComponent
		CollideActors=false
		BlockActors=false
		BlockZeroExtent=false
		BlockNonZeroExtent=false
		BlockRigidBody=false
		RBChannel=RBCC_Nothing
		StaticMesh=StaticMesh'FX_VN_Materials.Commander.S_ENV_TrapBorder'
		DepthPriorityGroup=SDPG_World
		AbsoluteTranslation=true
		AbsoluteRotation=true
		AbsoluteScale=true
		Scale=4.0
	End Object
	HelperMesh=TrapHelperMeshComponent

	Begin Object Name=PreviewMeshComponent
		StaticMesh=StaticMesh'WP_VN_VC_Tripwire_Trap.Mesh.BoobyTrapMarker_02'
		Materials(0)=MaterialInstanceConstant'FX_VN_Materials.Materials.M_TrapBorder'
	End Object

	SecondStakeStaticMesh=StaticMesh'WP_VN_VC_Tripwire_Trap.Mesh.BoobyTrapMarker_01'

	TrapOffset=18

	EquipTime=+0.33 //0.35


	
	
	// bDebugWeapon=True
