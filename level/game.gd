extends Node3D

var player_score = 0

@onready var mob_spawner_3d = $MobSpawner3D
@onready var score = %Score

func increase_score():
	player_score += 1
	score.text = "Score: " + str(player_score)

func poof(mob_global_position):
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	var do_poof = SMOKE_PUFF.instantiate()
	add_child(do_poof)
	do_poof.global_position = mob_global_position


func _on_mob_spawner_3d_mob_spawned(mob):
	mob.dies.connect(func on_mob_died():
		increase_score()
		poof(mob.global_position)
	)
	poof(mob.global_position)


func _on_kill_plane_body_entered(body):
	get_tree().reload_current_scene.call_deferred()
