class ZMNorthPawn extends RONorthPawn;

simulated event PreBeginPlay()
{
    PawnHandlerClass = class'ZMPawnHandler';

    super.PreBeginPlay();
}

DefaultProperties
{
    LegInjuryLength=0.05

    bCanPickupInventory=False
    bCanResupply=False
}
