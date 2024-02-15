extends CharacterBody2D

@export var moveSpeed : float = 10;
@export var wiggleWavelength : float = 10;
@export var wiggleWaveHeight : float = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y = -moveSpeed;
	
	move_and_slide()
