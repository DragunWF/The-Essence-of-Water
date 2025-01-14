extends Node2D

const FireballLeft = preload("res://Stuff/Fireball/FireballLeft.tscn")

onready var Position = get_node("Position2D")
onready var FireTime = get_node("FireTime")

func _ready():
	FireTime.set_one_shot(false)
	time_start()

func time_start():
	FireTime.set_wait_time(3)
	FireTime.start()

func _on_FireTime_timeout():
	$FireSound.play()
	var fire = FireballLeft.instance()
	get_parent().add_child(fire)
	fire.set_position(Position.get_global_position())
	time_start()
	FireTime.set_one_shot(true)
