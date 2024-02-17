extends Polygon2D

signal startDivingMovement
signal changeScene

@export var curtainSpeed : float;

enum CurtainState{
	Closed,
	Closing,
	Opening,
	Open,
}
var state = CurtainState.Closed
# Called when the node enters the scene tree for the first time.
func _ready():
	open()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		CurtainState.Closed:
			pass
		CurtainState.Closing:
			color.a = clampf(( color.a+ curtainSpeed * delta), 0.0, 1.0)
			if color.a == 1.0:
				state = CurtainState.Closed;
				changeScene.emit()
				
		CurtainState.Opening:
			color.a = clampf(( color.a - curtainSpeed * delta), 0.0, 1.0)
			if color.a == 0.0:
				state = CurtainState.Open;
				startDivingMovement.emit()
				
		CurtainState.Open:
			pass

func open():
	state = CurtainState.Opening;

func close():
	state = CurtainState.Closing;

func changeSceneToMain():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func changeSceneToMenu():
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
