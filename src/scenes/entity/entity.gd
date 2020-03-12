extends KinematicBody2D

class_name Entity

const G=9.81

var acceleration:=10
var speed:=100

var dash_power:=6
var dash_dec:=6
var time_dash:=0.5
var time_dash_recover:=0.2
var can_dash:=true
var dashing:=false

var atking:=false

var _velocity:= Vector2.ZERO
var _look_dir:=Vector2.RIGHT
export var _height:=0.0

func get_direction() -> Vector2:
	return Vector2.ZERO
	
func _physics_process(delta: float) -> void:
	var dir:=get_direction().normalized()
	if !dashing and !atking:
		_velocity = lerp(_velocity,speed*dir,acceleration*delta)
	elif dashing:
		_velocity=lerp(_velocity,Vector2.ZERO,delta*dash_dec)
	move_and_slide(_velocity)
	animation()

func animation():
	$sprite.position.y=-_height

func dash():
	var dir:=get_direction()
	if can_dash and !dashing:
		atking=false
		if dir!=Vector2.ZERO:
			_velocity=dir.normalized()*speed*dash_power
			dashing=true
			can_dash=false
			$animation_player.play("dash")
			$timer_dash.start(time_dash)


func _on_timer_dash_timeout():
	if dashing:
		dashing=false
		$timer_dash.start(time_dash_recover)
	else:
		can_dash=true
