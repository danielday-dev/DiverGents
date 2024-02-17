extends Node2D

@export var spawnTimes : Array[SpawnTime];
@export_range(0, 0.3) var beatTolerance : float = 0;
@export var lanes : Array[Lane];

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# bla bla get current beat number, send out enemy at the right time in the right lane
	# enemies will take 
	pass;

func trySpawnEnemy(currentBeat : float):
	for spawnTime : SpawnTime in spawnTimes:
		if spawnTime.spawnBeat < currentBeat and currentBeat < spawnTime.spawnBeat + beatTolerance: 
			spawnEnemy(spawnTime.creatureType, spawnTime.lane)
			
func spawnEnemy(creatureType : PackedScene, laneNumber : int):
	var enemy = creatureType.new()
	lanes[laneNumber].add_child(enemy)
