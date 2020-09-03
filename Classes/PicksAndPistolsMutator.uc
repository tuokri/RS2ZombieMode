class PicksAndPistolsMutator extends ROMutator
    config(Mutator_PicksAndPistols_Server);

var config float NorthJumpZModifier;
var config float NorthGroundSpeedModifier;
var config float NorthAccelRateModifier;
var config float NorthMaxFallSpeedModifier;

var float VerifiedNorthJumpZMod;
var float VerifiedNorthGroundSpeedMod;
var float VerifiedNorthAccelRateMod;
var float VerifiedNorthMaxFallSpeedMod;

var bool bConfigVerified;

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
    StartSec = WorldInfo.TimeSeconds;

    `paplog("Waiting for ROGameInfo to initialize...", 'Init');
    while (ROGameInfo(WorldInfo.Game) == None) {/* Wait. */}
    `paplog("ROGameInfo initialized in " $ WorldInfo.TimeSeconds - StartSec $ " seconds", 'Init');

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
}

function ModifyMapInfo()
{
    local RORoleCount RORC;
    local ROMapInfo ROMI;
    local int i;

    `paplog("Modifying ROMapInfo", 'MapInfo');
    ROMI = ROMapInfo(WorldInfo.GetMapInfo());

    ROMI.NorthernTeamLeader.RoleInfo = new class'PAPRoleInfoNorthernCommander';
    ROMI.SouthernTeamLeader.RoleInfo = new class'PAPRoleInfoSouthernCommander';

    ROMI.NorthernRoles.Remove(0, ROMI.NorthernRoles.Length);
    ROMI.SouthernRoles.Remove(0, ROMI.NorthernRoles.Length);

    RORC.RoleInfoClass = class'RORoleInfoNorthernZombie';
    RORC.Count = 255;
    ROMI.NorthernRoles.AddItem(RORC);

    RORC.RoleInfoClass = class'RORoleInfoSouthernSurvivor';
    RORC.Count = 255;
    ROMI.SouthernRoles.AddItem(RORC);

    // TODO: Add these modifiers to config.
    ROMI.AxisReinforcementDelay16 *= 0.5;
    ROMI.AxisReinforcementDelay32 *= 0.5;
    ROMI.AxisReinforcementDelay64 *= 0.5;
    ROMI.AlliesReinforcementDelay16 *= 1.0;
    ROMI.AlliesReinforcementDelay32 *= 1.0;
    ROMI.AlliesReinforcementDelay64 *= 1.0;
}

function float VerifyFloatModifier(Name ModifierName, float Modifier)
{
    if (Modifier < `NORTH_PAWN_MODIFIER_MIN)
    {
        `paplog("WARNING: " $ ModifierName $ "(" $ Modifier $ ") is less than " $
            `NORTH_PAWN_MODIFIER_MIN $ " using default value: " $ `NORTH_PAWN_MODIFIER_DEFAULT, 'Config');
        Modifier = `NORTH_PAWN_MODIFIER_DEFAULT;
    }
    return Modifier;
}

function VerifyConfig()
{
    VerifiedNorthJumpZMod = VerifyFloatModifier(
        Nameof(NorthJumpZModifier), NorthJumpZModifier);
    VerifiedNorthGroundSpeedMod = VerifyFloatModifier(
        Nameof(NorthGroundSpeedModifier), NorthGroundSpeedModifier);
    VerifiedNorthAccelRateMod = VerifyFloatModifier(
        Nameof(NorthAccelRateModifier), NorthAccelRateModifier);
    VerifiedNorthMaxFallSpeedMod = VerifyFloatModifier(
        Nameof(NorthMaxFallSpeedModifier), NorthMaxFallSpeedModifier);
    bConfigVerified = True;
    `paplog("Configuration verified", 'Config');
}

function ModifyNorthPlayer(out Pawn Other)
{
    local PAPNorthPawn NP;

    NP = PAPNorthPawn(Other);
    NP.JumpZ *= VerifiedNorthJumpZMod;
    NP.GroundSpeed *= VerifiedNorthGroundSpeedMod;
    NP.AccelRate *= VerifiedNorthAccelRateMod;
    NP.MaxFallSpeed *= VerifiedNorthMaxFallSpeedMod;
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


function SetSouthWeapons()
{

}

function SetNorthWeapons()
{

}

DefaultProperties
{
    VerifiedNorthJumpZMod=`NORTH_PAWN_MODIFIER_DEFAULT
    VerifiedNorthGroundSpeedMod=`NORTH_PAWN_MODIFIER_DEFAULT
    VerifiedNorthAccelRateMod=`NORTH_PAWN_MODIFIER_DEFAULT
    VerifiedNorthMaxFallSpeedMod=`NORTH_PAWN_MODIFIER_DEFAULT

    RORICSouth=(LevelContentClasses=("PicksAndPistols.PAPSouthPawn"))
    RORICNorth=(LevelContentClasses=("PicksAndPistols.PAPNorthPawn"))
}
