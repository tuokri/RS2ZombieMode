class PAPNorthPawn extends RONorthPawn;

simulated event PreBeginPlay()
{
    PawnHandlerClass = class'PAPPawnHandler';

    super.PreBeginPlay();
}

DefaultProperties
{
    LegInjuryLength=0.05

    bCanPickupInventory=False
    bCanResupply=False
}
