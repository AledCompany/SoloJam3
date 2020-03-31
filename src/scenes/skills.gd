extends Node

class_name Skills

var id:=0
var cd:=5
var current_cd:=0.0
var ready:=false
var shots:=1
var shot_delay:=0.0
var projectile_id:=0

func _init(newid):
	id=newid
	
	var stat=Bdd.skills[id]
	projectile_id=stat.projectile_id
	cd=stat.cd
	shots=stat.shots
	shot_delay=stat.shot_delay

func _process(delta):
	if !is_zero_approx(current_cd):
		current_cd=max(0.0,current_cd-delta)
	else:
		ready=true

func get_current_cd():
	return current_cd

func use():
	
	current_cd=cd
	ready=false
