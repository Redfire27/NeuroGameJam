extends Node3D

var is_open: bool = false
@onready var remnant_text: Label3D = $RemnantText

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
	pass

# Play the close animation
func close() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		remnant_text.visible = not remnant_text.visible
