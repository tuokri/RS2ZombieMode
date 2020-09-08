class ZMCharCustMannequin extends ROCharCustMannequin
	notplaceable;

event PostBeginPlay()
{
	super(Actor).PostBeginPlay();
	PawnHandlerClass = class'ZMPawnHAndler';
}
