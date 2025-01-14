extends Area2D

const SPEED = 250

var motion = Vector2()
var moving = true

onready var FireSprite = get_node("AnimatedSprite")

func _ready():
	FireSprite.play("Fire")

func _physics_process(delta):
	if moving == true:
		motion.x -= SPEED
	motion = motion.normalized() * SPEED
	position += motion * delta
	if moving == false:
		motion.x = 0

func _on_FireballLeft_body_entered(body):
	if body.has_method("damage_player"):
		body.call("damage_player")
	queue_free()
