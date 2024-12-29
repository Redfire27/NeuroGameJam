extends Interactor

@export var player: CharacterBody3D

var cached_closest: Interactable

func _ready() -> void:
	controller = player
	
func _physics_process(_delta: float) -> void:
	var new_closest: Interactable = get_closest_interactable()
	if new_closest != cached_closest:
		if is_instance_valid(cached_closest):
			unfocus(cached_closest)
			
			cached_closest = null

		if new_closest:
			focus(new_closest)

		cached_closest = new_closest
		
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if is_instance_valid(cached_closest):  # Ensure validity before interacting
			interact(cached_closest)
		else:
			print("Cannot interact: cached_closest is invalid.")
			cached_closest = null  # Reset reference if invalid

func _on_area_exited(area: Interactable) -> void:
	if cached_closest == area:
		if is_instance_valid(area):
			unfocus(area)
		cached_closest = null  # Reset cached_closest if the area exited
