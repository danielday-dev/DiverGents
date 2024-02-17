extends Node2D
class_name Lane

@export_range(0,3) var laneNumber : int;

@onready var screen_size : Vector2 = get_viewport_rect().size 

func _ready():
	# Set Lane and diver to right place
	position.x = screen_size.x * 0.25 * laneNumber;
	var laneWidth : float = screen_size.x - position.x;
	#$Diver.position.x = position.x + laneWidth*0.1;
	$Diver.position.y = 50;
	
	var inputName : String = "diver" + str(laneNumber+1) + "_attack";
	$Diver.inputName = inputName



func _process(delta):
	print(global_position)
