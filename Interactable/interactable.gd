class_name Interactable3D
extends Node3D


#let you interact with it
func interact(plr:Player) ->void :
	interaction_result(plr)

#do wathever
func interaction_result(plr:Player) -> void:
	print("collected: ",name)
	queue_free()
