extends Resource
class_name SpawnTime

@export var creatureType : PackedScene = preload("res://prefabs/Pufferfish.tscn");
@export var spawnBeat : int;
@export_range(0, 3) var lane : int;
