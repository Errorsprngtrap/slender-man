class_name Battery
extends Interactable3D

@export var recharge : float = 100.0

func interaction_result(plr:Player) -> void:
	plr.flashlight.add_battery(recharge)
	queue_free()
