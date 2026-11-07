extends Node

@onready var ar_view = $ARView
const SERVER_ID: int = 1

var ar_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	if multiplayer.is_server():
		return

	if OS.has_feature("ios"):
		ar_view.Backend.ARKIT
	else:
		ar_view.Backend.ARCORE


func _physics_process(_delta: float) -> void:
	if multiplayer.is_server():
		return

	if ar_view.applied_packet == null:
		return

	ar_position = Vector2(ar_view.applied_packet.camera_transform.origin)
	_set_coordinates.rpc_id(SERVER_ID, ar_position)


@rpc("any_peer", "call_remote", "unreliable")
func _set_coordinates(position: Vector2) -> void:
	if not multiplayer.is_server():
		return

	# DON'T FORGET TO FINISH
