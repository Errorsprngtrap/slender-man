class_name Slender
extends CharacterBody3D

@onready var tp_timer: Timer = $TPTimer
@export var player : Player
var playerCamera : Camera3D

var currentSlenderRadiusTp : float
var currentSlenderTpCD
var minRad
var maxRad
var collectedPage

var waitPerPage = {
	"0" : {"CD" :120 , "minRad" : 60 , "maxRad" : 120},
	"1" : {"CD" :60 , "minRad" : 60 , "maxRad" : 100},
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
	currentSlenderTpCD = waitPerPage[str(collectedPage)]["CD"]
	minRad = waitPerPage[str(collectedPage)]["minRad"]
	maxRad = waitPerPage[str(collectedPage)]["maxRad"]

func get_tp_point()->Vector3:
	
	return Vector3(0,0,0)
