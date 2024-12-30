extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var is_open: bool = false

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
	animation_player.play("Door_Open")

# Play the close animation
func close() -> void:
	animation_player.play("Door_Close")
	
