class ZMPlayerController extends ROPlayerController
    config(Mutator_ZombieMode_Client);

var float NorthReinforcementDelayModifier;
var float SouthReinforcementDelayModifier;

var float   CachedSFXVolume;
var int     CachedSFXVolumeAge;
var int     CachedSFXVolumeMaxAge;

// Bomber bomb charges.
var array<ZMBomberBomb> BBCharges;
var int iPlantedBBChargeCount;


replication
{
    if (bNetOwner && Role == ROLE_Authority && bNetDirty)
        iPlantedBBChargeCount;
}

function PreBeginPlay()
{
    super.PreBeginPlay();

    if (WorldInfo.NetMode == NM_Standalone)
    {
        ReplicateModShit();
    }
}

simulated function float GetSFXVolumeSetting()
{
    local AudioDevice Audio;
    local float TimeSeconds;

    /* TODO: Do we need to run this on server?
    if (Role > ROLE_Authority)
    {
        return CachedSFXVolume;
    }
    */

    TimeSeconds = WorldInfo.TimeSeconds;
    if (TimeSeconds > (CachedSFXVolumeAge + CachedSFXVolumeMaxAge))
    {
        Audio = class'Engine'.static.GetAudioDevice();
        if (Audio != None)
        {
            CachedSFXVolume = Audio.AKSFXVolume * Audio.AKMasterVolume;
            CachedSFXVolumeAge = TimeSeconds;

            `zmlog("Audio.AKSFXVolume=    " $ Audio.AKSFXVolume);
            `zmlog("Audio.AKMasterVolume= " $ Audio.AKMasterVolume);

            `zmlog("Fetching SFX volume= " $ CachedSFXVolume $ ", WorldInfo.TimeSeconds="
                $ WorldInfo.TimeSeconds $ ", CachedSFXVolumeAge + CachedSFXVolumeMaxAge="
                $ CachedSFXVolumeAge + CachedSFXVolumeMaxAge, 'Debug');
        }
    }

    return CachedSFXVolume;
}

simulated function ReceivedGameClass(class<GameInfo> GameClass)
{
    super.ReceivedGameClass(GameClass);

    `zmlog("ZMPlayerController.ReceivedGameClass(), GameClass=" $ GameClass, 'Debug');

    if (WorldInfo.NetMode != NM_Standalone)
    {
        ReplicateModShit();
    }
}

/*
function float VerifyFloatModifierMin(Name ModifierName, float Modifier,
    float MinValue, float DefaultValue)
{
    if (Modifier < `NORTH_PAWN_MODIFIER_MIN)
    {
        `zmlog("WARNING: " $ ModifierName $ "(" $ Modifier $ ") is less than " $
            MinValue $ " using default value: " $ DefaultValue, 'Config');
        Modifier = DefaultValue;
    }
    return Modifier;
}
*/

/*
function VerifyConfig()
{
    NorthReinforcementDelayModifier = VerifyFloatModifierMin(
        Nameof(NorthReinforcementDelayModifier), NorthReinforcementDelayModifier,
        `REINFORCEMENT_DELAY_MODIFIER_MIN, `NORTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT);

    SouthReinforcementDelayModifier = VerifyFloatModifierMin(
        Nameof(SouthReinforcementDelayModifier), SouthReinforcementDelayModifier,
        `REINFORCEMENT_DELAY_MODIFIER_MIN, `SOUTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT);

    SaveConfig();
    `zmlog("Configuration verified", 'Config');
}
*/

simulated function ReplicateModShit()
{
    ReplaceRoles();
    OverrideMapInfo();
}

simulated function OverrideMapInfo()
{
    local ROMapInfo ROMI;

    ROMI = ROMapInfo(WorldInfo.GetMapInfo());

    ROMI.AxisReinforcementDelay16 *= NorthReinforcementDelayModifier;
    ROMI.AxisReinforcementDelay32 *= NorthReinforcementDelayModifier;
    ROMI.AxisReinforcementDelay64 *= NorthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay16 *= SouthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay32 *= SouthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay64 *= SouthReinforcementDelayModifier;

    `zmlog("AxisReinforcementDelay16=" $ ROMI.AxisReinforcementDelay16, 'Debug');
    `zmlog("AxisReinforcementDelay32=" $ ROMI.AxisReinforcementDelay32, 'Debug');
    `zmlog("AxisReinforcementDelay64=" $ ROMI.AxisReinforcementDelay64, 'Debug');
    `zmlog("AlliesReinforcementDelay16=" $ ROMI.AlliesReinforcementDelay16, 'Debug');
    `zmlog("AlliesReinforcementDelay32=" $ ROMI.AlliesReinforcementDelay32, 'Debug');
    `zmlog("AlliesReinforcementDelay64=" $ ROMI.AlliesReinforcementDelay64, 'Debug');

    ROMI.MinimumTimeDead = 0;
    ROMI.ScoutReconInterval = 0;
    ROMI.AerialReconInterval = 0;
    ROMI.DefendingTeam = DT_South;
    ROMI.DefendingTeam16 = DT_South;
    ROMI.DefendingTeam32 = DT_South;
    ROMI.DefendingTeam64 = DT_South;
    ROMI.AxisReinforcementCount16 *= 1.5;
    ROMI.AxisReinforcementCount32 *= 1.5;
    ROMI.AxisReinforcementCount64 *= 1.5;
    ROMI.EnhancedLogisticsLimit16 = 0;
    ROMI.EnhancedLogisticsLimit32 = 0;
    ROMI.EnhancedLogisticsLimit64 = 0;
    ROMI.NorthArtilleryStrikeLimit16 = 0;
    ROMI.NorthArtilleryStrikeLimit32 = 0;
    ROMI.NorthArtilleryStrikeLimit64 = 0;
    ROMI.AC47GunshipStrikeLimit16 = 0;
    ROMI.AC47GunshipStrikeLimit32 = 0;
    ROMI.AC47GunshipStrikeLimit64 = 0;
    ROMI.SouthArtilleryStrikeLimit16 = 0;
    ROMI.SouthArtilleryStrikeLimit32 = 0;
    ROMI.SouthArtilleryStrikeLimit64 = 0;
    ROMI.NapalmStrikeLimit16 = 0;
    ROMI.NapalmStrikeLimit32 = 0;
    ROMI.NapalmStrikeLimit64 = 0;
    ROMI.CarpetBomberStrikeLimit16 = 0;
    ROMI.CarpetBomberStrikeLimit32 = 0;
    ROMI.CarpetBomberStrikeLimit64 = 0;
    ROMI.AntiAirCooldown = 0;
    ROMI.InstantRespawnInterval = 60;
}

simulated function ReplaceRoles()
{
    local ROMapInfo ROMI;
    local RORoleCount RORC;

    ROMI = ROMapInfo(WorldInfo.GetMapInfo());

    ROMI.NorthernRoles.Remove(0, ROMI.NorthernRoles.Length);
    ROMI.SouthernRoles.Remove(0, ROMI.SouthernRoles.Length);

    ROMI.NorthernTeamLeader.RoleInfo = new class'ZMRoleInfoNorthernCommander';
    // ROMI.SouthernTeamLeader.RoleInfo = None;
    ROMI.SouthernTeamLeader.RoleInfo = new class'ZMRoleInfoSouthernCommander';

    RORC.RoleInfoClass = class'ZMRoleInfoNorthernZombie';
    RORC.Count = 255;
    ROMI.NorthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'ZMRoleInfoNorthernSmoker';
    RORC.Count = 6;
    ROMI.NorthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'ZMRoleInfoNorthernLeaper';
    RORC.Count = 8;
    ROMI.NorthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'ZMRoleInfoNorthernFlamer';
    RORC.Count = 2;
    ROMI.NorthernRoles.AddItem(RORC);

    /*
    RORC.RoleInfoClass = class'ZMRoleInfoNorthernBomber';
    RORC.Count = 4;
    ROMI.NorthernRoles.AddItem(RORC);
    */

    RORC.RoleInfoClass = class'ZMRoleInfoSouthernSurvivor';
    RORC.Count = 255;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'ZMRoleInfoSouthernFighter';
    RORC.Count = 3;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'ZMRoleInfoSouthernTrapper';
    RORC.Count = 4;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'ZMRoleInfoSouthernRifleman';
    RORC.Count = 6;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'ZMRoleInfoSouthernDemolitions';
    RORC.Count = 1;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'ZMRoleInfoSouthernBruiser';
    RORC.Count = 2;
    ROMI.SouthernRoles.AddItem(RORC);

    /*
    RORC.RoleInfoClass = class'ZMRoleInfoSouthernGunner';
    RORC.Count = 2;
    ROMI.SouthernRoles.AddItem(RORC);
    */
}

/*
reliable client function ClientTriggerMapBoundary()
{
    local ROPawn ROP;

    ROP = ROPawn(Pawn);

    // Zombies have no boundaries.
    if (ROP != None && ROP.GetTeamNum() == `AXIS_TEAM_INDEX)
    {
        `zmlog("ClientTriggerMapBoundary(): Ignore boundary for: " $ ROP, 'Boundary');
        ROP.VolumeKillTime = 999999;
    }
    else
    {
        TriggerHint(ROHTrig_MapBoundary);
    }
}
*/

/*
reliable client function ToggleMapBoundsSoundMode(bool bEnabled)
{
    local ROPawn ROP;

    ROP = ROPawn(Pawn);

    // Zombies have no boundaries.
    if (ROP != None && ROP.GetTeamNum() == `AXIS_TEAM_INDEX)
    {
        `zmlog("ToggleMapBoundsSoundMode(): Ignore boundary for: " $ ROP, 'Boundary');
        ROP.VolumeKillTime = 999999;
        bEnabled = False;
    }

    super.ToggleMapBoundsSoundMode(bEnabled);
}
*/

/*
reliable client event ReceiveLocalizedMessage(class<LocalMessage> Message, optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject)
{
    local ROPawn ROP;

    ROP = ROPawn(Pawn);

    // Zombies have no boundaries.
    if (ROP != None && ROP.GetTeamNum() == `AXIS_TEAM_INDEX && Switch == RORAMSG_MapBoundaryTouch)
    {
        `zmlog("ReceiveLocalizedMessage(): Ignore boundary for: " $ ROP, 'Boundary');
        ROP.VolumeKillTime = 999999;
    }
    else
    {
        super.ReceiveLocalizedMessage(Message, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
    }
}
*/

function InitialiseCCMs()
{
    local ROCharacterPreviewActor ROCPA, CPABoth;
    local ROCharCustMannequin TempCCM;

    if( WorldInfo.NetMode == NM_DedicatedServer )
        return;

    if( ROCCC == none )
    {
        ROCCC = Spawn(class'ROCharCustController');

        if( ROCCC != none )
            ROCCC.ROPCRef = self;
    }

    foreach WorldInfo.DynamicActors(class'ROCharacterPreviewActor', ROCPA)
    {
        if( ROCPA.OwningTeam == EOT_Both )
        {
            CPABoth = ROCPA;
        }
        else if( AllCCMs[ROCPA.OwningTeam] == none )
        {
            AllCCMs[ROCPA.OwningTeam] = Spawn(class'ZMCharCustMannequin', self,, ROCPA.Location, ROCPA.Rotation);
        }
    }

    if( AllCCMs[0] == none || AllCCMs[1] == none )
    {
        if( CPABoth != none )
            TempCCM = Spawn(class'ZMCharCustMannequin', self,, CPABoth.Location, CPABoth.Rotation);
        else
        {
            TempCCM = Spawn(class'ZMCharCustMannequin', self, , vect(0,0,100));
            `warn("Couldn't find an ZMCharCustMannequin, the level designer has not added one to the map! Creating a default one"@TempCCM);
        }

        TempCCM.SetOwningTeam(EOT_Both);

        if( AllCCMs[0] == none )
            AllCCMs[0] = TempCCM;

        if( AllCCMs[1] == none )
            AllCCMs[1] = TempCCM;
    }
}

function AddCharge(RORemoteExplosiveProjectile ChargeType)
{
    local ROPlantedChargeInfo ROPCI;

    if (ChargeType.IsA('ZMBomberBomb'))
    {
        // Check to make sure we're not attempting to plant another one, if so, remove it and place the trap in a new place.
        if (BBCharges.Length >= ChargeType.default.MaxAllowed )
        {
            BBCharges[0].ShutDown();
            BBCharges.Remove(0, 1);

            if(WorldInfo.NetMode != NM_Client)
            {
                ClientRemoveCharge(0);
            }
        }

        BBCharges.AddItem(ZMBomberBomb(ChargeType));
        iPlantedBBChargeCount = BBCharges.length;
        ROPCI.ServerArrayIndex = iPlantedBBChargeCount - 1;

        if (WorldInfo.NetMode != NM_Client && ChargeType.Physics == PHYS_None)
        {
            ROPCI.ChargeLocation = ChargeType.Location;
            ROPCI.Icon = ChargeType.TacticalIcon;
            ClientAddCharge(ROPCI);
        }
    }
    else
    {
        super.AddCharge(ChargeType);
    }
}

function RemoveCharge(ROSatchelChargeProjectile ChargeType, optional bool bTriggeredOrDisarmed)
{
    local int idx;

    if(ChargeType.IsA('ZMBomberBomb'))
    {
        idx = BBCharges.Find(ZMBomberBomb(ChargeType));
        if (idx > -1)
        {
            BBCharges.Remove(idx, 1);

            if(WorldInfo.NetMode != NM_Client)
            {
                ClientRemoveCharge(idx);
            }
        }

        iPlantedBBChargeCount = BBCharges.length;

        if(WorldInfo.NetMode != NM_Client)
        {
            if(bTriggeredOrDisarmed)
            {
                ClientFlashTrapIndicator();
            }
        }
    }
    else
    {
        super.RemoveCharge(ChargeType, bTriggeredOrDisarmed);
    }
}

simulated function ClearCharges()
{
    local int i;

    for(i = 0; i < BBCharges.Length; i++)
    {
        BBCharges[i].Shutdown();
    }
    BBCharges.Remove(0, BBCharges.Length);
    iPlantedBBChargeCount=0;

    super.ClearCharges();
}

//////////////////////////////////////////////////
// DEBUG
//////////////////////////////////////////////////

`ifdef(DEBUG)

simulated exec function SpawnZMM113()
{
    local vector                    CamLoc, StartShot, EndShot, X, Y, Z;
    local rotator                   CamRot;
    local class<ROVehicle>          TankClass;
    Local ROVehicle ROTank;

    GetPlayerViewPoint(CamLoc, CamRot);

    // Do ray check and grab actor
    GetAxes( CamRot, X, Y, Z );
    StartShot   = CamLoc;
    EndShot     = StartShot + (200.0 * X);

    TankClass = class<ROVehicle>(DynamicLoadObject("ZombieMode.ZMVehicle_M113_APC_Content", class'Class'));

    if( TankClass != none )
    {
        ROTank = Spawn(TankClass, , , EndShot);
        ROTank.Mesh.AddImpulse(vect(0,0,1), ROTank.Location);
    }
}

exec function Camera( name NewMode )
{
    ServerCamera(NewMode);
}

reliable server function ServerCamera( name NewMode )
{
    if ( NewMode == '1st' )
    {
        NewMode = 'FirstPerson';
    }
    else if ( NewMode == '3rd' )
    {
        NewMode = 'ThirdPerson';
    }

    SetCameraMode( NewMode );

    if ( PlayerCamera != None )
        `log("#### " $ PlayerCamera.CameraStyle);
}

`endif

//////////////////////////////////////////////////
// DEBUG END
//////////////////////////////////////////////////

DefaultProperties
{
    CachedSFXVolume=0.2
    CachedSFXVolumeMaxAge=2 // Seconds.

    NorthReinforcementDelayModifier=`NORTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT
    SouthReinforcementDelayModifier=`SOUTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT
}
