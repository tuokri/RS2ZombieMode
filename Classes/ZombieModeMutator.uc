class ZombieModeMutator extends ROMutator
    config(Mutator_ZombieMode_Server);

var float NorthJumpZModifier;
var float NorthGroundSpeedModifier;
var float NorthAccelRateModifier;
var float NorthMaxFallSpeedModifier;

var RORoleInfoClasses RORICSouth;
var RORoleInfoClasses RORICNorth;

function PreBeginPlay()
{
    `zmlog("PreBeginPlay()", 'Init');

    ROGameInfo(WorldInfo.Game).PlayerControllerClass = class'ZMPlayerController';
    ROGameInfo(WorldInfo.Game).PlayerReplicationInfoClass = class'ZMPlayerReplicationInfo';
    ROGameInfo(WorldInfo.Game).PawnHandlerClass = class'ZMPawnHandler';

    // VerifyConfig();
}

function PostBeginPlay()
{
    `zmlog("PostBeginPlay()", 'Init');
    ReplacePawns();
    Fuck();
}

simulated function Fuck()
{
    OverrideMapInfo();
    DestroyPickupFactories();
}

// TODO: Doesn't work.
// foreach WorldInfo.AllPawns(class'ROVehicleHelicopter', ROVH)
simulated function DestroyPickupFactories()
{
    local PickupFactory PF;
    local int Count;

    `zmlog("Destroying pickup factories", 'Pickups');

    foreach WorldInfo.BasedActors(class'PickupFactory', PF)
    {
        PF.bPickupHidden = True;
        PF.ShutDown();
        PF.Destroy();
        ++Count;
    }

    if (Count > 0)
    {
        `zmlog("Destroyed " $ Count $ " pickup factories", 'Pickups');
    }
}

simulated function OverrideMapInfo()
{
    local ROMapInfo ROMI;

    ROMI = ROMapInfo(WorldInfo.GetMapInfo());

    ROMI.AxisReinforcementDelay16 *= class'ZMPlayerController'.default.NorthReinforcementDelayModifier;
    ROMI.AxisReinforcementDelay32 *= class'ZMPlayerController'.default.NorthReinforcementDelayModifier;
    ROMI.AxisReinforcementDelay64 *= class'ZMPlayerController'.default.NorthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay16 *= class'ZMPlayerController'.default.SouthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay32 *= class'ZMPlayerController'.default.SouthReinforcementDelayModifier;
    ROMI.AlliesReinforcementDelay64 *= class'ZMPlayerController'.default.SouthReinforcementDelayModifier;

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
        `zmlog("WARNING: " $ ModifierName $ "(" $ Modifier $ ") is less than " $
            MinValue $ " using default value: " $ DefaultValue, 'Config');
        Modifier = DefaultValue;
    }
    return Modifier;
}

simulated function ReplacePawns()
{
    ROGameInfo(WorldInfo.Game).SouthRoleContentClasses = RORICSouth;
    ROGameInfo(WorldInfo.Game).NorthRoleContentClasses = RORICNorth;
    `zmlog("Pawns replaced", 'Init');
}

simulated function ModifyNorthPlayer(out Pawn Other)
{
    local ZMNorthPawn NP;
    local RORoleInfo RORI;
    local ZMRoleInfoNorthernInfantry RONI;

    NP = ZMNorthPawn(Other);
    NP.JumpZ *= NorthJumpZModifier;
    NP.GroundSpeed *= NorthGroundSpeedModifier;
    NP.AccelRate *= NorthAccelRateModifier;
    NP.MaxFallSpeed *= NorthMaxFallSpeedModifier;

    RORI = ZMPlayerController(NP.Controller).GetRoleInfo();
    `zmlog("RoleInfo = " $ RORI, 'Debug');
    RONI = ZMRoleInfoNorthernInfantry(RORI);
    `zmlog("RONI = " $ RONI, 'Debug');
    RONI.ExtraPawnModifiers(NP);
}

simulated function ModifySouthPlayer(out Pawn Other)
{
    local ZMSouthPawn SP;

    SP = ZMSouthPawn(Other);

    // No pilots for now.
    // TODO: Make helicopters have no weapons.
    SP.bIsPilot = False;
}

simulated function ModifyPlayer(Pawn Other)
{
    super.ModifyPlayer(Other);

    // `zmlog("Modifying Pawn: " $ Other, 'Debug');

    if (Other.GetTeamNum() == `ALLIES_TEAM_INDEX)
    {
        ModifySouthPlayer(Other);
    }
    else if (Other.GetTeamNum() == `AXIS_TEAM_INDEX)
    {
        ModifyNorthPlayer(Other);
    }

    ReplacePawns();
}

simulated function ModifyPreLogin(string Options, string Address, out string ErrorMessage)
{
    ReplacePawns();
}

DefaultProperties
{
    NorthJumpZModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthGroundSpeedModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthAccelRateModifier=`NORTH_PAWN_MODIFIER_DEFAULT
    NorthMaxFallSpeedModifier=`NORTH_PAWN_MODIFIER_DEFAULT

    RORICSouth=(LevelContentClasses=("ZombieMode.ZMSouthPawn"))
    RORICNorth=(LevelContentClasses=("ZombieMode.ZMNorthPawn"))
}
