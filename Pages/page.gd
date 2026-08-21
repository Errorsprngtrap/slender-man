class_name Pages
extends Interactable3D

var clickedAlready : bool = false
func interaction_result(plr:Player) -> void:
	if clickedAlready == false :
		clickedAlready = true
		plr.collectedPages += 1
		plr.playerUIScreen.pagesUpdate(plr)
		plr.update_pages()
		queue_free()
