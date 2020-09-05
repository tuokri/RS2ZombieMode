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
    Fuck();
}

simulated function Fuck()
{
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

simulated function ModifyNorthPlayer(out Pawn Other)
{
    local PAPNorthPawn NP;
    local RORoleInfo RORI;
    local PAPRoleInfoNorthernInfantry RONI;

    NP = PAPNorthPawn(Other);
    NP.JumpZ *= NorthJumpZModifier;
    NP.GroundSpeed *= NorthGroundSpeedModifier;
    NP.AccelRate *= NorthAccelRateModifier;
    NP.MaxFallSpeed *= NorthMaxFallSpeedModifier;

    RORI = PAPPlayerController(NP.Controller).GetRoleInfo();
    `paplog("RoleInfo = " $ RORI, 'Debug');
    RONI = PAPRoleInfoNorthernInfantry(RORI);
    `paplog("RONI = " $ RONI, 'Debug');
    RONI.ExtraPawnModifiers(NP);
}

simulated function ModifySouthPlayer(out Pawn Other)
{
    local PAPSouthPawn SP;

    SP = PAPSouthPawn(Other);

    // No pilots for now.
    // TODO: Make helicopters have no weapons.
    SP.bIsPilot = False;
}

simulated function ModifyPlayer(Pawn Other)
{
    super.ModifyPlayer(Other);

    // `paplog("Modifying Pawn: " $ Other, 'Debug');

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
