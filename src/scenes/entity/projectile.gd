extends KinematicBody2D


var dir:=Vector2.ZERO
var speed:=0


func _ready():
	pass

func _physics_process(delta):
	move_and_slide(dir*speed)



func _on_hitbox_area_entered(area):
	pass # Replace with function body.
