class PAPSouthPawn extends ROSouthPawn;

simulated event PreBeginPlay()
{
    PawnHandlerClass = class'PAPPawnHandler';

    super.PreBeginPlay();
}
