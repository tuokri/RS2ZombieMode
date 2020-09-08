class ZMWeapAttach_Katana extends ROMeleeWeaponAttachment;

DefaultProperties
{
	//CarrySocketName=WeaponSling // Add a socket to carry this weapon on the hip?
	ThirdPersonHandsAnim=M1939_Grenade_Handpose
	IKProfileName=F1

	// Weapon SkeletalMesh
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_RS_3rd_Master.Mesh.Katana_3rd_Master'
		CullDistance=5000
	End Object

	WeaponClass=class'ZMWeap_Katana'

	// ROPawn weapon specific animations
	CHR_AnimSet=AnimSet'CHR_RS_Playeranim_Master.Weapons.CHR_Katana'

	// Player animations - Weapon Actions
	HolsterWeaponAnim=Katana_Putaway
	EquipWeaponAnim=Katana_pullout
	EquipWeaponIronAnim=Katana_pullout

	// Melee Attacks: Bash or stab is randomly picked to add variety to the sword attacks
	MeleeBash1Anim=Katana_Attack_1
    MeleeBash1Anim_CH=CH_Katana_Attack_1
    MeleeStabAnim=Katana_Attack_2
	MeleeStabAnim_CH=CH_Katana_Attack_2
	MeleeStabAnim_Prone=Prone_Katana_Attack_Stab
	// Melee Charge Attacks
	MeleeBashChargeAnim=Katana_Attack_Hard
	MeleeBashChargeAnim_CH=CH_Katana_Attack_Hard
	MeleeStabChargeAnim=Katana_Attack_Hard
	MeleeStabChargeAnim_CH=CH_Katana_Attack_Hard

}
