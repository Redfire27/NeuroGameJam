extends CharacterBody3D

var mouse_sensitivity := 0.002
# Horizontal mouse
var twist_input := 0.0
# Vertical mouse
var pitch_input := 0.0

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var animation_player: AnimationPlayer = $TwistPivot/PitchPivot/Camera3D/AnimationPlayer
@onready var fog_player: AnimationPlayer = $"../AnimationPlayer"
var is_animation_playing: bool = false
var interactable_remnant = null

var speed: float = 3.0  # Movement speed
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Movement input
	var input_direction = Vector3(
		Input.get_axis("move_left", "move_right"),
		0.0,
		Input.get_axis("move_forward", "move_backward")
	)
	
	input_direction = input_direction.normalized()
	if input_direction != Vector3.ZERO and !audio_stream_player.is_playing():
		audio_stream_player.play()
	elif input_direction == Vector3.ZERO and audio_stream_player.is_playing():
		audio_stream_player.stop()
		
	# Transform direction based on camera orientation
	if input_direction != Vector3.ZERO:
		
		var direction = twist_pivot.basis * input_direction
		direction = direction.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0
		velocity.z = 0

	# Apply gravity
	velocity.y -= gravity * delta

	# Move the character
	move_and_slide()

	# Remnant Scene
	if Input.is_action_just_pressed("Magnifying"):
		animation_player.play("Remnant_scene")

	if Input.is_action_just_released("Magnifying"):
		animation_player.play("Remnant_scene", -1, -1, -1)

	# Remnant Scene Fog
	if Input.is_action_just_pressed("Magnifying"):
		fog_player.play("Fog")

	if Input.is_action_just_released("Magnifying"):
		fog_player.play("Fog", -1, -1, -1)

	# Cursor visibility toggle
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if Input.is_action_just_pressed("left-click") and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# Mouse look
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-75),
		deg_to_rad(75)
	)
	twist_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * mouse_sensitivity
			pitch_input = -event.relative.y * mouse_sensitivity
			
