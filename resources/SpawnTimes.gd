extends Resource
class_name SpawnTimes

@export var creatureType : PackedScene;
@export var spawnBeat : float;
@export_range(0, 3) var lane : int;
