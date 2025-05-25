extends RigidBody3D

@onready var bat_model = %bat_model


func take_damage():
	bat_model.hurt()
