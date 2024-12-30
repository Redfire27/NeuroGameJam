extends Node3D

var is_open: bool = false
@onready var remnant_text: Label3D = $RemnantText
	
func interact(interactor: Interactor) -> void:
	if is_open:
		close()
	else:
		open()

	is_open = !is_open

func open() -> void:
	remnant_text.visible = true
	

func close() -> void:
	remnant_text.visible = false
