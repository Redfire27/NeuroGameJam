extends Node3D

var is_open: bool = false
@onready var remnant_text: Label3D = $RemnantText

func _on_interactable_interacted(interactor: Interactor) -> void:
	if is_open:
		close()
	else:
		open()

	is_open = !is_open

func open() -> void:
	get_tree().change_scene_to_file("res://Scenes/victory.tscn")
	

func close() -> void:
	return
