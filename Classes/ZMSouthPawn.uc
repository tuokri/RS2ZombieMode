class ZMSouthPawn extends ROSouthPawn;

simulated event PreBeginPlay()
{
    PawnHandlerClass = class'ZMPawnHandler';

    super.PreBeginPlay();
}
