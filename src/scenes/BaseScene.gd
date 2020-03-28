extends Node2D


var wave=-1
var ennemi_left:=0
var ennemi:=0
var stele_maxlife:=10
var stele_life:=10
func _ready():
	randomize()
	$canvas_layer/affichage/animation_player.connect("animation_finished",self,"affichage_animation_finished")
	$canvas_layer/affichage/label.text="Game made by Number6406 and Deakcor"
	$canvas_layer/affichage/animation_player.play("display",-1,0.3)
	$tile_map_mur/stele/health_bar.max_value=stele_maxlife
	$tile_map_mur/stele/health_bar.value=stele_life
func _physics_process(delta):
	$camera_2d.position=lerp($camera_2d.position,($tile_map_mur/player.position+$tile_map_mur/stele.position)/2,10*delta)

func affichage_animation_finished(anim_name:String):
	if wave==-1:
		wave=0
		$canvas_layer/affichage/label.text="Protect the stele!"
		$canvas_layer/affichage/animation_player.play("display")
	elif wave==0:
		change_wave()
		

func check_ennemi_left():
	ennemi_left=$tile_map_mur/ennemi_cont.get_child_count()
	if ennemi_left==0:
		change_wave()
	$canvas_layer/affichage.set_ennemi_label(str(ennemi-ennemi_left)+"/"+str(ennemi))
func change_wave():
	stele_life=stele_maxlife
	$tile_map_mur/stele/health_bar.value=stele_life
	wave+=1
	$canvas_layer/affichage/label.text="Wave "+str(wave)
	ennemi=round(sqrt(10+wave))
	ennemi_left=ennemi
	var preload_ennemi=preload("res://scenes/entity/ennemi.tscn")
	$canvas_layer/affichage.set_ennemi_label(str(ennemi-ennemi_left)+"/"+str(ennemi))
	for k in ennemi_left:
		var tmp=preload_ennemi.instance()
		if randi()%2==0:
			tmp.position.x=randi()%1024
			tmp.position.y=randi()%2*600
		else:
			tmp.position.y=randi()%600
			tmp.position.x=randi()%2*1024
		tmp.connect("dead",self,"ennemi_dying")
		$tile_map_mur/ennemi_cont.add_child(tmp)
	$canvas_layer/affichage/animation_player.play("display")
func ennemi_dying():
	$timer.start(0.1)
func _on_stele_body_entered(body):
	if body is Ennemi:
		if !body.dead:
			stele_life=max(0,stele_life-body.life)
			body.hit(1000)
			var tmp=$tile_map_mur/stele/health_bar.value
			$tween.interpolate_property($tile_map_mur/stele/health_bar, "value", tmp, stele_life, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)    
			$tween.start()
			if stele_life==0:
				print("loose")


func _on_timer_timeout():
	check_ennemi_left()
	$timer.start(10)
