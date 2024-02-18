extends Node2D

# Control for maximum volume of song
@export var fullVolumedB : float = -10;
@onready var currentVolumedB : float = $Music.volume_db;
@export var fadeSpeed : float = 1;

# get how fast the song is since it will affect enemy spawns
@export var songBPM : int= 120;
@onready var bps : int = songBPM / 60;

enum AudioState{
	Stopped,
	VolumeDecreasing,
	VolumeIncreasing,
	VolumeMaxed,
}

@onready var screenSize : Vector2 = get_viewport_rect().size
@onready var state : AudioState = AudioState.Stopped;

var beatIsAboutToHappen : bool = false;
var lastBeat : int = 0;

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
	
	if state != AudioState.Stopped:	
		var time = $Music.get_playback_position() + AudioServer.get_time_since_last_mix()
		# var time = $Player.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
		# use this line if more precision is needed, get output latency() should be done in the ready
		
		var currentBeat : int = max(floor(time*bps), lastBeat)
		
		beatIsAboutToHappen = currentBeat > lastBeat
		
		if beatIsAboutToHappen:
			trySpawnEnemy(currentBeat)
		
		lastBeat = currentBeat
		
		print(time," ", currentBeat, " ", currentVolumedB)

func fadeIn(delta : float):
	currentVolumedB = clampf(currentVolumedB + fadeSpeed * delta, -80, fullVolumedB)
	$Music.volume_db = currentVolumedB
	if currentVolumedB == fullVolumedB:
		state = AudioState.VolumeMaxed;
	
func fadeOut(delta : float):
	currentVolumedB = clampf(currentVolumedB + fadeSpeed * delta, -80, fullVolumedB)
	$Music.volume_db = currentVolumedB
	if currentVolumedB == -80:
		state = AudioState.Stopped;
		stop_playing()

func play():
	state = AudioState.VolumeIncreasing;
	$Music.play()

func stop_playing():
	state = AudioState.Stopped;
	$Music.stop()

func startAudio():
	play()
	lastBeat = -1;

func checkIsOnBeat():
	return beatIsAboutToHappen
# Enemy spawning
@export var spawnTimes : Array[SpawnTime];
@export var beatsToPlayer : float = 12;

func trySpawnEnemy(currentBeat : int):
	for spawnTime : SpawnTime in spawnTimes:
		if spawnTime.spawnBeat <= currentBeat and spawnTime.spawnBeat > lastBeat: 
			spawnEnemy(spawnTime.creatureType, spawnTime.lane)
			
func spawnEnemy(creatureType : PackedScene, laneNumber : int):
	var enemy = creatureType.instantiate()
	enemy.position = Vector2((laneNumber + 0.5) * 160, 320)
	
	const player_position = 130
	enemy.moveSpeed = (player_position - enemy.global_position.y) * (bps / beatsToPlayer)
	#Enemies.add_child(enemy)
	add_child(enemy)

