extends Area2D

func _on_Spikes_body_entered(body):
	if body.name == "Player":
		body.call("damage_player")
