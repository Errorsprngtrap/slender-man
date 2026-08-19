class_name FlashLight extends Node

@export var battery : float = 100.0
var flashlightOn : bool = false
var light : SpotLight3D

func  _ready() -> void:
	light = $FlashLightL
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("flashlight") and battery > 0 :
		print("space")
		flashlightOn = not flashlightOn
		if flashlightOn :
			print("on")
			light.light_energy = 1
		else :
			light.light_energy = 0
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if 0 >= battery :
		light.light_energy = 0
		
	if flashlightOn and battery > 0:
		battery -= .0001
		
