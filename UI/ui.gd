extends Control

@onready var pages_counter: Label = $PagesCounter
@onready var battery_life: Label = $BatteryLife

func updateBattery(plr:Player) -> void:
	battery_life.text = "Battery: %f" %plr.flashlight.battery

func pagesUpdate(plr:Player)-> void:
	pages_counter.text = "Pages Collected: %d / %d"  % [plr.collectedPages,plr.pagesToCollect]
