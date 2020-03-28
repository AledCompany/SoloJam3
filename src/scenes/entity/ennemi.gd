extends Entity

signal dead

class_name Ennemi
export var id:=0
const main_target:=Vector2(512,300)
var target:=Vector2(512,300)
var state=0
var target_obj=null
var flying=false

func _ready():
	var stat=Bdd.ennemis[id]
	acceleration=stat.acceleration
	speed=stat.speed
	max_life=stat.max_life
	life=max_life
	$detection/collision_shape_2d.shape.radius=stat.detection_radius
	$atk/collision_shape_2d.shape.radius=stat.atk_radius
	flying=stat.flying
	$collision.shape.extents=stat.collision
	$hitbox/collision_shape_2d.shape.extents=stat.hitbox
	$sprite.frames=load(stat.sprite)
func get_direction() -> Vector2:
	var dir=Vector2.ZERO
	if state==0:
		dir=(target-position).normalized()
	return dir

func dead():
	queue_free()
	emit_signal("dead")
func _process(delta):
	if target_obj!=null:
		target=target_obj.global_position
	else:
		target=main_target

func _on_detection_body_entered(body):
	if state==0:
		if (body is Player):
			target_obj=body


func _on_detection_body_exited(body):
	if target_obj==body:
		target_obj=null
		

func _on_atk_body_entered(body):
	if body==target_obj:
		state=1


func _on_atk_body_exited(body):
	if body==target_obj:
		state=0
