class_name Slender
extends CharacterBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var tp_timer: Timer = $TPTimer
@export var player : Player
var playerCamera : Camera3D

var currentSlenderRadiusTp : float
var currentSlenderTpCD
var minRad
var maxRad
var collectedPage

var waitPerPage = {
	"0" : {"CD" :60 , "minRad" : 100 , "maxRad" : 120},
	"1" : {"CD" :60 , "minRad" : 60 , "maxRad" : 105},
	"2" : {"CD" :50 , "minRad" : 60 , "maxRad" : 105},
	"3" : {"CD" :40 , "minRad" : 60 , "maxRad" : 105},
	"4" : {"CD" :35 , "minRad" : 60 , "maxRad" : 105},
	"5" : {"CD" :30 , "minRad" : 60 , "maxRad" : 105},
	"6" : {"CD" :25 , "minRad" : 60 , "maxRad" : 105},
	"7" : {"CD" :20 , "minRad" : 60 , "maxRad" : 105},
	"8" : {"CD" :15 , "minRad" : 60 , "maxRad" : 105},
}

const SPD : float = 3.25

func _ready() -> void:
	currentSlenderTpCD = waitPerPage["0"]["CD"]
	minRad = waitPerPage["0"]["minRad"]
	maxRad = waitPerPage["0"]["maxRad"]
	
	tp_timer.wait_time = currentSlenderTpCD
	tp_timer.autostart = true
	tp_timer.start()
	
	call_deferred("playerRelated")

func playerRelated()->void:
	playerCamera = player.camera_3d
	collectedPage = player.collectedPages

func _physics_process(delta: float) -> void:
	#Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("death"):
		body.death()

func _on_tp_timer_timeout() -> void:
	print("slender teleported")
	global_position = get_tp_point()
	collectedPage = player.collectedPages
	currentSlenderTpCD = waitPerPage[str(collectedPage)]["CD"]
	minRad = waitPerPage[str(collectedPage)]["minRad"]
	maxRad = waitPerPage[str(collectedPage)]["maxRad"]
	tp_timer.wait_time = currentSlenderTpCD

func get_tp_point() -> Vector3:
	var space_state = get_world_3d().direct_space_state
	var half_height : float = (collision_shape.shape as CapsuleShape3D).height / 2.0
	var attempts := 0

	while attempts < 20:
		attempts += 1

		var angle := randf() * TAU
		var dist := randf_range(minRad, maxRad)
		var target_xz := player.global_position + Vector3(cos(angle), 0, sin(angle)) * dist

		var ray_query := PhysicsRayQueryParameters3D.create(
			target_xz + Vector3(0, 50, 0),
			target_xz + Vector3(0, -50, 0)
		)
		ray_query.collision_mask = 2
		var floor_result := space_state.intersect_ray(ray_query)

		if floor_result.is_empty():
			continue

		var stand_position = floor_result.position + Vector3(0, half_height, 0)

		var shape_query := PhysicsShapeQueryParameters3D.new()
		shape_query.shape = collision_shape.shape
		shape_query.transform = Transform3D(Basis(), stand_position)
		shape_query.collision_mask = 2

		if not space_state.intersect_shape(shape_query).is_empty():
			continue

		if playerCamera.is_position_in_frustum(stand_position):
			continue

		return stand_position

	return global_position
