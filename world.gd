extends Node3D

@export var chunkAmount: int = 1
@export var chunkHight: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	worldGeneration()

func worldGeneration() -> void:
	for x in range(chunkAmount):
		for y in range(chunkHight):
			for z in range(chunkAmount):
				print(str(x)+", "+str(y)+", "+str(z))
				#Create new Chunk
				var chunk: Chunk = Chunk.new()
				chunk.chunkGeneration(x, y, z)
				add_child(chunk)
