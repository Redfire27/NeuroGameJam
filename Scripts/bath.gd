extends Node3D

var is_open: bool = false
@onready var bath_text: Label3D = $RemnantText

# Called when the interactable item is interacted with
func _on_interactable_interacted(interactor: Interactor) -> void:
	if is_open:
		close()
	else:
		open()
	
	# Toggle the state
	is_open = !is_open

# Play the open animation
func open() -> void:
	bath_text.visible = not bath_text.visible

# Play the close animation
func close() -> void:
	bath_text.visible = not bath_text.visible
	
