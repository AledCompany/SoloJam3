extends Entity


export var id:=0
const main_target:=Vector2(512,300)
var target:=Vector2(512,300)
var state=0
var target_obj=null

func _ready():
	var stat=Bdd.ennemis[id]
	acceleration=stat.acceleration
	speed=stat.speed
	max_life=stat.max_life
	life=max_life

func get_direction() -> Vector2:
	var dir=Vector2.ZERO
	if state==0:
		dir=(target-position).normalized()
	return dir

func dead():
	queue_free()
	
func _process(delta):
	if target_obj!=null:
		target=target_obj.global_position
	else:
		target=main_target

func _on_detection_body_entered(body):
	if state==0:
		if (body is Player) or body.is_in_group("stele"):
			target_obj=body


func _on_detection_body_exited(body):
	if target_obj==body:
		target_obj=null
		for k in $detection.get_overlapping_bodies():
			if state==0:
				if k!=body and ((k is Player) or k.is_in_group("stele")):
					target_obj=k
		

func _on_atk_body_entered(body):
	if body==target_obj:
		state=1


func _on_atk_body_exited(body):
	if body==target_obj:
		state=0
