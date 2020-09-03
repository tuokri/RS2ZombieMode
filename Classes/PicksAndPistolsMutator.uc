class PicksAndPistolsMutator extends ROMutator
    config(Mutator_PicksAndPistols_Server);

var config float NorthJumpZModifier;
var config float NorthGroundSpeedModifier;
var config float NorthAccelRateModifier;
var config float NorthMaxFallSpeedModifier;

var RORoleInfoClasses RORICSouth;
var RORoleInfoClasses RORICNorth;

var array<RORoleCount> SouthernRolesPAP;
var array<RORoleCount> NorthernRolesPAP;

function PreBeginPlay()
{
    `paplog("PreBeginPlay()", 'Init');

    ROGameInfo(WorldInfo.Game).PlayerControllerClass = class'PAPPlayerController';
    ROGameInfo(WorldInfo.Game).PlayerReplicationInfoClass = class'PAPPlayerReplicationInfo';

    VerifyConfig();
}

function PostBeginPlay()
{
    `paplog("PostBeginPlay()", 'Init');
    ReplacePawns();
    DestroyPickupFactories();
    Fuck();
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

simulated function OverrideMapInfo()
{
    local ROMapInfo ROMI;

    ROMI = ROMapInfo(WorldInfo.GetMapInfo());

    /*
    ROMI.AxisReinforcementDelay16 *= PAPPlayerController.default.NorthReinforcementDelayModifier;
    ROMI.AxisReinforcementDelay32 *= PAPPlayerController.default.NorthReinforcementDelayModifier;
    ROMI.AxisReinforcementDelay64 *= PAPPlayerController.default.NorthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay16 *= PAPPlayerController.default.SouthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay32 *= PAPPlayerController.default.SouthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay64 *= PAPPlayerController.default.SouthReinforcementDelayModifier;
    */

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

simulated function Fuck()
{
    ReplaceRoles();
    OverrideMapInfo();
}

function VerifyConfig()
{
    NorthJumpZModifier = VerifyFloatModifierMin(
        Nameof(NorthJumpZModifier), NorthJumpZModifier,
        `NORTH_PAWN_MODIFIER_MIN, `NORTH_PAWN_MODIFIER_DEFAULT);

    NorthGroundSpeedModifier = VerifyFloatModifierMin(
        Nameof(NorthGroundSpeedModifier), NorthGroundSpeedModifier,
        `NORTH_PAWN_MODIFIER_MIN, `NORTH_PAWN_MODIFIER_DEFAULT);

    NorthAccelRateModifier = VerifyFloatModifierMin(
        Nameof(NorthAccelRateModifier), NorthAccelRateModifier,
        `NORTH_PAWN_MODIFIER_MIN, `NORTH_PAWN_MODIFIER_DEFAULT);

    NorthMaxFallSpeedModifier = VerifyFloatModifierMin(
        Nameof(NorthMaxFallSpeedModifier), NorthMaxFallSpeedModifier,
        `NORTH_PAWN_MODIFIER_MIN, `NORTH_PAWN_MODIFIER_DEFAULT);
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

simulated function ReplacePawns()
{
    ROGameInfo(WorldInfo.Game).SouthRoleContentClasses = RORICSouth;
    ROGameInfo(WorldInfo.Game).NorthRoleContentClasses = RORICNorth;
    `paplog("Pawns replaced", 'Init');
}

function DestroyPickupFactories()
{
    local PickupFactory PF;
    local int Count;

    `paplog("Destroying pickup factories", 'Pickups');

    foreach BasedActors(class'PickupFactory', PF)
    {
        // bPickupHidden = True;
        // PF.ShutDown();
        PF.Destroy();
        ++Count;
    }

    if (Count > 0)
    {
        `paplog("Destroyed " $ Count $ " pickup factories", 'Pickups');
    }
}

function ModifyNorthPlayer(out Pawn Other)
{
    local PAPNorthPawn NP;

    NP = PAPNorthPawn(Other);
    NP.JumpZ *= NorthJumpZModifier;
    NP.GroundSpeed *= NorthGroundSpeedModifier;
    NP.AccelRate *= NorthAccelRateModifier;
    NP.MaxFallSpeed *= NorthMaxFallSpeedModifier;
}

function ModifySouthPlayer(out Pawn Other)
{
    local PAPSouthPawn SP;

    SP = PAPSouthPawn(Other);

    // Now pilots for now.
    // TODO: Make helicopters have no weapons.
    SP.bIsPilot = False;
}

function ModifyPlayer(Pawn Other)
{
    super.ModifyPlayer(Other);

    if (Other.GetTeamNum() == `ALLIES_TEAM_INDEX)
    {
        ModifySouthPlayer(Other);
    }
    else if (Other.GetTeamNum() == `AXIS_TEAM_INDEX)
    {
        ModifyNorthPlayer(Other);
    }
}

function ModifyPreLogin(string Options, string Address, out string ErrorMessage)
{
    ReplacePawns();
}

DefaultProperties
{
    NorthJumpZModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthGroundSpeedModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthAccelRateModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthMaxFallSpeedModifier=`NORTH_PAWN_MODIFIER_DEFAULT

    RORICSouth=(LevelContentClasses=("PicksAndPistols.PAPSouthPawn"))
    RORICNorth=(LevelContentClasses=("PicksAndPistols.PAPNorthPawn"))
}
