extends Node2D


var wave=0
var ennemi_left=0

func _ready():
	$canvas_layer/affichage/animation_player.connect("animation_finished",self,"affichage_animation_finished")
	$canvas_layer/affichage/label.text="Survive!"
	$canvas_layer/affichage/animation_player.play("display")


func _physics_process(delta):
	$camera_2d.position=lerp($camera_2d.position,$tile_map_mur/player.position,10*delta)

func affichage_animation_finished(anim_name:String):
	if wave==0:
		change_wave()
		$canvas_layer/affichage/animation_player.play("display")

func check_ennemi_lef():
	ennemi_left=$tile_map_mur/ennemi_cont.get_child_count()
	if ennemi_left==0:
		change_wave()

func change_wave():
	
	wave+=1
	$canvas_layer/affichage/label.text="Wave "+str(wave)
	ennemi_left=10+wave
