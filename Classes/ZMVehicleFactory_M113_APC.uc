class ZMVehicleFactory_M113_APC extends ROTransportVehicleFactory;

defaultproperties
{
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_VN_Drivable_M113_APC.Mesh.US_M113_Rig_Master'
		Translation=(X=0.0,Y=0.0,Z=0.0)
	End Object

	Components.Remove(Sprite)

	Begin Object Name=CollisionCylinder
		CollisionHeight=+60.0
		CollisionRadius=+260.0
		Translation=(X=0.0,Y=0.0,Z=0.0)
	End Object

	VehicleClass=class'ZMVehicle_M113_APC_Content'
	EnemyVehicleClass=class'ZMVehicle_M113_APC_Content'
	DrawScale=1.0
}
