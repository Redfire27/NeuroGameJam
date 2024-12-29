extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var is_open: bool = false


func open() -> void:
	if Input.is_action_just_pressed("interact"):
		animation_player.play("Open")


func close() -> void:
	if Input.is_action_just_pressed("interact"):
		animation_player.play("Close")



func _on_interactable_interacted(interactor: Interactor) -> void:
	if not is_open:
		$Interactable.queue_free()
		open()
