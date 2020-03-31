extends KinematicBody2D


var dir:=Vector2.ZERO
var speed:=0
var id:=0
var dmg:=1
var idowner
var lifetime:=1.0
var flying:=0
var withsound=true
var rotate=true

func init(newid,newowner,newwithsound):
	id=newid
	var stat=Bdd.projectiles[id]
	speed=stat.speed
	dmg=stat.dmg
	idowner=newowner
	$animated_sprite.frames=load(stat.sprite)
	if stat.audio!="":
		$audio.stream=load(stat.audio)
	else:
		newwithsound=false
	$animated_sprite.play("default")
	flying=stat.flying
	lifetime=(stat.lifetime)
	rotate=stat.rotate
	$animated_sprite.position.y+=stat.offsety
	$hitbox/collision_shape_2d.shape.extents=stat.hitbox
	withsound=newwithsound
func _ready():
	$timer_destroy.start(lifetime)
	if withsound:
		$audio.play()
func _physics_process(delta):
	if rotate:
		rotation=Vector2(0,-1).angle_to(dir)
	move_and_slide(dir*speed)



func _on_hitbox_area_entered(area):
	if area.is_in_group("hitbox"):
		var body=area.get_parent()
		if body.get_instance_id()!=idowner and flying>=body.flying:
			body.hit(dmg)



func _on_timer_destroy_timeout():
	queue_free()
