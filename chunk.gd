extends Node3D

@export var chunkSize: int = 16

func _ready() -> void:
	chunkGeneration()

func chunkGeneration() -> void:
	for x in range(chunkSize):
		for z in range(chunkSize):
			for y in range(chunkSize):
				layerGeneration(x, y, z)
			

func layerGeneration(x: int, y: int, z: int) -> void:
	var block: Block = Block.new()
	var blockTexture: StandardMaterial3D = StandardMaterial3D.new()
	if y == chunkSize - 1:
		blockTexture.albedo_color = Color.GREEN
	else:
		blockTexture.albedo_color = Color.DIM_GRAY
	block.texture = blockTexture
	block.position = Vector3(x, y, z)
	add_child(block)
