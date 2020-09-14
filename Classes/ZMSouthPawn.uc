class ZMSouthPawn extends ROSouthPawn;

var bool bCanBanzaiCharge;
var bool bTerrorSuppressed;

simulated event PreBeginPlay()
{
    PawnHandlerClass = class'ZMPawnHandler';

    super.PreBeginPlay();
}

function DeactivateSuppressedByBanzai()
{
    bTerrorSuppressed = False;
}

DefaultProperties
{
    bCanBanzaiCharge = False;
}
