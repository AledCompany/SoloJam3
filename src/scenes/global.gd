extends Node

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func changer_scene(nom_scene,speed=0.5):
	get_tree().get_root().set_disable_input(true)
	var transition=preload("res://scenes/hud/transition.tscn").instance()
	transition.init(nom_scene,true,speed)
	get_parent().get_child(0).add_child(transition)
