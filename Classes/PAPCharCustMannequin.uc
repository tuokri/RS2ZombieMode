class PAPCharCustMannequin extends ROCharCustMannequin
	notplaceable;

event PostBeginPlay()
{
	super(Actor).PostBeginPlay();
	PawnHandlerClass = class'PAPPawnHAndler';
}
