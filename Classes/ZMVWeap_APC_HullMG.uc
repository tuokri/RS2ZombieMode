class ZMVWeap_APC_HullMG extends ROVWeap_Transport_HullMG
	abstract
	HideDropDown;

defaultproperties
{
	WeaponContentClass(0)="ZombieMode.ZMVWeap_APC_HullMG_Content"
	SeatIndex=1
	PlayerIronSightFOV=55 // No real zoom

	// MAIN FIREMODE
	FiringStatesArray(0)=WeaponFiring
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponProjectiles(0)=class'M2Bullet'
	FireInterval(0)=+0.12
	FireCameraAnim(0)=CameraAnim'1stperson_Cameras.Anim.Camera_MG34_Shoot'
	Spread(0)=0.00025

	// AI
	AILongDistanceScale=1.25
	AIMediumDistanceScale=1.1
	AISpreadScale=200.0
	AISpreadNoSeeScale=2.0
	AISpreadNMEStillScale=0.5
	AISpreadNMESprintScale=1.5

	// ALT FIREMODE
	FiringStatesArray(ALTERNATE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTERNATE_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(ALTERNATE_FIREMODE)=class'M2Bullet'
	FireInterval(ALTERNATE_FIREMODE)=+0.075D
	FireCameraAnim(ALTERNATE_FIREMODE)=CameraAnim'1stperson_Cameras.Anim.Camera_MG34_Shoot'
	Spread(ALTERNATE_FIREMODE)=0.0007

	FireTriggerTags=(HTHullMG)
	AltFireTriggerTags=(HTHullMG)

	VehicleClass=class'ZMVehicle_M113_APC'

//	bRecommendSplashDamage=true
//	bInstantHit=false
//
//	Begin Object Class=ForceFeedbackWaveform Name=ForceFeedbackWaveformShooting1
//		Samples(0)=(LeftAmplitude=50,RightAmplitude=80,LeftFunction=WF_Constant,RightFunction=WF_Constant,Duration=0.200)
//	End Object
//	WeaponFireWaveForm=ForceFeedbackWaveformShooting1

	// Ammo
	AmmoClass=class'ZMAmmo_127x99_M2Belt_APC'
	MaxAmmoCount=550

	PenetrationDepth=23.5
	MaxPenetrationTests=3
	MaxNumPenetrations=2
}
