extends CharacterBody2D

var moveSpeed : float;
@export var rotationSpeed : float = 3

enum FishState{
	MovingAtPlayer,
	MovingPastPlayer,
	SpinningAwayFromPlayer,
}
var state = FishState.MovingAtPlayer;


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		FishState.MovingAtPlayer:
			velocity.y = moveSpeed;
		FishState.SpinningAwayFromPlayer:
			$Sprite.rotation += delta * rotationSpeed * PI
	
	move_and_slide()

func spinIntoOblivion():
	state = FishState.SpinningAwayFromPlayer
	var direction = randf_range(0, PI) 
	velocity = Vector2(randf_range(350.0, 500.0), 0.0).rotated(direction)
	

	
	
