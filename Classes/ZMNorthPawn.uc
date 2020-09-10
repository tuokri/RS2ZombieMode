class ZMNorthPawn extends RONorthPawn;

simulated event PreBeginPlay()
{
    PawnHandlerClass = class'ZMPawnHandler';

    super.PreBeginPlay();
}

simulated function SpawnBomberBurningEffects()
{
    local int BoneIndex;

    if( PlayerTorsoBurnTemplate != None && PlayerTorsoBurnEffectPSC == none)
    {
        PlayerTorsoBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerTorsoBurnTemplate);
        PlayerTorsoBurnEffectPSC.SetAbsolute(false, false, false);
        PlayerTorsoBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
        PlayerTorsoBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
        PlayerTorsoBurnEffectPSC.bUpdateComponentInTick = false;
        Mesh.AttachComponentToSocket(PlayerTorsoBurnEffectPSC,TorsoSocketName);
    }

    if( PlayerArmBurnTemplate != none && PlayerLArmBurnEffectPSC == none)
    {
        BoneIndex = mesh.MatchRefBone(Gore_LeftHand.ShrinkBones[0]);

        if( BoneIndex != -1 && !mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerLArmBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerArmBurnTemplate);
            PlayerLArmBurnEffectPSC.SetAbsolute(false, false, false);
            PlayerLArmBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerLArmBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerLArmBurnEffectPSC.bUpdateComponentInTick = false;
            Mesh.AttachComponent(PlayerLArmBurnEffectPSC,Gore_LeftHand.ShrinkBones[0]);
        }

        BoneIndex = mesh.MatchRefBone(Gore_RightHand.ShrinkBones[0]);

        if( BoneIndex != -1 && !mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerRArmBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerArmBurnTemplate);
            PlayerRArmBurnEffectPSC.SetAbsolute(false, false, false);
            PlayerRArmBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerRArmBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerRArmBurnEffectPSC.bUpdateComponentInTick = false;
            Mesh.AttachComponent(PlayerRArmBurnEffectPSC,Gore_RightHand.ShrinkBones[0]);
        }
    }

    if( PlayerLegBurnTemplate != None && PlayerLLegBurnEffectPSC == none)
    {
        BoneIndex = mesh.MatchRefBone(Gore_LeftLeg.ShrinkBones[0]);

        if( BoneIndex != -1 && !mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerLLegBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerLegBurnTemplate);
            PlayerLLegBurnEffectPSC.SetAbsolute(false, false, false);
            PlayerLLegBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerLLegBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerLLegBurnEffectPSC.bUpdateComponentInTick = false;
            Mesh.AttachComponent(PlayerLLegBurnEffectPSC,Gore_LeftLeg.ShrinkBones[0]);
        }

        BoneIndex = mesh.MatchRefBone(Gore_RightLeg.ShrinkBones[0]);

        if( BoneIndex != -1 && !mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerRLegBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerLegBurnTemplate);
            PlayerRLegBurnEffectPSC.SetAbsolute(false, false, false);
            PlayerRLegBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerRLegBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerRLegBurnEffectPSC.bUpdateComponentInTick = false;
            Mesh.AttachComponent(PlayerRLegBurnEffectPSC,Gore_RightLeg.ShrinkBones[0]);
        }
    }
}

DefaultProperties
{
    LegInjuryLength=0.05

    bCanPickupInventory=False
    bCanResupply=False
}
