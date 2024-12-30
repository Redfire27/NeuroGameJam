extends Node3D

var is_open: bool = false
@onready var remnant_text: Label3D = $RemnantText

# Called when the interactable item is interacted with
func _on_interactable_interacted(interactor: Interactor) -> void:
	if Input.is_action_just_pressed("interact"):
		remnant_text.visible = not remnant_text.visible
	
	# Toggle the state
	is_open = !is_open

# Play the open animation
func open() -> void:
	remnant_text.visible = not remnant_text.visible

# Play the close animation
func close() -> void:
	remnant_text.visible = not remnant_text.visible
	
