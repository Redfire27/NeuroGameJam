extends RigidBody3D

var mouse_sensitivity := 0.002
#horizontal mouse
var twist_input := 0.0
#vertical mouse
var pitch_input := 0.0

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var animation_player: AnimationPlayer = $TwistPivot/PitchPivot/Camera3D/AnimationPlayer
@onready var fog_player: AnimationPlayer = $"../AnimationPlayer"
var is_animation_playing: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_backward")
	
	apply_central_force(twist_pivot.basis * input * 1200.0 * delta)
	
	#Remnant Scene
	if Input.is_action_just_pressed("Magnifying"):
		animation_player.play("Remnant_scene")
	
	if Input.is_action_just_released("Magnifying"):
		animation_player.play("Remnant_scene", -1, -1, -1)
	
	#Remnant Scene Fog
	if Input.is_action_just_pressed("Magnifying"):
		fog_player.play("Fog")
	
	if Input.is_action_just_released("Magnifying"):
		fog_player.play("Fog", -1, -1, -1)
	
	#Cursor visible on presing Esc
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	#Cursor not visible on left-click
	if Input.is_action_just_pressed("left-click") and Input.mouse_mode == 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#Vertical & Horizontal mouse movement
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
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
