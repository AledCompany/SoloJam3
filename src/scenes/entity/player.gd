extends Entity

class_name Player

var want_respawn=false
var press=[0,0]

func _ready():
	acceleration=100
	speed=100
	max_life=5
	life=5
	$sprite.play("Idle")
	$health_bar.max_value=max_life
	$health_bar.value=max_life
	for k in range(0,3):
		skills.append(Skills.new(k))

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
func dash():
	var dir:=get_direction()
	if can_dash and !dashing and !dead:
		atking=false
		if dir!=Vector2.ZERO:
			_velocity=dir.normalized()*speed*dash_power
			dashing=true
			can_dash=false
			$animation_player.play("dash")
			$timer_dash.start(time_dash)
	$audio_dash.play()
func _input(event):
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("atk1"):
		press[0]=1
	if event.is_action_released("atk1"):
		press[0]=0
		use_skill(0)
	if event.is_action_pressed("atk2"):
		press[1]=1
	if event.is_action_released("atk2"):
		press[1]=0
		use_skill(1)
	if press[0]==1 and press[1]==1:
		use_skill(2)

func get_target_position():
	return(get_global_mouse_position())

func _physics_process(delta):
	if position.x>1024-16:
		 position.x=1024-16
	if position.y>600-16:
		 position.y=600-16
	if position.x<0+16:
		 position.x=0+16
	if position.y<0+16:
		 position.y=0+16
	if dead:
		$canvas_modulate.color=lerp($canvas_modulate.color,Color(0.5,0.5,0.5,0.5),delta)
	else:
		$canvas_modulate.color=lerp($canvas_modulate.color,Color(1,1,1,1),delta*2)
func _process(delta):
	$health_bar.value=life
	for k in range(0,skills.size()):
		skills[k]._process(delta)
		if skills[k].ready:
			$canvas_layer/hud/h_box_container.get_child(k).self_modulate=Color(1,1,1,1)
			$canvas_layer/hud/h_box_container.get_child(k).get_node("label").visible=false
		else:
			$canvas_layer/hud/h_box_container.get_child(k).get_node("label").visible=true
			$canvas_layer/hud/h_box_container.get_child(k).self_modulate=Color(0.1,0.1,0.1,0.1)
			$canvas_layer/hud/h_box_container.get_child(k).get_node("label").text=str(ceil(skills[k].current_cd))
func dead():
	$timer_respawn.start()
	
func respawn():
	$sprite.scale=Vector2.ONE
	want_respawn=false
	max_life=5
	life=5
	$sprite.play("Idle")
	$health_bar.max_value=max_life
	dead=false
func _on_timer_respawn_timeout():
	want_respawn=true
