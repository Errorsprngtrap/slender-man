class_name Player
extends CharacterBody3D

@onready var ray: RayCast3D = $Camera3D/RayCast3D
@onready var flashlight: FlashLight = $Flashlight

@export var maxHealth : float = 20
@export var playerUIScreen : Control
var health : float = maxHealth
var minSpeed : float = 10.0
var maxSpeed : float = 60.0
var speed : float = minSpeed
var collectedPages :int = 0
var pagesToCollect : int = 8

func _physics_process(delta: float) -> void:
	#handle movement
	#handle gravity 
	if not is_on_floor() :
		velocity.y += get_gravity().y * delta
	
	#handle direction movement
	var inputDirection : Vector2 = Input.get_vector("left","right","foward","backward")
	var direction :Vector3 = (transform.basis * Vector3(inputDirection.x,0,inputDirection.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else :
		velocity.x = move_toward(velocity.x,0,speed)
		velocity.z = move_toward(velocity.z,0,speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Interact"):
		print("tryed to interact")
		interact()

#handle teh detection of interactable
func interact() -> void : 
	var hit = ray.get_collider()
	print("hit var: ",hit)
	if hit and hit.is_class("Area3D"):
		var object : Interactable3D = hit.get_parent()
		print(hit.name)
		if object and object.has_method("interact") :
			print("method found")
			object.interact(self)

func update_pages()->void:
	if pagesToCollect == collectedPages:
		get_tree().quit()
