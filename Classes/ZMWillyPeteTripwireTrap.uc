//=============================================================================
// WillyPeteTripwireTrap
//=============================================================================
// Planted trap world object for the Tripwire Booby Trap. This explodes in a
// cloud of white smoke, and sets players afire.
//=============================================================================
// Vietnam Expansion for Red Orchestra: Heroes of Stalingrad Source
// Copyright (C) 2014 Tripwire Interactive LLC
// - Austin "dibbler67" Ware for Antimatter Games
// edited and finished by adrian!
//=============================================================================

class ZMWillyPeteTripwireTrap extends ROPlantedTrap;

// This is the other end of the trap. It's just a stake that the tripwire extends to and is despawned when this owning actor is.
// It's set here by the weapon class when the stake is planted. UPDATE: No longer replicated
var TripwireTrapStake	TTStake;
var TripwireProximityDetector		MyProximityDetector;	// enables/disables tripwire tracing when pawns in range
var TripwireMeshActor			MyMeshActor;			// displays the tripwire mesh.

var int CollisionHeightCheck;

var vector	TripwireStartLoc;	// Point to start our traces from
var vector	TripwireEndLoc;		// Point to end our traces at. Replicating so we can orient the tripwire mesh on the server
var repnotify vector RepWireMeshVector;		// Vector pointing halfway along the trace line. Used to position and orient the mesh actor on clients

var StaticMeshComponent TripwireTrapStaticMeshComp; // Exposed so we may set the highlight parameter in code.


simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	if ( ROTUH != none )
	{
		ROTUH.bDoesActorAimedAtCheck = false;
	}
}

simulated function bool CanDisarmHook(Pawn Disarmer)
{
	local ROPlayerController ROPC;

	if ( Disarmer != none )
	{
		ROPC = ROPlayerController(Disarmer.Controller);

		if ( ROPC != none )
		{
			// if this is too inefficient implment custom LOS/Usable check here
			ROPC.FindActorAimedAt();
			if (ROPC.ActorAimedAt != self)
			{
				if (ROPC.CurrentTripwireTrapToDisarm != self)
				{
					return false;
				}
			}
		}

		return Super.CanDisarmHook(Disarmer);
	}

	return false;
}

// @Override to resupply the owner if he disarms this trap
// -Austin
//function bool UsedBy(Pawn User)
function AttemptReplenish(Pawn User, bool bWasPlanted)
{
	local ROInventoryManager ROIM;
	local ZMWeap_WillyPeteTripwireTrap Weap;

	//`Log("Disarming own tripwire trap");
	// Disarmed our own trap
	if( PlanterROPC.Pawn == User )
	{
		// Trap wasn't fully planted yet, so reset the weapon
		if( TTStake == none )
		{
			ROIM = ROInventoryManager(PlanterROPC.Pawn.InvManager);

			foreach ROIM.InventoryActors(class'ZombieMode.ZMWeap_WillyPeteTripwireTrap',Weap)
			{
				if( Weap != none && Weap.bPlantedFirstStake )
				{
					Weap.ResetByOwner(User.Weapon == Weap);
					return;
				}
			}
		}
		// Trap was fully planted, so add the trap back into the player's inventory
		else
		{
			ROIM = ROInventoryManager(PlanterROPC.Pawn.InvManager);

			// if the player already has a trap weapon, just add 1 ammo
			foreach ROIM.InventoryActors(class'ZombieMode.ZMWeap_WillyPeteTripwireTrap',Weap)
			{
				if( Weap != none )
				{
					Weap.GiveClips(1);
					return;
				}
			}

			// Otherwise, create a new weapon in the inventory, but only give 1 ammo
			Weap = ZMWeap_WillyPeteTripwireTrap(ROIM.LoadAndCreateInventory("ZombieMode.ZMWeap_WillyPeteTripwireTrap_Content",,true));
			if(Weap != none)
			{
				Weap.ConsumeAmmo(0);
			}
		}
	}
	// Someone else disarmed this trap before the line had been strung
	else if( TTStake == none )
	{
		ROIM = ROInventoryManager(PlanterROPC.Pawn.InvManager);

		// if the player already has a trap weapon, use up 1 ammo
		foreach ROIM.InventoryActors(class'ZombieMode.ZMWeap_WillyPeteTripwireTrap',Weap)
		{
			if( Weap != none && Weap.bPlantedFirstStake )
			{
				Weap.bPlantedFirstStake = false;
				Weap.ConsumeAmmo(0);
				Weap.FirstStake = none;
				Weap.ServerTrapWasPlanted(bWasPlanted);

				if ( bWasPlanted )
				{
					// Make sure we use the proper animations.
					if(Weap.CurrentMagCount > 0)
					{
						if( User.IsLocallyControlled() )
							Weap.SwapStakeMesh(true);
					}
					else
					{
						if( User.IsLocallyControlled() )
							Weap.SwapStakeMesh(false);
					}
				}

				return;
			}
		}
	}
}

function DisarmTrap(Pawn User)
{
	local ROPlayerReplicationInfo ROPRI;
	local ROGameReplicationInfo ROGRI;
	local ROGameInfo ROGI;

	AttemptReplenish(User, true);

	ROPRI = ROPlayerReplicationInfo(User.PlayerReplicationInfo);

	if (ROPRI != None && CanDisarmByWire(User, ROPRI.GetTeamNum()) )
	{
		ROGI = ROGameInfo(WorldInfo.Game);
		ROGRI = ROGameReplicationInfo(WorldInfo.GRI);

	    ROPlayerController(User.Controller).DisableHint(ROHTrig_DisarmBooby, true);

		if ( Role == ROLE_Authority && ROGRI != none && ROGI != none && ROGI.bRoundActive )
		{
			// TODO: Alter ROPlayerController.uc to add new kill messages
			if ( ROPRI.GetTeamNum() == OwningTeam )
			{
				// do nothing if we are disarming our own trap
			}
			else
			{
				ROGI.AddDelayedKillMessage(ROKMT_TrapDisarm, ROGRI.ElapsedTime, ROPRI);
			}
		}

	    if( WorldInfo.NetMode != NM_StandAlone )
	    {
			ClientPlayDisarmSound();
	    }
		else
		{
			PlayDisarmSound();
		}

	    PlanterROPC.RemovePlantedTrap(self, ROPRI.GetTeamNum() != OwningTeam);
	    Shutdown();
	}
}

// Determines whether the disarmer is allowed to disarm this trap based on its disarm settings (in default properties),
// whether it has been triggered or not, and the disarmer's distance from the trap
simulated function bool CanDisarmByWire(Pawn Disarmer, int DisarmerTeam)
{
	if( bTriggered )
	{
		return false;
	}

	switch( DisarmAllowedBy )
	{
		case EPTD_None:
			return false;
			break;
		case EPTD_SameTeam:
			if( DisarmerTeam != OwningTeam )
				return false;
			break;
		case EPTD_EnemyTeam:
			if( DisarmerTeam == OwningTeam )
				return false;
			break;
		case EPTD_EnemyAndOwner:
			if( DisarmerTeam == OwningTeam && Disarmer.PlayerReplicationInfo != PlanterROPC.PlayerReplicationInfo )
				return false;
			break;
		case EPTD_All:
			break;
	}

	return true;
}

// Override to explode in at the grenade location
simulated function DoExplode()
{
	bAlreadExploded=true;
	Explode(Location, LastHitNormal);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local ROInventoryManager ROIM;
	local ZMWeap_WillyPeteTripwireTrap Weap;

	Super.Explode(HitLocation, HitNormal);

	// if this trap doesn't have its second stake planted yet, let the owning player know and adjust the weapon animations
	if( TTStake != none )
	{
		return;
	}
	else if (PlanterROPC.Pawn != none)
	{
		ROIM = ROInventoryManager(PlanterROPC.Pawn.InvManager);

		foreach ROIM.InventoryActors(class'ZombieMode.ZMWeap_WillyPeteTripwireTrap',Weap)
		{
			if( Weap != none )
			{
				if( Weap.bPlantedFirstStake )
				{
					Weap.bPlantedFirstStake = false;
					Weap.ConsumeAmmo(0);
					Weap.FirstStake = none;
					Weap.ServerTrapWasPlanted();

					if( PlanterROPC.Pawn.IsLocallyControlled() )
						Weap.SwapStakeMesh(true);
				}
			}

			break;
		}
	}
}



/**
 * Hurt locally authoritative actors within the radius.
 * Projectile version if needed offsets the start of the radius check to prevent hits embedded in walls from failing to cause damage
 */
simulated function bool ProjectileHurtRadius(vector HurtOrigin, vector HitNormal)
{
	local Actor	Victim;
	local bool bCausedDamage, bKilledWithOneStake;
	local TraceHitInfo HitInfo;
	local StaticMeshComponent HitComponent;
	local KActorFromStatic NewKActor;
	// RO locals
	//local bool bInitializedAltOrigin, bFailedAltOrigin;
	//local vector AltOrigin;
	local float DamageScale;
	local float FalloffExponent;
	local ROPawn ROPVictim;
	local vector MyGravity;
	// local bool	bWasAlive;

	// Prevent HurtRadius() from being reentrant.
	if ( bHurtEntry )
		return false;

	bHurtEntry = true;
	bCausedDamage = false;

	MyGravity.Z = PhysicsVolume.GetGravityZ();

	// Do the damage a little off the ground
	HurtOrigin += ExplosionOffsetDist * -Normal(MyGravity);

	// Debugging
	//FlushPersistentDebugLines();
	//DrawDebugSphere(HurtOrigin, DamageRadius, 16, 255, 0, 0, true); // Draw a red sphere to represent the damage radius
	//DrawDebugSphere(HurtOrigin, 10, 16, 255, 0, 0, true);           // Draw a small red sphere at the explosion location

	// if ImpactedActor is set, we actually want to give it full damage, and then let him be ignored by super.HurtRadius()
	if ( ImpactedActor != none && ImpactedActor != self )
	{
		ImpactedActor.TakeRadiusDamage(InstigatorController, Damage, DamageRadius, MyDamageType, MomentumTransfer, HurtOrigin, true, self);
		// need to check again in case TakeRadiusDamage() did something that went through our explosion path a second time
		if ( ImpactedActor != none )
		{
			bCausedDamage = ImpactedActor.bProjTarget;
		}
	}

	// Based on Actor.HurtRadius()
	foreach CollidingActors( class'Actor', Victim, DamageRadius, HurtOrigin,,, HitInfo )
	// foreach VisibleCollidingActors( class'Actor', Victim, DamageRadius, HurtOrigin,,,,, HitInfo )
	{
		// Do more expensive 'exposure' checks below
		if ( Victim.bStatic || Victim.IsA('ROPawn') || !FastTrace(Victim.Location, HurtOrigin) )
		{
			continue;
		}

		if ( Victim.bWorldGeometry )
		{
			// check if it can become dynamic
			// @TODO note that if using StaticMeshCollectionActor (e.g. on Consoles), only one component is returned.  Would need to do additional octree radius check to find more components, if desired
			HitComponent = StaticMeshComponent(HitInfo.HitComponent);
			if ( (HitComponent != None) && HitComponent.CanBecomeDynamic() )
			{
				NewKActor = class'KActorFromStatic'.Static.MakeDynamic(HitComponent);
				if ( NewKActor != None )
				{
					Victim = NewKActor;
				}
			}
		}
		// aladenberger 6/17/2011 - For whatever reason, ROStaticMeshDestructible is bWorldGeometry!
		if ( /*!Victim.bWorldGeometry &&*/ (Victim != self) && (Victim != ImpactedActor) && (Victim.bCanBeDamaged || Victim.bProjTarget) )
		{
			Victim.TakeRadiusDamage(InstigatorController, Damage, DamageRadius, MyDamageType, MomentumTransfer, HurtOrigin, false, self);
			bCausedDamage = bCausedDamage || Victim.bProjTarget;
		}
	}

	foreach CollidingActors( class'ROPawn', ROPVictim, DamageRadius, HurtOrigin,,, HitInfo )
	{
		if(ROPVictim.Health <= 0)
		{
			continue;
		}

		DamageScale = ROPVictim.GetExposureTo(HurtOrigin);
		// Used Quadratic model on Players(1 - (Distance/Radius)^3)
		FalloffExponent = RadialDamageFalloffExponent;

		// Add the origin of the explosion to the LastTsakeHitInfo
		ROPVictim.LastTakeHitInfo.RadialDamageOrigin = HurtOrigin;

		if( DamageScale > 0 )
		{
			ROPVictim.TakeRadiusDamage(InstigatorController, Damage * DamageScale, DamageRadius, MyDamageType, MomentumTransfer, HurtOrigin, false, self, FalloffExponent);
			ROPVictim.CollisionComponent.AddRadialForce(Location, RadialForceRadius, RadialForce, RIF_Linear);
		}
		bCausedDamage = bCausedDamage || ROPVictim.bProjTarget;

		if ( bKilledWithOneStake ) continue; // If we've already got this, then don't do the checks.

		if ( InstigatorController.GetTeamNum() != ROPVictim.GetTeamNum() && ROPVictim.Health <= 0 && TTStake == none )
		{
			bKilledWithOneStake = true;
		}
	}

	if ( bKilledWithOneStake && ROPlayerController(InstigatorController) != none )
	{
		`LogStats(InstigatorController.PlayerReplicationInfo.PlayerName @ "Killed TripwireTrap without second stake, Unlocking No Strings Attached Achievement, Is Unlocked:" @ ROPlayerController(InstigatorController).IsAchievementUnlocked(`ACHID_NoStringsAttached));
		if ( !ROPlayerController(InstigatorController).IsAchievementUnlocked(`ACHID_NoStringsAttached) )
		{
			ROPlayerController(InstigatorController).UnlockAchievement(`ACHID_NoStringsAttached);
		}
	}

	bHurtEntry = false;

	return bCausedDamage;
}

function CompleteTrapSetup(TripwireTrapStake SecondStake)
{
	local vector HalfDirToStake, NewScale;
	local rotator UpdatedRot;

	TTStake = SecondStake;

	HalfDirToStake = 0.5 * (SecondStake.Location - Location);

	bForceNetUpdate = true;

//	`Log("CompleteTrapSetup : On Server");
	MyProximityDetector = Spawn(class'ROGame.TripwireProximityDetector',self,, Location + HalfDirToStake,,);
	MyProximityDetector.MyTrap = self;
	// Set the collision radius to match (roughly) the distance between the stakes. This is purely an optimisation.
	MyProximityDetector.SetCollisionSize(VSize(HalfDirToStake) + 15, CollisionHeightCheck);

	TripwireStartLoc = Location;
	TripwireEndLoc = SecondStake.Location;	// replicate me

	UpdatedRot = rotator(HalfDirToStake);
	UpdatedRot.Yaw += 8000;

	SetRotation(UpdatedRot);

	MyMeshActor = Spawn(class'ROGame.TripwireMeshActor',self,, Location + HalfDirToStake, rotator(HalfDirToStake),,);
	NewScale = vect(1,0.2,0.2);
	NewScale.X = 2 * VSize(HalfDirToStake);
	MyMeshActor.SetDrawScale3D(NewScale);
	MyMeshActor.MyTripwireTrap = self;

	// replicate proper rotation and scale
	MyMeshActor.RepOrientation = EncodeSmallVector(HalfDirToStake);
}

simulated function Destroyed()
{
	local ROPlayerController ROPC;

	if(Role == ROLE_Authority)
	{
		foreach WorldInfo.AllControllers(class'ROPlayerController', ROPC)
		{
			if( ROPC.CurrentTripwireTrapToDisarm == self )
			{
				ROPC.CurrentTripwireTrapToDisarm = none;
				ROPC.bCanDisarmTripwireTrap = false;
			}
		}
	}

	if( TTStake != none )
	{
		TTStake.Destroy();
	}

	if( MyProximityDetector != none )
	{
		MyProximityDetector.Destroy();
	}

	if( MyMeshActor != none )
	{
		MyMeshActor.Destroy();
	}

	ClearTimer('CheckTripwire');

	Super.Destroyed();
}

// Perform a trace along the tripwire to see if anyone's triggered it and if so, set the trap to explode
function CheckTripwire()
{
	local vector HitLoc, HitNorm;
	local Actor	HitActor;
	local Pawn P;
	local ROPlayerReplicationInfo ROPRI;

	HitActor = Trace(HitLoc, HitNorm, TripwireEndLoc, TripwireStartLoc, true,,, TRACEFLAG_Bullet);

	P = Pawn(HitActor);

	if( P != none )
	{
		ROPRI = ROPlayerReplicationInfo(P.PlayerReplicationInfo);

		if( ROPRI != none && (ROPRI.Team.TeamIndex != OwningTeam || bFriendlyTriggers) )
		{
			bTriggered = true;
			NetCullDistanceSquared=+100000000.0; // increase distance to 200 meters
			bForceNetUpdate=true;
			NetUpdateFrequency=10;
			bNetDirty = true;
			TriggeredBy = P;

	        if ( PrimeSound != none )
		        PlayAkEvent(PrimeSound);

		    ClearTimer('CheckTripwire');
		}
	}
}

// Helpers for TripwireProximityDetector.uc

function StartCheckingTripwire()
{
	SetTimer(0.05, true, 'CheckTripwire');
}

function StopCheckingTripwire()
{
	ClearTimer('CheckTripwire');
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	// Do nothing. The parent class will set this off like a landmine otherwise
}

defaultproperties
{
	Damage=200
	DamageRadius=600
	MomentumTransfer=0
	ExplosionSound=AkEvent'WW_EXP_M34WP.Play_EXP_M34WP_Explosion'
	MyExplosionSound=AkEvent'WW_EXP_M34WP.Play_EXP_M34WP_Explosion'
	MyExplosionMediumSound=AkEvent'WW_EXP_M34WP.Play_EXP_M34WP_Explosion'
	MyDamageType=class'RODmgType_M34Grenade'
//for da wp damage
FumeDamageType=class'RODmgType_WhitePhosphorusFumes'
	ContinuousDamage=100//40
	IncDamageRadius=400 //200
	MaxIncDamageRadius=500 //300
	RadiusGrowFactor=1.0//1.1
	bAlwaysRelevant=true
	bNetTemporary=false



	PrimeSound=AkEvent'WW_EXP_Shared.Play_Trap_Trip'
	DisarmSound=AkEvent'WW_EXP_Shared.Play_Trap_Disarm'

	ProjExplosionTemplate=ParticleSystem'FX_VN_Phosphor.Explosions.FX_VN_Phosphorus_Grenade'

		bProjTarget=true		// should detonate when the charge is hit
	bDamageTriggers=true
	bVehicleTriggers=true

	Begin Object Name=CollisionCylinder
		CollisionRadius=2.3
		CollisionHeight=3
		CollideActors=True
		AlwaysLoadOnClient=True
		AlwaysLoadOnServer=True
		Translation=(Y=-2,Z=-0.5)
	End Object

	/*Begin Object Name=ThowableMeshComponent
		SkeletalMesh=SkeletalMesh'WP_RS_3rd_Projectiles.Mesh.Type91_Grenade_Projectile'
		bHasPhysicsAssetInstance=false
		Translation=(X=-4.2,Y=1.4,Z=-2.7) //Z=-3.2
		Rotation=(Pitch=910, Yaw=0, Roll=3004)
	End Object*/

	Begin Object Class=DynamicLightEnvironmentComponent Name=TrapLightEnvironment
		bIsCharacterLightEnvironment=TRUE
		bDynamic=false
	End Object
	Components.Add(TrapLightEnvironment)

	Begin Object Class=StaticMeshComponent Name=TrapMeshComponent
		CollideActors=false
		BlockActors=false
		BlockZeroExtent=false
		BlockNonZeroExtent=false
		BlockRigidBody=false
		RBChannel=RBCC_Nothing
		StaticMesh=StaticMesh'WP_VN_VC_Tripwire_Trap.Mesh.BoobyTrapMarker_02'
		Translation=(Z=-21)
		LightEnvironment=TrapLightEnvironment
		MaxDrawDistance=2500
	End Object
	Components.Add(TrapMeshComponent)
	TripwireTrapStaticMeshComp=TrapMeshComponent

	TacticalIcon=Texture2D'VN_UI_Textures.HUD.DeathMessage.UI_Kill_Icon_Tripwire'

	DisarmAllowedBy=EPTD_EnemyAndOwner

	DecalHeight=450
	DecalWidth=450

	ShockwaveDecal = MaterialInstanceTimeVarying'FX_VN_Weapons.Materials.D_ShockwaveAndShadow_Grenade_MITV'
}
