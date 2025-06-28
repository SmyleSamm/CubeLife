class_name Block extends CSGBox3D

@export var texture: BaseMaterial3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	use_collision = true
	material_override = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
