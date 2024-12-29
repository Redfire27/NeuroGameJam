extends CanvasLayer


func _on_button_pressed() -> void:
	print("Start Game pressed!")
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")


func _on_button_2_pressed() -> void:
	print("Quit pressed!")
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()
