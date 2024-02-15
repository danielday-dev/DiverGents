extends Node2D

@export var spawnTimes : Array[SpawnTimes];

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# bla bla get current beat number, send out enemy at the right time in the right lane
	# enemies will take 
	var beatdelta : float;
