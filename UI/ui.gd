extends Control

@onready var pages_counter: Label = $PagesCounter
@onready var battery_life: Label = $BatteryLife
@export var plr : Player
var flashlight : FlashLight

func _ready() -> void:
	call_deferred("_connectlight")
	
func _connectlight()->void:
	flashlight = plr.flashlight
	flashlight.flashlight_battery_update.connect(updateBattery)
	updateBattery(flashlight.battery)
	
func updateBattery(battery:float) -> void:
	print("yes?")
	battery_life.text = "Battery: %f" %battery

func pagesUpdate(plr:Player)-> void:
	pages_counter.text = "Pages Collected: %d / %d"  % [plr.collectedPages,plr.pagesToCollect]
