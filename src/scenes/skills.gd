extends Node

class_name Skills

var id:=0
var cd:=5
var current_cd:=0.0
var ready:=false

func _init(newid):
	id=newid
	var stat=Bdd.skills[id]
	cd=stat.cd

func _process(delta):
	if !is_zero_approx(current_cd):
		current_cd=max(0.0,current_cd-delta)
	else:
		ready=true

func get_current_cd():
	return current_cd
