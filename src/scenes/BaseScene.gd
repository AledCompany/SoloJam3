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


func _physics_process(delta):
	$camera_2d.position=lerp($camera_2d.position,($tile_map_mur/player.position+$tile_map_mur/stele.position)/2,10*delta)

func affichage_animation_finished(anim_name:String):
	if wave==-1:
		wave=0
		$canvas_layer/affichage/label.text="Protect the stele!"
		$canvas_layer/affichage/animation_player.play("display")
	elif wave==0:
		change_wave()
		$canvas_layer/affichage/animation_player.play("display")

func check_ennemi_lef():
	ennemi_left=$tile_map_mur/ennemi_cont.get_child_count()
	if ennemi_left==0:
		change_wave()
	$canvas_layer/affichage/ennemi.text=str(ennemi-ennemi_left)+"/"+str(ennemi)
func change_wave():
	stele_life=stele_maxlife
	wave+=1
	$canvas_layer/affichage/label.text="Wave "+str(wave)
	ennemi=sqrt(10+wave)
	ennemi_left=ennemi
	var preload_ennemi=preload("res://scenes/entity/ennemi.tscn")
	$canvas_layer/affichage/ennemi.text=str(ennemi-ennemi_left)+"/"+str(ennemi)
	for k in ennemi_left:
		var tmp=preload_ennemi.instance()
		if randi()%2==0:
			tmp.position.x=randi()%1024
			tmp.position.y=randi()%2*600
		else:
			tmp.position.y=randi()%600
			tmp.position.x=randi()%2*1024
		add_child(tmp)


func _on_stele_body_entered(body):
	if body is Ennemi:
		stele_life=max(0,stele_life-body.life)
		if stele_life==0:
			print("loose")
