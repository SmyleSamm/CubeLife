class_name Chunk extends Node3D

var chunkSize: int = 16

#AI generated code
var blocks: Array = []
var chunkOffset: Vector3i

#AI generated code
const directions: Array = [
	Vector3i( 0,  1,  0), # Top
	Vector3i( 0, -1,  0), # Bottom
	Vector3i( 0,  0, -1), # Back
	Vector3i( 0,  0,  1), # Front
	Vector3i(-1,  0,  0), # Left
	Vector3i( 1,  0,  0)  # Right
]

func chunkGeneration(xOffset: int, yOffset: int, zOffset: int) -> void:
	chunkOffset = Vector3i(xOffset, yOffset, zOffset)
	generateBlocks()
	generateMesh()

func generateBlocks() -> void:
	#AI generated Code
	blocks.resize(chunkSize)
	for x in chunkSize:
		blocks[x] = []
		for y in chunkSize:
			blocks[x].append([])
			for z in chunkSize:
				blocks[x][y].append(1) # 1 = solid block

#AI generated code
func generateMesh() -> void:
	var surfaceTool: SurfaceTool = SurfaceTool.new()
	surfaceTool.begin(Mesh.PRIMITIVE_TRIANGLES)

	for x in range(chunkSize):
		for y in range(chunkSize):
			for z in range(chunkSize):
				if blocks[x][y][z] == 1:
					var faceColor: Color = Color(0.3, 0.3, 0.3) # default gray
					if y == chunkSize - 1:
						faceColor = Color(0, 1, 0) # green for top layer
					for dir in directions:
						var nx: int = x + dir.x
						var ny: int = y + dir.y
						var nz: int = z + dir.z
						if !isInside(nx, ny, nz) or blocks[nx][ny][nz] == 0:
							addFace(surfaceTool, x, y, z, dir, faceColor)

	var mesh: ArrayMesh = surfaceTool.commit()

	var meshInstance: MeshInstance3D = MeshInstance3D.new()
	meshInstance.mesh = mesh
	meshInstance.position = Vector3(chunkOffset) * chunkSize

	var material := StandardMaterial3D.new()
	material.vertex_color_use_as_albedo = true
	meshInstance.material_override = material

	add_child(meshInstance)

	var staticBody: StaticBody3D = StaticBody3D.new()
	add_child(staticBody)

	var collisionShape: CollisionShape3D = CollisionShape3D.new()
	var concaveShape: ConcavePolygonShape3D = ConcavePolygonShape3D.new()
	concaveShape.data = mesh.get_faces()
	collisionShape.shape = concaveShape
	staticBody.add_child(collisionShape)
	staticBody.position = Vector3(chunkOffset) * chunkSize

#AI generated code
func isInside(x: int, y: int, z: int) -> bool:
	return x >= 0 and x < chunkSize and y >= 0 and y < chunkSize and z >= 0 and z < chunkSize

#AI generated code
func addFace(surfaceTool: SurfaceTool, x: int, y: int, z: int, dir: Vector3i, color: Color) -> void:
	var pos: Vector3 = Vector3(x, y, z)
	var faceVertices: Array = []

	if dir == Vector3i(0, 1, 0): # Top
		faceVertices = [
			pos + Vector3(0, 1, 0),
			pos + Vector3(1, 1, 0),
			pos + Vector3(1, 1, 1),
			pos + Vector3(0, 1, 1),
		]
	elif dir == Vector3i(0, -1, 0): # Bottom
		faceVertices = [
			pos + Vector3(0, 0, 1),
			pos + Vector3(1, 0, 1),
			pos + Vector3(1, 0, 0),
			pos + Vector3(0, 0, 0),
		]
	elif dir == Vector3i(0, 0, -1): # Back
		faceVertices = [
			pos + Vector3(0, 0, 0),
			pos + Vector3(1, 0, 0),
			pos + Vector3(1, 1, 0),
			pos + Vector3(0, 1, 0),
		]
	elif dir == Vector3i(0, 0, 1): # Front
		faceVertices = [
			pos + Vector3(1, 0, 1),
			pos + Vector3(0, 0, 1),
			pos + Vector3(0, 1, 1),
			pos + Vector3(1, 1, 1),
		]
	elif dir == Vector3i(-1, 0, 0): # Left
		faceVertices = [
			pos + Vector3(0, 0, 1),
			pos + Vector3(0, 0, 0),
			pos + Vector3(0, 1, 0),
			pos + Vector3(0, 1, 1),
		]
	elif dir == Vector3i(1, 0, 0): # Right
		faceVertices = [
			pos + Vector3(1, 0, 0),
			pos + Vector3(1, 0, 1),
			pos + Vector3(1, 1, 1),
			pos + Vector3(1, 1, 0),
		]

	for i in [0, 1, 2, 0, 2, 3]:
		surfaceTool.set_color(color)
		surfaceTool.add_vertex(faceVertices[i])


#func chunkGeneration(xOffset: int, yOffset: int, zOffset: int) -> void:
	#for x in range(chunkSize):
		#for z in range(chunkSize):
			#for y in range(chunkSize):
				#layerGeneration(x, y, z, xOffset, yOffset, zOffset)
#
#func layerGeneration(x: int, y: int, z: int, xOffset: int, yOffset: int, zOffset: int) -> void:
	##Creation of block and its Texture
	#var block: Block = Block.new()
	#var blockTexture: StandardMaterial3D = StandardMaterial3D.new()
	#
	##Assing block Texture according to its 
	##location Grass on top, the rest is stone (WIP)
	#if y == chunkSize - 1:
		#blockTexture.albedo_color = Color.GREEN
	#else:
		#blockTexture.albedo_color = Color.DIM_GRAY
	#block.texture = blockTexture
	#
	##Add chunkOffset to all coordinates
	#x += chunkSize * xOffset
	#y += chunkSize * yOffset
	#z += chunkSize * zOffset
	#
	##Place block in chunk
	#block.position = Vector3(x, y, z)
	#
	##Make block a child of the Chunk
	#add_child(block)
#
#func faceCulling() -> void:
	#for i in get_children():
		#print(i)
