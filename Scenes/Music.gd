extends AudioStreamPlayer

func _ready() -> void:
	play()  # Start playback
	set_process(true)  # Enable process to check playback state

func _process(_delta: float) -> void:
	if not is_playing():
		play()  # Restart playback when the audio finishes
