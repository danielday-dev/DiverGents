extends CharacterBody2D

@export var moveSpeed : float = 10;
@export var rotationSpeed : float = 3

enum FishState{
	MovingAtPlayer,
	SpinningAwayFromPlayer,
}
var state = FishState.MovingAtPlayer;


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		FishState.MovingAtPlayer:
			velocity.y = -moveSpeed;
		FishState.SpinningAwayFromPlayer:
			$Sprite.rotation += delta * rotationSpeed * PI
	
	move_and_slide()

func spinIntoOblivion():
	var direction = randf_range(-PI, PI) 
	velocity = Vector2(randf_range(150.0, 250.0), 0.0).rotated(direction)
	
	
