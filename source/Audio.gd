extends Node2D

@export var fullVolumedB : float = 0;
@onready var currentVolumedB = $Music.volume_db;

enum AudioState{
	Stopped,
	VolumeIncreasing,
	VolumeMaxed,
}

@onready var screenSize : Vector2 = get_viewport_rect().size
@onready var state : AudioState = AudioState.Stopped;



func _process(delta):
	match state:
		AudioState.Stopped:
			pass;
		AudioState.VolumeIncreasing:
			fadeIn();
		AudioState.VolumeMaxed:
			pass;

func fadeIn(): #THIS IS JUST LERP BUT WORSE AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
	var currentpercent : float = (currentVolumedB+80) / (fullVolumedB+80)
	if currentpercent == 1:
		state = AudioState.VolumeMaxed;
	else:
		currentpercent += 0.10
		currentVolumedB = (currentpercent / (fullVolumedB + 80)) - 80
		currentVolumedB = clampf(currentVolumedB,-80, fullVolumedB)

func play():
	state = AudioState.VolumeIncreasing;
	
func stop_playing():
	state = AudioState.Stopped;
