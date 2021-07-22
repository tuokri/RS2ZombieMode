//=============================================================================
// Willy Pete Tripwire Trap
//=============================================================================
// Trap for south side to kill zombies
//=============================================================================
// Zombie mode for Rising Storm 2: Vietnam
// Authored by adriaN$t3@m
//=============================================================================

class ZMWeap_WPTripwireTrap extends ZMWeap_TripwireTrap;

defaultproperties
{
	WeaponContentClass(0)"ZombieMode.ZMWeap_WPTripwireTrap_Content"

	RoleSelectionImage(0)=Texture2D'VN_UI_Textures.WeaponTex.VN_Weap_TripwireTrap'

	TeamIndex=`ALLIES_TEAM_INDEX
	WeaponClassType=ROWCT_BoobyTrap

	InvIndex=`ROII_TripwireTrap // TODO: Give me a new index so I am unique?
	InventoryWeight=0

	AmmoClass=class'ZMAmmo_TripwireTrap'
	//TrapClass=class'TripwireTrap'
	TrapClass=class'ZMWeap_WPTripwireTrapExp'
	TrapStakeClass=class'TripwireTrapStake'

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
