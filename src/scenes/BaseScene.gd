extends Node2D


var wave=-1
var ennemi_left:=0
var ennemi:=0
var stele_maxlife:=10
var stele_life:=10
var stele_dying:=false
func _ready():
	MusicManager.fade(load("res://assets/music/music.ogg"),0.5,0.5)
	randomize()
	$canvas_layer/affichage/animation_player.connect("animation_finished",self,"affichage_animation_finished")
	$canvas_layer/affichage/anim_title.connect("animation_finished",self,"title_animation_finished")
	$tile_map_mur/stele/health_bar.max_value=stele_maxlife
	$tile_map_mur/stele/health_bar.value=stele_life
func _physics_process(delta):
	if !$tile_map_mur/player.dead:
		$camera_2d.position=lerp($camera_2d.position,($tile_map_mur/player.position+$tile_map_mur/stele.position)/2,10*delta)
	else:
		$camera_2d.position=lerp($camera_2d.position,($tile_map_mur/stele.position),10*delta)
		if stele_life>0:
			if $tile_map_mur/player/timer_respawn.time_left>0:
				$tile_map_mur/stele/health_bar/respawn.text=str(int($tile_map_mur/player/timer_respawn.time_left))
				$tile_map_mur/stele/health_bar/respawn.visible=true
			if $tile_map_mur/player.want_respawn:
				$tile_map_mur/stele/health_bar/respawn.visible=false
				$tile_map_mur/player.respawn()
				$tile_map_mur/player.position=Vector2(512,250)
			
func affichage_animation_finished(anim_name:String):
	
	if wave==0:
		change_wave()

func title_animation_finished(anim_name:String):
	if wave==-1 and anim_name=="close":
		wave=0
		$canvas_layer/affichage/label.text="Protect the stele!"
		$canvas_layer/affichage/animation_player.play("display")

func check_ennemi_left():
	ennemi_left=$tile_map_mur.get_child_count()-2
	if ennemi_left==0 and !stele_dying:
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
		tmp.id=max(0,min(randi()%int(floor(wave/3)+1),2))
		if randi()%2==0:
			tmp.position.x=randi()%1024
			tmp.position.y=randi()%2*600
		else:
			tmp.position.y=randi()%600
			tmp.position.x=randi()%2*1024
		tmp.connect("dead",self,"ennemi_dying")
		$tile_map_mur.add_child(tmp)
	$canvas_layer/affichage/animation_player.play("display")
func ennemi_dying():
	$timer.start(1.0)
func _on_stele_body_entered(body):
	if body is Ennemi:
		if !body.dead:
			stele_life=max(0,stele_life-body.life)
			body.hit(1000)
			var tmp=$tile_map_mur/stele/health_bar.value
			$tween.interpolate_property($tile_map_mur/stele/health_bar, "value", tmp, stele_life, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)    
			$tween.start()
			if stele_life==0:
				if !stele_dying:
					stele_dying=true
					$tile_map_mur/player.dead=true
					$tile_map_mur/stele/animated_sprite.play("destroy")
					print("loose")
					Global.changer_scene("BaseScene",4.0)
					$tile_map_mur/stele/audio_destroy.play()
			else:
				$tile_map_mur/stele/audio_hit.play()
func _input(event):
	if wave==-1 and !$canvas_layer/affichage/anim_title.is_playing():
		if event is InputEventKey or event is InputEventMouseButton:
			$canvas_layer/affichage/anim_title.play("close")
func _on_timer_timeout():
	check_ennemi_left()
	$timer.start(10)

