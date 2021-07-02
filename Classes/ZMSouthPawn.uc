class ZMSouthPawn extends ROSouthPawn;

var bool bCanBanzaiCharge;
var bool bTerrorSuppressed;

replication
{
    if (Role == ROLE_Authority && bNetDirty && bNetOwner)
        bTerrorSuppressed;
}

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
