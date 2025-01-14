extends Area2D

func _ready():
	$AnimatedSprite.play("Idle")

func _on_Goal_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Scenes/Level 2.tscn")
