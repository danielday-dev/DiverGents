extends CharacterBody2D

signal reachedEnd()

enum SpinState{
	NotSpinning,
	Spinning,
}
var state : SpinState = SpinState.NotSpinning;

@export var spinSpeed : float = 3;
@export var pathSpeedPercent : float = 5;

@onready var path : PathFollow2D = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		SpinState.NotSpinning:
			pass
		SpinState.Spinning:
			rotation += delta * spinSpeed * PI
			path.progress += pathSpeedPercent
			if path.progress_ratio == 1.0:
				reachedEnd.emit()
			
	

func _do_a_flip():
	state = SpinState.Spinning
