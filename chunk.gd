class_name Chunk extends Node3D

var chunkSize: int = 16

func chunkGeneration(xOffset: int, yOffset: int, zOffset: int) -> void:
	for x in range(chunkSize):
		for z in range(chunkSize):
			for y in range(chunkSize):
				layerGeneration(x, y, z, xOffset, yOffset, zOffset)

func layerGeneration(x: int, y: int, z: int, xOffset: int, yOffset: int, zOffset: int) -> void:
	#Creation of block and its Texture
	var block: Block = Block.new()
	var blockTexture: StandardMaterial3D = StandardMaterial3D.new()
	
	#Assing block Texture according to its 
	#location Grass on top, the rest is stone (WIP)
	if y == chunkSize - 1:
		blockTexture.albedo_color = Color.GREEN
	else:
		blockTexture.albedo_color = Color.DIM_GRAY
	block.texture = blockTexture
	
	#Add chunkOffset to all coordinates
	x += chunkSize * xOffset
	y += chunkSize * yOffset
	z += chunkSize * zOffset
	
	#Place block in chunk
	block.position = Vector3(x, y, z)
	
	#Make block a child of the Chunk
	add_child(block)
