extends Area3D

class_name Interactable

signal focused(interactor: Interactor)
signal unfocused(interactor: Interactor)
signal interacted(interactor: Interactor)

@export var linked_interactable_path: NodePath
@onready var linked_interactable: Interactable = get_node_or_null(linked_interactable_path)

var is_locked: bool = false

func interact(interactor: Interactor) -> void:
	if is_locked:
		return # Do nothing if this interactable is locked
	
	# Trigger specific action for this interactable
	perform_action(interactor)
	
	# Lock the linked interactable
	if linked_interactable:
		linked_interactable.lock()
		

func lock() -> void:
	is_locked = true

func unlock() -> void:
	is_locked = false

func perform_action(interactor: Interactor) -> void:
	# Override this method in child classes for specific actions
	pass
