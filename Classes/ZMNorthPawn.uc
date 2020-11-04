class ZMNorthPawn extends RONorthPawn;

// Banzai variables.
var bool    bInBanzai;
var byte    NumberOfBanzaiChargers;
var bool    bDebugBanzai;               // If True, make all Japanese always in banzai and show their banzai radius.
var int     BanzaiRadius;               // The range at which a banzai charge is effective.
var byte    BanzaiLegDamage;            // If your legs are damaged while in banzai, apply negative effects when you get out of banzai.
var float   BanzaiKatanaModifier;       // A modifier that increases your radius if you have a katana out.
var float   BanzaiStaminaModifier;      // A modifier that slows your stamina loss rate while in banzai.
var float   BanzaiDamageModifier;       // A modifier that reduces damage to non-critical areas while in banzai.
var bool    bOldBanzai;                 // Banzai status in a previous tick.
var bool    bTerrorSuppressed;
var bool    bCanBanzaiCharge;

var ParticleSystemComponent PlayerFlamerTorsoBurnEffectPSC;
var ParticleSystemComponent PlayerFlamerLArmBurnEffectPSC;
var ParticleSystemComponent PlayerFlamerRArmBurnEffectPSC;
var ParticleSystemComponent PlayerFlamerLLegBurnEffectPSC;
var ParticleSystemComponent PlayerFlamerRLegBurnEffectPSC;
var ParticleSystem          PlayerFlamerTorsoBurnTemplate;
var ParticleSystem          PlayerFlamerArmBurnTemplate;
var ParticleSystem          PlayerFlamerLegBurnTemplate;

// var ParticleSystem EyeFlareTemplate;

var AudioComponent BanzaiAudio;
var repnotify bool bBanzaiFlag;

var float BurnGlowDeltaTime;
var float BurnGlowDeltaTimeUpdate;
var float BurnGlowStep;

var repnotify bool bShowFlamerBurningEffects;


replication
{
    if (Role == ROLE_Authority && bNetDirty && bNetOwner)
        bTerrorSuppressed;

    if (Role == ROLE_Authority && bNetDirty)
        bInBanzai, bShowFlamerBurningEffects;

    if (Role == ROLE_Authority && bNetDirty && bNetOwner)
        NumberOfBanzaiChargers;

    if (bNetDirty)
        bBanzaiFlag;
}

simulated event ReplicatedEvent(Name VarName)
{
    super.ReplicatedEvent(VarName);

    if (VarName == 'bBanzaiFlag')
    {
        CustomPlaySound(bBanzaiFlag);
    }
    else if (VarName == 'bShowFlamerBurningEffects')
    {
        SpawnFlamerBurningEffects();
    }
}

simulated function CustomPlaySound(bool bShouldPlayAudio)
{
    /*
    `zmlog("CustomPlaySound(): bShouldPlayAudio=" $ bShouldPlayAudio
        $ ", Vol=" $ GetSFXVolumeSetting(), 'Debug');
    */

    if (bShouldPlayAudio)
    {
        /*
        if (ZMPlayerController(Controller) != None)
        {
            BanzaiAudio.VolumeMultiplier = ZMPlayerController(Controller).GetSFXVolumeSetting();
        }
        */
        BanzaiAudio.Play();
    }
    /*
    else
    {
        BanzaiAudio.FadeOut(0.3, 0.0);
    }
    */
}

simulated event PreBeginPlay()
{
    PawnHandlerClass = class'ZMPawnHandler';

    super.PreBeginPlay();

    // ZMPlayerController(Controller).GetSFXVolumeSetting();
}

/*
simulated event PostBeginPlay()
{
    super.PostBeginPlay();

    local vector EyeLoc;
    local rotator EyeRot;
    local ParticleSystemComponent Emitter;
    local EmitterSpawnable Emitter2;

    // TODO: EYE GLOW?
    GetActorEyesViewPoint(EyeLoc, EyeRot);

    Emitter = new(self) class'ParticleSystemComponent';
    AttachComponent(Emitter);
    Emitter.bAutoActivate = True;
    Emitter.SetTemplate(EyeFlareTemplate);
    `zmlog("Emitter=" $ Emitter, 'Debug');
}
*/

/*
simulated event PostBeginPlay()
{
    local ZMPlayerController ZMPC;

    super.PostBeginPlay();

    ZMPC = ZMPlayerController(Controller);
    ZMPC.myROHUD.OverheadMapWidget.Initialize(ZMPC);
}
*/

simulated event Tick(float DeltaTime)
{
    super.Tick(DeltaTime);

    if (bCanBanzaiCharge)
    {
        UpdateBanzaiStatus();
    }
}

simulated function SpawnBomberBurningEffects()
{
    local int BoneIndex;

    ClearTimer('BurnGlowLoop');
    BurnGlowDeltaTime = 0.0;
    BurnGlowDeltaTimeUpdate = 0.1;

    if( PlayerTorsoBurnTemplate != None && PlayerTorsoBurnEffectPSC == None)
    {
        PlayerTorsoBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerTorsoBurnTemplate);
        PlayerTorsoBurnEffectPSC.SetAbsolute(False, False, False);
        PlayerTorsoBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
        PlayerTorsoBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
        PlayerTorsoBurnEffectPSC.bUpdateComponentInTick = False;
        Mesh.AttachComponentToSocket(PlayerTorsoBurnEffectPSC, TorsoSocketName);
    }

    if( PlayerArmBurnTemplate != None && PlayerLArmBurnEffectPSC == None)
    {
        BoneIndex = Mesh.MatchRefBone(Gore_LeftHand.ShrinkBones[0]);

        if( BoneIndex != -1 && !Mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerLArmBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerArmBurnTemplate);
            PlayerLArmBurnEffectPSC.SetAbsolute(False, False, False);
            PlayerLArmBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerLArmBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerLArmBurnEffectPSC.bUpdateComponentInTick = False;
            Mesh.AttachComponent(PlayerLArmBurnEffectPSC, Gore_LeftHand.ShrinkBones[0]);
        }

        BoneIndex = Mesh.MatchRefBone(Gore_RightHand.ShrinkBones[0]);

        if( BoneIndex != -1 && !Mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerRArmBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerArmBurnTemplate);
            PlayerRArmBurnEffectPSC.SetAbsolute(False, False, False);
            PlayerRArmBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerRArmBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerRArmBurnEffectPSC.bUpdateComponentInTick = False;
            Mesh.AttachComponent(PlayerRArmBurnEffectPSC, Gore_RightHand.ShrinkBones[0]);
        }
    }

    if( PlayerLegBurnTemplate != None && PlayerLLegBurnEffectPSC == None)
    {
        BoneIndex = Mesh.MatchRefBone(Gore_LeftLeg.ShrinkBones[0]);

        if( BoneIndex != -1 && !Mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerLLegBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerLegBurnTemplate);
            PlayerLLegBurnEffectPSC.SetAbsolute(False, False, False);
            PlayerLLegBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerLLegBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerLLegBurnEffectPSC.bUpdateComponentInTick = False;
            Mesh.AttachComponent(PlayerLLegBurnEffectPSC, Gore_LeftLeg.ShrinkBones[0]);
        }

        BoneIndex = Mesh.MatchRefBone(Gore_RightLeg.ShrinkBones[0]);

        if( BoneIndex != -1 && !Mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerRLegBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerLegBurnTemplate);
            PlayerRLegBurnEffectPSC.SetAbsolute(False, False, False);
            PlayerRLegBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerRLegBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerRLegBurnEffectPSC.bUpdateComponentInTick = False;
            Mesh.AttachComponent(PlayerRLegBurnEffectPSC, Gore_RightLeg.ShrinkBones[0]);
        }
    }

    SetTimer(BurnGlowStep, True, 'BurnGlowLoop');
}

simulated function SpawnFlamerBurningEffects()
{
    local int BoneIndex;
    local int i;
    local LinearColor GreenFire;

    // Perhaps unnecessary safety check?
    if (!bShowFlamerBurningEffects)
    {
        return;
    }

    ClearTimer('BurnGlowLoop');
    BurnGlowDeltaTime = 0.0;
    BurnGlowDeltaTimeUpdate = 0.1;

    GreenFire.R = 0.049506;
    GreenFire.G = 1.0;
    GreenFire.B = 0.0;
    GreenFire.A = 1.0;

    HeadAndArmsMIC.SetVectorParameterValue('FireColour', GreenFire);
    HeadgearMIC.SetVectorParameterValue('FireColour', GreenFire);

    for (i = 0; i < MeshMICs.Length; i++)
    {
        MeshMICs[i].SetVectorParameterValue('FireColour', GreenFire);
    }

    if( PlayerFlamerTorsoBurnTemplate != None && PlayerFlamerTorsoBurnEffectPSC == None)
    {
        PlayerFlamerTorsoBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerFlamerTorsoBurnTemplate);
        PlayerFlamerTorsoBurnEffectPSC.SetAbsolute(False, False, False);
        PlayerFlamerTorsoBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
        PlayerFlamerTorsoBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
        PlayerFlamerTorsoBurnEffectPSC.bUpdateComponentInTick = False;
        Mesh.AttachComponentToSocket(PlayerFlamerTorsoBurnEffectPSC, TorsoSocketName);
    }

    if( PlayerFlamerArmBurnTemplate != None && PlayerFlamerLArmBurnEffectPSC == None)
    {
        BoneIndex = Mesh.MatchRefBone(Gore_LeftHand.ShrinkBones[0]);

        if( BoneIndex != -1 && !Mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerFlamerLArmBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerFlamerArmBurnTemplate);
            PlayerFlamerLArmBurnEffectPSC.SetAbsolute(False, False, False);
            PlayerFlamerLArmBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerFlamerLArmBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerFlamerLArmBurnEffectPSC.bUpdateComponentInTick = False;
            Mesh.AttachComponent(PlayerFlamerLArmBurnEffectPSC, Gore_LeftHand.ShrinkBones[0]);
        }

        BoneIndex = Mesh.MatchRefBone(Gore_RightHand.ShrinkBones[0]);

        if( BoneIndex != -1 && !Mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerFlamerRArmBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerFlamerArmBurnTemplate);
            PlayerFlamerRArmBurnEffectPSC.SetAbsolute(False, False, False);
            PlayerFlamerRArmBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerFlamerRArmBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerFlamerRArmBurnEffectPSC.bUpdateComponentInTick = False;
            Mesh.AttachComponent(PlayerFlamerRArmBurnEffectPSC, Gore_RightHand.ShrinkBones[0]);
        }
    }

    if( PlayerFlamerLegBurnTemplate != None && PlayerFlamerLLegBurnEffectPSC == None)
    {
        BoneIndex = Mesh.MatchRefBone(Gore_LeftLeg.ShrinkBones[0]);

        if( BoneIndex != -1 && !Mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerFlamerLLegBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerFlamerLegBurnTemplate);
            PlayerFlamerLLegBurnEffectPSC.SetAbsolute(False, False, False);
            PlayerFlamerLLegBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerFlamerLLegBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerFlamerLLegBurnEffectPSC.bUpdateComponentInTick = False;
            Mesh.AttachComponent(PlayerFlamerLLegBurnEffectPSC, Gore_LeftLeg.ShrinkBones[0]);
        }

        BoneIndex = Mesh.MatchRefBone(Gore_RightLeg.ShrinkBones[0]);

        if( BoneIndex != -1 && !Mesh.IsBoneHidden(BoneIndex) )
        {
            PlayerFlamerRLegBurnEffectPSC = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(PlayerFlamerLegBurnTemplate);
            PlayerFlamerRLegBurnEffectPSC.SetAbsolute(False, False, False);
            PlayerFlamerRLegBurnEffectPSC.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
            PlayerFlamerRLegBurnEffectPSC.OnSystemFinished = MyOnParticleSystemFinished;
            PlayerFlamerRLegBurnEffectPSC.bUpdateComponentInTick = False;
            Mesh.AttachComponent(PlayerFlamerRLegBurnEffectPSC, Gore_RightLeg.ShrinkBones[0]);
        }
    }

    SetTimer(BurnGlowStep, True, 'BurnGlowLoop');
}

// "Sinusoid" delta time loop.
simulated function BurnGlowLoop()
{
    BurnGlowDeltaTime += BurnGlowDeltaTimeUpdate;
    BurnGlowDeltaTime = FClamp(BurnGlowDeltaTime, 0.1, 1.0);

    if (BurnGlowDeltaTime >= 1.0)
    {
        BurnGlowDeltaTimeUpdate = -BurnGlowStep;
    }
    else if (BurnGlowDeltaTime <= 0.1)
    {
        BurnGlowDeltaTimeUpdate = BurnGlowStep;
    }

    UpdateBurnMaterial(BurnGlowDeltaTimeUpdate);
    // `zmlog("BurnGlowDeltaTime       = " $ BurnGlowDeltaTime, 'Debug');
    // `zmlog("BurnGlowDeltaTimeUpdate = " $ BurnGlowDeltaTimeUpdate, 'Debug');
    // `zmlog("BurnProgress            = " $ BurnProgress, 'Debug');
    // `zmlog("GlowProgress            = " $ GlowProgress, 'Debug');
}

////////////////////////////////////////////////////////////////////////////////
// Banzai Functions
////////////////////////////////////////////////////////////////////////////////

/** Check if we can enter Banzai. */
function UpdateBanzaiStatus()
{
    local ROWeapon ROW;
    local ZMPlayerController ZMPC;
    local bool bBanzaiReady;

    if (WorldInfo.NetMode != NM_DedicatedServer && bOldBanzai != bInBanzai)
    {
        // If we just started banzaiing, turn off hints.
        if (bInBanzai)
        {
            // `zmlog("Pawn=" $ self $ ", bInBanzai=" $ bInBanzai);

            ZMPC = ZMPlayerController(Controller);
            if (ZMPC != None)
            {
                // TODO:
                // ZMPC.DisableHint(ROHTimed_Banzai, False);
                // ZMPC.TriggerHint(ROHTrig_BanzaiEffects);

                if (ZMWeap_Katana(Weapon) != None)
                {
                    ZMPC.DisableHint(ZMHTrig_Katana, True);
                }
            }
        }

        bOldBanzai = bInBanzai;
    }

    // Only do banzai calcs on the server.
    if( Role < ROLE_Authority )
    {
        return;
    }

    if (bIsSprinting && !bInHeavyWeaponAction)
    {
        ROW = ROWeapon(Weapon);

        // Banzai is katana only for now.
        if (ROW != None && ROW.bMeleeAttackReady && ZMWeap_Katana(ROW) != None)
        {
            // `zmlog("bBanzaiReady = True", 'Debug');
            bBanzaiReady = True;
        }
    }

    // Enter banzai if we are sprinting and holding melee.
    if (bBanzaiReady)
    {
        if (!bInBanzai )
        {
            SetTimer(0.5, True, 'PerformBanzai');
            bInBanzai = True;
        }
    }
    // If we're not banzai ready, stop.
    else if (bInBanzai)
    {
        // If you took leg damage while in banzai, apply the effects now that you are no longer charging.
        if (BanzaiLegDamage != 0)
        {
            BanzaiLegDamage = 0;
            LegInjuryTime = WorldInfo.TimeSeconds;
            LegInjuryAmount = 255;
        }

        // `zmlog("Clearing 'PerformBanzai' Timer", 'Debug');
        ClearTimer('PerformBanzai');
        bInBanzai = False;
    }
}

/** Called on a looping timer. */
function PerformBanzai()
{
    // `zmlog("PerformBanzai(): Pawn=" $ self, 'Debug');

    HandleBanzaiYelling();
    CheckBanzaiRadius();
}

/** Makes a banzai charger yell "BAAANZAIIIIII" */
function HandleBanzaiYelling()
{
    local float EventTime;

    if (WorldInfo.TimeSeconds - LastSprintChargeVoiceTime > 3.0)
    {
        EventTime = WorldInfo.TimeSeconds + RandRange(0, int(NumberOfBanzaiChargers)) * FRand() * 0.05;
        // `zmlog("Banzai EventTime=" $ EventTime, 'Debug');

        bBanzaiFlag = True;
        SetTimer(3.0, False, 'BanzaiFlagOff'); // Allows banzai sound effects to trigger again.

        /*
        if (ROGameInfo(WorldInfo.Game) != None)
        {
            ROGameInfo(WorldInfo.Game).AddDelayedBattleChatterEvent(EventTime, self, `VOICECOM_Charging);
        }
        */

        LastSprintChargeVoiceTime = EventTime;
    }
}

function BanzaiFlagOff()
{
    bBanzaiFlag = False;
}

// Checks for any other Japanese (zombie) players who are charging and suppresses nearby Americans.
function CheckBanzaiRadius()
{
    local bool bKatanaInGroup;
    local int TeamNum;
    local ROPawn PawnInRadius;
    local ZMSouthPawn SouthPawnInRadius;
    local ZMNorthPawn NorthPawnInRadius;

    NumberOfBanzaiChargers = 0;

    // Get all Soldiers in your radius.
    foreach CollidingActors(class'ROPawn', PawnInRadius, BanzaiRadius, Location)
    {
        if (PawnInRadius.Health <= 0)
        {
            continue;
        }

        TeamNum = PawnInRadius.GetTeamNum();

        if (TeamNum == `AXIS_TEAM_INDEX)
        {
            NorthPawnInRadius = ZMNorthPawn(PawnInRadius);

            if (NorthPawnInRadius != None && NorthPawnInRadius.bCanBanzaiCharge)
            {
                // We allow a max of 5 banzai charger in this group.
                if (NumberOfBanzaiChargers >= 5)
                {
                    continue;
                }

                if (NorthPawnInRadius.bInBanzai)
                {
                    // Another Japanese (zombie) soldier is performing a banzai charge in your radius.
                    NumberOfBanzaiChargers += 1;

                    // Check if any Japanese (zombie) soldiers are wielding a katana
                    if (!bKatanaInGroup && ZMWeap_Katana(PawnInRadius.Weapon) != None)
                    {
                        bKatanaInGroup = True;
                    }
                }
            }
        }
        else if (TeamNum == `ALLIES_TEAM_INDEX)
        {
            SouthPawnInRadius = ZMSouthPawn(PawnInRadius);
            if (SouthPawnInRadius == None)
            {
                continue;
            }

            // `zmlog("Banzai suppression candidate=" $ SouthPawnInRadius, 'Debug');

            // Only suppress if you have a line of sight with an Americans head.
            if (FastTrace(GetPawnViewLocation(), SouthPawnInRadius.GetPawnViewLocation(), , True))
            {
                SouthPawnInRadius.bTerrorSuppressed = True;
                SouthPawnInRadius.SetTimer(1.0, False, 'DeactivateSuppressedByBanzai');
                SouthPawnInRadius.HandleSuppressionEvent(40.0, SET_SprintCharge);
            }
        }
    }

    // Someone in my radius is wielding a katana, increase the banzai radius by a percentage.
    if (bKatanaInGroup)
    {
        BanzaiRadius = default.BanzaiRadius * NumberOfBanzaiChargers * BanzaiKatanaModifier;
    }
    else
    {
        BanzaiRadius = default.BanzaiRadius * NumberOfBanzaiChargers;
    }
}

// spawnbomberbomb

DefaultProperties
{
    // Initially False.
    bShowFlamerBurningEffects=False

    LegInjuryLength=0.05

    bCanPickupInventory=False
    bCanResupply=False

    bCanBanzaiCharge=True
    BanzaiRadius=250
    BanzaiKatanaModifier=1.2
    BanzaiStaminaModifier=0.75
    BanzaiDamageModifier=0.25

    // EyeFlareTemplate=ParticleSystem'eyeflaretest.FX_VN_Flare_2'

    Begin Object Class=AudioComponent Name=BanzaiAudioComponent
        SoundCue=SoundCue'ZM_AUD_RS_VOX_Chatter_JapNat.Infantry.ACT_INF_Charging_NOR_Cue_01'
        VolumeMultiplier=0.3
    End Object
    BanzaiAudio=BanzaiAudioComponent
    Components.Add(BanzaiAudioComponent)

    BreathStaminaExhaustedLimit = 0.2;
    BreathStaminaStandardLimit = 0.5;
    STAMINA_STD_REGEN_RATE = 5.0;
    STAMINA_FRESH_REGEN_RATE = 6.0;
    STAMINA_EXHAUSTED_REGEN_RATE = 3.0;
    STAMINA_DRAIN_JUMP = 8.0;
    STAMINA_JUMP_SPEED_PENALTY = 0.2;
    STAMINA_STANDSTILL_REGEN_MOD = 3.0;

    BurnGlowStep=0.05

    PlayerFlamerTorsoBurnTemplate=ParticleSystem'ZM_FX_RS_Fire.Emitters.Fire_Player_Torso_NEW'
    PlayerFlamerArmBurnTemplate=ParticleSystem'ZM_FX_RS_Fire.Emitters.Fire_Player_Arms_NEW'
    PlayerFlamerLegBurnTemplate=ParticleSystem'ZM_FX_RS_Fire.Emitters.Fire_Player_Legs_NEW'
}
