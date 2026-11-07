extends AnimatableBody3D

@export var ar_view: ARView
@export var move_sensitivity = 5


func _physics_process(_delta):
	var xr_pos = ar_view.camera.global_position

	global_position = Vector3(
		-xr_pos.x * move_sensitivity,
		xr_pos.y * move_sensitivity,
		global_position.z,
	)
