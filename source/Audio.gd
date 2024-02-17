extends Node2D

# Control for maximum volume of song
@export var fullVolumedB : float = 0;
@onready var currentVolumedB : float = $Music.volume_db;

# get how fast the song is since it will affect enemy spawns
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
		trySpawnEnemy(currentBeat)

func fadeIn(delta : float):
	currentVolumedB = clampf(lerp( currentVolumedB, fullVolumedB, 0.1 * delta), -80, fullVolumedB)

func fadeOut(delta : float):
	currentVolumedB = clampf(lerp( currentVolumedB, -80, 0.1 * delta), -80, fullVolumedB)

func play():
	state = AudioState.VolumeIncreasing;

func stop_playing():
	state = AudioState.Stopped;

func startAudio():
	play()
	lastBeat = 0;
	
# Enemy spawning
@export var spawnTimes : Array[SpawnTime];
@export_range(0, 0.3) var beatTolerance : float = 0;
@export var Enemies : Node2D;

func trySpawnEnemy(currentBeat : float):
	for spawnTime : SpawnTime in spawnTimes:
		if spawnTime.spawnBeat < currentBeat and currentBeat < spawnTime.spawnBeat + beatTolerance: 
			spawnEnemy(spawnTime.creatureType, spawnTime.lane)
			
func spawnEnemy(creatureType : PackedScene, laneNumber : int):
	var enemy = creatureType.new()
	enemy.location = Vector2((laneNumber + 0.5) * 160, 320)
	Enemies.add_child(enemy)

