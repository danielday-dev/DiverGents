extends Node2D

@export var waveHeight : float = 1;
@export var wavelength : float = 1;

@onready var startingPosition : Vector2 = position;
var time : float = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	position.y = startingPosition.y + waveHeight * sin(time * wavelength);
	
	
