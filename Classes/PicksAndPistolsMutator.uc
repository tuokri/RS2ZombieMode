class PicksAndPistolsMutator extends ROMutator
    config(Mutator_PicksAndPistols_Server);

var config float NorthJumpZModifier;
var config float NorthGroundSpeedModifier;
var config float NorthAccelRateModifier;
var config float NorthMaxFallSpeedModifier;

var config float NorthReinforcementDelayModifier;
var config float SouthReinforcementDelayModifier;

var RORoleInfoClasses RORICSouth;
var RORoleInfoClasses RORICNorth;

function PreBeginPlay()
{
    `paplog("PreBeginPlay()", 'Init');
    VerifyConfig();
    SaveConfig();
}

function PostBeginPlay()
{
    local float StartSec;

    `paplog("PostBeginPlay()", 'Init');
    StartSec = WorldInfo.RealTimeSeconds;

    `paplog("Waiting for ROGameInfo to initialize...", 'Init');
    while (ROGameInfo(WorldInfo.Game) == None) {/* Wait. */}
    `paplog("ROGameInfo initialized in " $ WorldInfo.RealTimeSeconds - StartSec $ " seconds", 'Init');

    ReplacePawns();
    ModifyGameInfo();
    ModifyMapInfo();
}

simulated function ReplacePawns()
{
    ROGameInfo(WorldInfo.Game).SouthRoleContentClasses = RORICSouth;
    ROGameInfo(WorldInfo.Game).NorthRoleContentClasses = RORICNorth;
    `paplog("Pawns replaced", 'Init');
}

function ModifyGameInfo()
{
    local PickupFactory PF;
    local int Count;

    `paplog("Modifying game info", 'GameInfo');
    foreach BasedActors(class'PickupFactory', PF)
    {
        // bPickupHidden = True;
        // PF.ShutDown();
        PF.Destroy();
        ++Count;
    }

    if (Count > 0)
    {
        `paplog("Destroyed " $ Count $ " pickup factories");
    }
}

simulated function ModifyMapInfo()
{
    local RORoleCount RORC;
    local ROMapInfo ROMI;

    `paplog("Modifying map info", 'MapInfo');
    ROMI = ROMapInfo(WorldInfo.GetMapInfo());

    ROMI.NorthernTeamLeader.RoleInfo = new class'PAPRoleInfoNorthernCommander';
    // No Southern TL for now.
    // ROMI.SouthernTeamLeader.RoleInfo = new class'PAPRoleInfoSouthernCommander';
    ROMI.SouthernTeamLeader.RoleInfo = None;

    ROMI.NorthernRoles.Remove(0, ROMI.NorthernRoles.Length);
    ROMI.SouthernRoles.Remove(0, ROMI.NorthernRoles.Length);

    RORC.RoleInfoClass = class'PAPRoleInfoNorthernZombie';
    RORC.Count = 255;
    RORC.ReverseCount = 255;
    ROMI.NorthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernSurvivor';
    RORC.Count = 255;
    RORC.ReverseCount = 255;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernFighter';
    RORC.Count = 2;
    RORC.ReverseCount = 2;
    ROMI.SouthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'PAPRoleInfoSouthernProtester';
    RORC.Count = 2;
    RORC.ReverseCount = 2;
    ROMI.SouthernRoles.AddItem(RORC);

    ROMI.AxisReinforcementDelay16 *= NorthReinforcementDelayModifier;
    ROMI.AxisReinforcementDelay32 *= NorthReinforcementDelayModifier;
    ROMI.AxisReinforcementDelay64 *= NorthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay16 *= SouthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay32 *= SouthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay64 *= SouthReinforcementDelayModifier;
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

    NorthReinforcementDelayModifier = VerifyFloatModifierMin(
        Nameof(NorthReinforcementDelayModifier), NorthReinforcementDelayModifier,
        `REINFORCEMENT_DELAY_MODIFIER_MIN, `NORTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT);

    SouthReinforcementDelayModifier = VerifyFloatModifierMin(
        Nameof(SouthReinforcementDelayModifier), SouthReinforcementDelayModifier,
        `REINFORCEMENT_DELAY_MODIFIER_MIN, `SOUTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT);

    `paplog("Configuration verified", 'Config');
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

    // Just a fail-safe. Not sure if even it's possible to
    // call ModifPlayer before PreBeginPlay.
    /*
    if (!bConfigVerified)
    {
        VerifyConfig();
    }
    */

    if (Other.GetTeamNum() == `ALLIES_TEAM_INDEX)
    {
        ModifySouthPlayer(Other);
    }
    else if (Other.GetTeamNum() == `AXIS_TEAM_INDEX)
    {
        ModifyNorthPlayer(Other);
    }
}

DefaultProperties
{
    NorthJumpZModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthGroundSpeedModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthAccelRateModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthMaxFallSpeedModifier=`NORTH_PAWN_MODIFIER_DEFAULT

    NorthReinforcementDelayModifier=`NORTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT
    SouthReinforcementDelayModifier=`SOUTH_REINFORCEMENT_DELAY_MODIFIER_DEFAULT

    RORICSouth=(LevelContentClasses=("PicksAndPistols.PAPSouthPawn"))
    RORICNorth=(LevelContentClasses=("PicksAndPistols.PAPNorthPawn"))
}
