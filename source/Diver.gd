extends Node2D

@export var inputName : String = ""

enum DiverState{
	Swimming,
	Attacking,
}

var state : DiverState = DiverState.Swimming

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var diver1_attack: bool = Input.is_action_pressed(inputName);
	
	match state:
		DiverState.Swimming:
			if diver1_attack:
				attackPressed()
		DiverState.Attacking:
			pass

func attackPressed():
	state = DiverState.Attacking
	$AttackNoise.play()
	
