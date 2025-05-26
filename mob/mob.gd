extends RigidBody3D

signal dies

var health = 3
var speed = randf_range(2.0, 4.0)

@onready var hurt_sound = %HurtSound
@onready var die_sound = %DieSound
@onready var bat_model = %bat_model
@onready var timer = %Timer
@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI

func take_damage():
	if health == 0:
		return
	
	bat_model.hurt()
	
	health -= 1
	hurt_sound.play()
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var direction = -global_position.direction_to(player.global_position)
		var random_upward_force = Vector3.UP * randf_range(.5, 2.5)
		apply_central_impulse(direction * 10.0 + random_upward_force)
		timer.start()
		die_sound.play()

func _on_timer_timeout():
	queue_free()
	dies.emit()
