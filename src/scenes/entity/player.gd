extends Entity

func _ready():
	$sprite.play("Idle")

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func _input(event):
	if event.is_action_pressed("dash"):
		dash()
