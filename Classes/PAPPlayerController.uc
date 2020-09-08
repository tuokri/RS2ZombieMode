class PAPPlayerController extends ROPlayerController
    config(Mutator_PicksAndPistols_Client);

var float NorthReinforcementDelayModifier;
var float SouthReinforcementDelayModifier;

function PreBeginPlay()
{
    super.PreBeginPlay();

    if (WorldInfo.NetMode == NM_Standalone)
    {
        ReplicateModShit();
    }
}

simulated function ReceivedGameClass(class<GameInfo> GameClass)
{
    super.ReceivedGameClass(GameClass);

    `paplog("PAPPlayerController.ReceivedGameClass(), GameClass=" $ GameClass, 'Debug');

    if (WorldInfo.NetMode != NM_Standalone)
    {
        ReplicateModShit();
    }
}

function float VerifyFloatModifierMin(Name ModifierName, float Modifier,
    float MinValue, float DefaultValue)
{
    if (Modifier < `NORTH_PAWN_MODIFIER_MIN)
    {
        `paplog("WARNING: " $ ModifierName $ "(" $ Modifier $ ") is less than " $
            MinValue $ " using default value: " $ DefaultValue, 'Config');
        Modifier = DefaultValue;
    }
    return Modifier;
}

function VerifyConfig()
{
    NorthReinforcementDelayModifier = VerifyFloatModifierMin(
        Nameof(NorthReinforcementDelayModifier), NorthReinforcementDelayModifier,
        `REINFORCEMENT_DELAY_MODIFIER_MIN, `NORTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT);

    SouthReinforcementDelayModifier = VerifyFloatModifierMin(
        Nameof(SouthReinforcementDelayModifier), SouthReinforcementDelayModifier,
        `REINFORCEMENT_DELAY_MODIFIER_MIN, `SOUTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT);

    SaveConfig();
    `paplog("Configuration verified", 'Config');
}

simulated function ReplicateModShit()
{
    ReplaceRoles();
    OverrideMapInfo();
    DestroyPickupFactories();
}

simulated function DestroyPickupFactories()
{
    local PickupFactory PF;
    local int Count;

    `paplog("Destroying pickup factories", 'Pickups');

    foreach BasedActors(class'PickupFactory', PF)
    {
        PF.bPickupHidden = True;
        PF.ShutDown();
        PF.Destroy();
        ++Count;
    }

    if (Count > 0)
    {
        `paplog("Destroyed " $ Count $ " pickup factories", 'Pickups');
    }
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

    `paplog("AxisReinforcementDelay16=" $ ROMI.AxisReinforcementDelay16, 'Debug');
    `paplog("AxisReinforcementDelay32=" $ ROMI.AxisReinforcementDelay32, 'Debug');
    `paplog("AxisReinforcementDelay64=" $ ROMI.AxisReinforcementDelay64, 'Debug');
    `paplog("AlliesReinforcementDelay16=" $ ROMI.AlliesReinforcementDelay16, 'Debug');
    `paplog("AlliesReinforcementDelay32=" $ ROMI.AlliesReinforcementDelay32, 'Debug');
    `paplog("AlliesReinforcementDelay64=" $ ROMI.AlliesReinforcementDelay64, 'Debug');

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
    ROMI.InstantRespawnInterval = 30;
}

simulated function ReplaceRoles()
{
    local ROMapInfo ROMI;
    local RORoleCount RORC;

    ROMI = ROMapInfo(WorldInfo.GetMapInfo());

    ROMI.NorthernRoles.Remove(0, ROMI.NorthernRoles.Length);
    ROMI.SouthernRoles.Remove(0, ROMI.SouthernRoles.Length);

    ROMI.NorthernTeamLeader.RoleInfo = new class'PAPRoleInfoNorthernCommander';
    ROMI.SouthernTeamLeader.RoleInfo = None;
    // ROMI.SouthernTeamLeader.RoleInfo = new class'PAPRoleInfoSouthernCommander';

    RORC.RoleInfoClass = class'PAPRoleInfoNorthernZombie';
    RORC.Count = 255;
    ROMI.NorthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoNorthernSmoker';
    RORC.Count = 6;
    ROMI.NorthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoNorthernLeaper';
    RORC.Count = 8;
    ROMI.NorthernRoles.AddItem(RORC);

    /*
    RORC.RoleInfoClass = class'PAPRoleInfoNorthernBomber';
    RORC.Count = 4;
    ROMI.NorthernRoles.AddItem(RORC);
    */

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernSurvivor';
    RORC.Count = 255;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernFighter';
    RORC.Count = 3;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernTrapper';
    RORC.Count = 4;
    ROMI.SouthernRoles.AddItem(RORC);

    /*
    RORC.RoleInfoClass = class'PAPRoleInfoSouthernGunner';
    RORC.Count = 2;
    ROMI.SouthernRoles.AddItem(RORC);
    */
}

reliable client function ClientTriggerMapBoundary()
{
    local ROPawn ROP;

    ROP = ROPawn(Pawn);

    // Zombies have no boundaries.
    if (ROP != None && ROP.GetTeamNum() == `AXIS_TEAM_INDEX)
    {
        `paplog("ClientTriggerMapBoundary(): Ignore boundary for: " $ ROP, 'Boundary');
        ROP.VolumeKillTime = 999999;
    }
    else
    {
        TriggerHint(ROHTrig_MapBoundary);
    }
}

reliable client function ToggleMapBoundsSoundMode(bool bEnabled)
{
    local ROPawn ROP;

    ROP = ROPawn(Pawn);

    // Zombies have no boundaries.
    if (ROP != None && ROP.GetTeamNum() == `AXIS_TEAM_INDEX)
    {
        `paplog("ToggleMapBoundsSoundMode(): Ignore boundary for: " $ ROP, 'Boundary');
        ROP.VolumeKillTime = 999999;
        bEnabled = False;
    }

    super.ToggleMapBoundsSoundMode(bEnabled);
}

reliable client event ReceiveLocalizedMessage(class<LocalMessage> Message, optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject)
{
    local ROPawn ROP;

    ROP = ROPawn(Pawn);

    // Zombies have no boundaries.
    if (ROP != None && ROP.GetTeamNum() == `AXIS_TEAM_INDEX && Switch == RORAMSG_MapBoundaryTouch)
    {
        `paplog("ReceiveLocalizedMessage(): Ignore boundary for: " $ ROP, 'Boundary');
        ROP.VolumeKillTime = 999999;
    }
    else
    {
        super.ReceiveLocalizedMessage(Message, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
    }
}

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
            AllCCMs[ROCPA.OwningTeam] = Spawn(class'PAPCharCustMannequin', self,, ROCPA.Location, ROCPA.Rotation);
        }
    }

    if( AllCCMs[0] == none || AllCCMs[1] == none )
    {
        if( CPABoth != none )
            TempCCM = Spawn(class'PAPCharCustMannequin', self,, CPABoth.Location, CPABoth.Rotation);
        else
        {
            TempCCM = Spawn(class'PAPCharCustMannequin', self, , vect(0,0,100));
            `warn("Couldn't find an PAPCharCustMannequin, the level designer has not added one to the map! Creating a default one"@TempCCM);
        }

        TempCCM.SetOwningTeam(EOT_Both);

        if( AllCCMs[0] == none )
            AllCCMs[0] = TempCCM;

        if( AllCCMs[1] == none )
            AllCCMs[1] = TempCCM;
    }
}

DefaultProperties
{
    NorthReinforcementDelayModifier=`NORTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT
    SouthReinforcementDelayModifier=`SOUTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT
}
