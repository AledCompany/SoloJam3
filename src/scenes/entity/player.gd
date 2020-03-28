extends Entity

class_name Player

func _ready():
	acceleration=100
	speed=100
	max_life=5
	life=5
	$sprite.play("Idle")
	$health_bar.max_value=max_life
	for k in range(0,3):
		skills.append(Skills.new(0))

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func _input(event):
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("atk1"):
		pass
func _physics_process(delta):
	if position.x>1024-16:
		 position.x=1024-16
	if position.y>600-16:
		 position.y=600-16
	if position.x<0+16:
		 position.x=0+16
	if position.y<0+16:
		 position.y=0+16

func _process(delta):
	$health_bar.value=life
	for k in range(0,skills.size()):
		skills[k]._process(delta)
		if skills[k].ready:
			$canvas_layer/hud/h_box_container.get_child(k).self_modulate=Color(1,1,1,1)
		else:
			$canvas_layer/hud/h_box_container.get_child(k).self_modulate=Color(0.1,0.1,0.1,0.1)
			$canvas_layer/hud/h_box_container.get_child(k).get_node("label").text=ceil(skills[k].current_cd)
func dead():
	pass
