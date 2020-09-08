class PAPWeap_Katana_Level2 extends PAPWeap_Katana_Content;

DefaultProperties
{
	AttachmentClass=class'PicksAndPistols.PAPWeapAttach_Katana_Level2'

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'WP_RS_Jap_Katana.Mesh.JP_Katana_UPGD2'
		Materials(0)=MaterialInstanceConstant'WP_RS_Jap_Katana.MIC.Katana_lvl2_Mat'
	End Object

	// Pickup staticmesh
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_RS_3rd_Master.Mesh_UPGD.Katana_3rd_Lvl2'
	End Object
}
