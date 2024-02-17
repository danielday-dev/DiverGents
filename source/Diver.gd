extends CharacterBody2D
class_name Diver

@export var inputName : String = ""

enum DiverState{
	Waiting,
	MovingToStart,
	Swimming,
	Attacking,
}

var state : DiverState = DiverState.Waiting

@export var restingY : float = 70;
@onready var restingPosition : Vector2 = Vector2(position.x, restingY)
@export var nextDiver : Diver;
@export var swimSpeed : float = 30;
@onready var isLast : bool = nextDiver == null;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var diver_attack : bool = Input.is_action_pressed(inputName);
	
	match state:
		DiverState.Waiting:
			pass;
		DiverState.MovingToStart:
			position = position.move_toward(restingPosition, swimSpeed *delta)
			if position == restingPosition:
				tellNextDiverToCome()
				state = DiverState.Swimming
				
			
		DiverState.Swimming:
			if diver_attack:
				attackPressed()
		DiverState.Attacking:
			pass
			
	move_and_slide()
	

func attackPressed():
	state = DiverState.Attacking
	$AttackNoise.play()
	
func tellNextDiverToCome():
	if !isLast:
		nextDiver.startMoveToRestPosition()
	else:
		get_parent().get_parent().get_child(1).startAudio()
		
func startMoveToRestPosition():
	state = DiverState.MovingToStart
