class_name Player_Camera
extends Camera3D

@export var sensibility : float = 0.002
var player : Player

#set up the camera mode
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player = get_parent()

#take into account player input 
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		
		player.rotate_y(-event.relative.x * sensibility)
		rotate_x(-event.relative.y * sensibility)
	
	if Input.is_action_just_pressed("escape"):
			print("detected escape key")
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
	if event is InputEventMouseMotion and event.is_pressed():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
