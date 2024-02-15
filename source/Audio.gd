extends Node2D

signal BeatIsHappening(beat : float)

@export var fullVolumedB : float = 0;
@onready var currentVolumedB : float = $Music.volume_db;

@export var songBPM : int= 0;
@onready var bps : int = songBPM * 60;

enum AudioState{
	Stopped,
	VolumeDecreasing,
	VolumeIncreasing,
	VolumeMaxed,
}

@onready var screenSize : Vector2 = get_viewport_rect().size
@onready var state : AudioState = AudioState.Stopped;

var beatIsAboutToHappen : bool = false;
var lastBeat : float = 0;

func _process(delta):
	match state:
		AudioState.Stopped:
			pass;
		AudioState.VolumeDecreasing:
			fadeOut(delta)
		AudioState.VolumeIncreasing:
			fadeIn(delta);
		AudioState.VolumeMaxed:
			pass;
			
	var time = $Music.get_playback_position() + AudioServer.get_time_since_last_mix()
	# var time = $Player.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	# use this line if more precision is needed, get output latency() should be done in the ready
	
	var currentBeat = fmod(time/bps, 1)
	
	beatIsAboutToHappen = currentBeat < lastBeat
	lastBeat = currentBeat
	
	if beatIsAboutToHappen:
		# tell spawner to spawn if it spawns here
		BeatIsHappening.emit(currentBeat)

func fadeIn(delta : float):
	currentVolumedB = clampf(lerp( currentVolumedB, fullVolumedB, 0.1 * delta), -80, fullVolumedB)

func fadeOut(delta : float):
	currentVolumedB = clampf(lerp( currentVolumedB, -80, 0.1 * delta), -80, fullVolumedB)

func play():
	state = AudioState.VolumeIncreasing;

func stop_playing():
	state = AudioState.Stopped;
