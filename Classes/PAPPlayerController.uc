class PAPPlayerController extends ROPlayerController
    config(Mutator_PicksAndPistols_Client);

var config float NorthReinforcementDelayModifier;
var config float SouthReinforcementDelayModifier;

var array<RORoleCount> SouthernRolesPAP;
var array<RORoleCount> NorthernRolesPAP;

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

    `paplog("ReceivedGameClass");

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
}

simulated function ReplaceRoles()
{
    local ROMapInfo ROMI;
    local RORoleCount RORC;

    ROMI = ROMapInfo(WorldInfo.GetMapInfo());

    ROMI.NorthernRoles.Remove(0, ROMI.NorthernRoles.Length);
    ROMI.SouthernRoles.Remove(0, ROMI.SouthernRoles.Length);

    ROMI.NorthernTeamLeader.RoleInfo = new class'PAPRoleInfoNorthernCommander';
    ROMI.SouthernTeamLeader.RoleInfo = new class'PAPRoleInfoSouthernCommander';

    RORC.RoleInfoClass = class'PAPRoleInfoNorthernZombie';
    RORC.Count = 255;
    ROMI.NorthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernSurvivor';
    RORC.Count = 255;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernFighter';
    RORC.Count = 2;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernProtester';
    RORC.Count = 2;
    ROMI.SouthernRoles.AddItem(RORC);
}

DefaultProperties
{
    NorthReinforcementDelayModifier=`NORTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT
    SouthReinforcementDelayModifier=`SOUTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT
}
