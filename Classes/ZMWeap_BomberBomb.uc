// Detonator / clacker.
class ZMWeap_BomberBomb extends ROExplosiveWeapon;

/*
var(Animations) name  ClackerIdleAnim;
var(Animations) name  ClackerFireAnim;
var(Animations) name  ClackerMisfireAnim;
var(Animations) name  ClackerPutDownAnim;
var(Animations) name  ClackerEquipAnim;
var(Animations) name  ClackerEquipArmAnim;
var(Animations) name  ClackerDownAnim;
var(Animations) name  ClackerUpAnim;
var(Animations) name  ClackerCrawlingAnim;
var(Animations) name  ClackerCrawlStartAnim;
var(Animations) name  ClackerCrawlEndAnim;
var(Animations) name  ClackerSprintStartAnim;
var(Animations) name  ClackerSprintLoopAnim;
var(Animations) name  ClackerSprintEndAnim;
var(Animations) name  ClackerMantleOverAnim;
var(Animations) name  ClackerSpotEnemyAnim;
*/

var name ChargeBoneName;

DefaultProperties
{
    WeaponContentClass(0)="ZombieMode.ZMWeap_BomberBomb_Content"
    RoleSelectionImage(0)=Texture2D'VN_UI_Textures.WeaponTex.US_Weap_C4'
    InvIndex=`ROII_C4_Explosive
    TeamIndex=`AXIS_TEAM_INDEX
    InventoryWeight=0

    AmmoClass=class'ZMAmmo_BomberBomb'

    ChargeBoneName=C4_Explosive

    MaxAmmoCount=1
    InitialNumPrimaryMags=1

    EquipTime=0.33
    PutDownTime=0.33

    WeaponIdleAnims[0]=Clacker_idle
    WeaponIdleAnims[1]=Clacker_idle
    WeaponPutDownAnim=Clacker_Putaway
    WeaponEquipAnim=Clacker_Pullout
    WeaponDownAnim=Clacker_Down
    WeaponUpAnim=Clacker_Up
    WeaponCrawlingAnims[0]=Clacker_CrawlF
    WeaponCrawlStartAnim=Clacker_Crawl_into
    WeaponCrawlEndAnim=Clacker_Crawl_out
    WeaponSprintStartAnim=Clacker_sprint_into
    WeaponSprintLoopAnim=Clacker_Sprint
    WeaponSprintEndAnim=Clacker_sprint_out
    WeaponMantleOverAnim=Clacker_Mantle

    WeaponBF_Rest2LeftReady=ClackerIdleAnim
    WeaponBF_Rest2RightReady=ClackerIdleAnim
    WeaponBF_Rest2UpReady=ClackerIdleAnim
    WeaponBF_LeftReady2Rest=ClackerIdleAnim
    WeaponBF_RightReady2Rest=ClackerIdleAnim
    WeaponBF_UpReady2Rest=ClackerIdleAnim
    WeaponBF_LeftReady2Up=ClackerIdleAnim
    WeaponBF_LeftReady2Right=ClackerIdleAnim
    WeaponBF_UpReady2Left=ClackerIdleAnim
    WeaponBF_UpReady2Right=ClackerIdleAnim
    WeaponBF_RightReady2Up=ClackerIdleAnim
    WeaponBF_RightReady2Left=ClackerIdleAnim
    WeaponBF_LeftReady2Idle=ClackerIdleAnim
    WeaponBF_RightReady2Idle=ClackerIdleAnim
    WeaponBF_UpReady2Idle=ClackerIdleAnim
    WeaponBF_Idle2UpReady=ClackerIdleAnim
    WeaponBF_Idle2LeftReady=ClackerIdleAnim
    WeaponBF_Idle2RightReady=ClackerIdleAnim

    /*
    ClackerIdleAnim=Clacker_idle
    ClackerFireAnim=Clacker_Detonate
    ClackerMisfireAnim=Clacker_Misfire
    ClackerPutDownAnim=Clacker_Putaway
    ClackerEquipAnim=Clacker_Pullout
    ClackerEquipArmAnim=Clacker_Pullout
    ClackerDownAnim=Clacker_Down
    ClackerUpAnim=Clacker_Up

    // Clacker Prone Crawl
    ClackerCrawlingAnim=Clacker_CrawlF
    ClackerCrawlStartAnim=Clacker_Crawl_into
    ClackerCrawlEndAnim=Clacker_Crawl_out

    // Clacker Sprinting
    ClackerSprintStartAnim=Clacker_sprint_into
    ClackerSprintLoopAnim=Clacker_Sprint
    ClackerSprintEndAnim=Clacker_sprint_out

    // Clacker Mantling
    ClackerMantleOverAnim=Clacker_Mantle

    // Enemy Spotting
    ClackerSpotEnemyAnim=Clacker_SpotEnemy
    */
}
