extends Node3D

var is_open: bool = false
@onready var remnant_text: Label3D = $RemnantText
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the interactable item is interacted with
func _on_interactable_interacted(interactor: Interactor) -> void:
	if Input.is_action_just_pressed("interact"):
		animation_player.play("Think")
	
	# Toggle the state
	is_open = !is_open

# Play the open animation
func open() -> void:
	pass

# Play the close animation
func close() -> void:
	pass
	
