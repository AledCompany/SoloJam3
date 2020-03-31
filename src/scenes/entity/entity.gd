extends KinematicBody2D

class_name Entity

const G=9.81

var acceleration:=100
var speed:=100
var max_life:=5

var dash_power:=4
var dash_dec:=6
var time_dash:=0.5
var time_dash_recover:=0.2
var can_dash:=true
var dashing:=false
var life:=5
var dead:=false
var atking:=false
var flying=0


var shots=[]
var skills=[]

var _velocity:= Vector2.ZERO
var _look_dir:=Vector2.RIGHT
export var _height:=0.0

func get_direction() -> Vector2:
	return Vector2.ZERO

func get_target_position() -> Vector2:
	return Vector2.ZERO

func _physics_process(delta: float) -> void:
	if !dead:
		var dir:=get_direction().normalized()
		if !dashing and !atking:
			_velocity = lerp(_velocity,speed*dir,acceleration*delta)
		elif dashing:
			_velocity=lerp(_velocity,Vector2.ZERO,delta*dash_dec)
		move_and_slide(_velocity)
		animation()

func animation():
	$sprite.position.y=-_height
	$shadow.scale=Vector2.ONE*(1-_height/32)
	var dir=get_direction()
	if  self.is_in_group("player"):
		if dashing:
			$sprite.play("Dash")
		elif dir== Vector2.ZERO :
			$sprite.play("Idle")
		else :
			$sprite.play("Run")
		
	if dir.x>0:
		$sprite.flip_h=false
	elif dir.x<0:
		$sprite.flip_h=true



func use_skill(index:int=0):
	if skills[index].ready and $timer_shotdelay.time_left==0:
		skills[index].use()
		for k in skills[index].shots:
			if skills[index].shot_delay==0:
				spawn_projectile(skills[index].projectile_id)
			else:
				shots.push_back(skills[index].projectile_id)
		if skills[index].shot_delay!=0:
			spawn_projectile(skills[index].projectile_id)
			$timer_shotdelay.start(skills[index].shot_delay)

func _on_timer_shotdelay_timeout():
	spawn_projectile(shots.pop_front(),false)
	if shots.size()>0:
		$timer_shotdelay.start()

func spawn_projectile(id:int=0,withsound=true):
	var tmp=preload("res://scenes/entity/projectile.tscn").instance()
	tmp.init(id,get_instance_id(),withsound)
	tmp.global_position=global_position
	tmp.dir=(get_target_position()-global_position).normalized()
	get_parent().add_child(tmp)

func hit(dmg:int):
	if !dead:
		
		life=max(0,life-dmg)
		if life==0:
			dead=true
			$animation_player.play("die")
		$audio_hit.play()
		$anim_dmg.play("dmg")

func dead():
	pass

func _on_timer_dash_timeout():
	if dashing:
		dashing=false
		$timer_dash.start(time_dash_recover)
	else:
		can_dash=true



