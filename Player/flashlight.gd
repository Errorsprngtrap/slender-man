class_name FlashLight extends Node3D

@export var battery : float = 100.0
var flashlightOn : bool = false
var light : SpotLight3D

signal flashlight_battery_update(battery:float)

func  _ready() -> void:
	light = $FlashLightL
	flashlight_battery_update.emit(battery)
	
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
		flashlightOn = false
		
	if flashlightOn and battery > 0:
		battery -= .1
		flashlight_battery_update.emit(battery)
		
func add_battery(amount:float)->void:
	print('battry gave back: ',amount," lamp was at : ",battery)
	if battery + amount > 100:
		battery = 100
	else:
		battery += amount
	print('battry is now back: ',amount," lamp was at : ",battery)
	flashlight_battery_update.emit(battery)
