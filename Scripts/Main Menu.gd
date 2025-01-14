extends Control

onready var StartMenu = get_node("StartMenu")
onready var AboutMenu = get_node("AboutMenu")

func _ready():
	StartMenu.visible = true
	AboutMenu.visible = false

func _process(delta):
	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()

#Start Menu
func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Level 1.tscn")

func _on_SelectLevel_pressed():
	$Click.play()

func _on_About_pressed():
	$Click.play()
	StartMenu.visible = false
	AboutMenu.visible = true

func _on_Quit_pressed():
	get_tree().quit()

#About
func _on_Return_pressed():
	$Click.play()
	AboutMenu.visible = false
	StartMenu.visible = true
