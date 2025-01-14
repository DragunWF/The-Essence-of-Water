extends KinematicBody2D

const MAX_SPEED = 225
const GRAVITY = 20
const TIME_LIMIT = 30
const JUMP_HEIGHT = -330

var motion = Vector2()
var speed = MAX_SPEED
var invincible = false
var airborne = false
var repeat = true
var time = TIME_LIMIT

onready var PlayerSprite = get_node("AnimatedSprite")
onready var GameTime = get_node("GameTime")
onready var InvincibleTime = get_node("InvincibleTime")
onready var GameOverTime = get_node("GameOverTime")
onready var GameOverMenu = get_node("UI/GameOver")

func _ready():
	GameOverMenu.visible = false
	GameOverTime.set_one_shot(false)
	GameTime.set_one_shot(false)
	InvincibleTime.set_one_shot(false)
	GameTime_start()

func _physics_process(delta):
	motion.y += GRAVITY
	get_node("UI/Time/ProgressBar").set_value(time)
	if time <= 0:
		time = 0
	if invincible == true and airborne == false:
		PlayerSprite.play("Damage")
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/Main Menu.tscn")
	if Input.is_key_pressed(KEY_P):
		get_tree().paused = false
	if Input.is_action_pressed("ui_right"):
		PlayerSprite.flip_h = false
		if airborne == false and invincible == false:
			PlayerSprite.play("Walk")
		motion.x = speed
	elif Input.is_action_pressed("ui_left"):
		PlayerSprite.flip_h = true
		if airborne == false and invincible == false:
			PlayerSprite.play("Walk")
		motion.x = -speed
	else:
		if airborne == false and invincible == false:
			PlayerSprite.play("Idle")
		motion.x = 0
	if is_on_floor():
		airborne = false
	if Input.is_action_just_pressed("ui_up"):
		$JumpSound.play()
		airborne = true
		motion.y = JUMP_HEIGHT
		if airborne == true and invincible == false:
			PlayerSprite.play("Jump")
		if airborne == true and invincible == true:
			PlayerSprite.play("JumpDamage")
	motion = move_and_slide(motion, Vector2(0, -1))

func damage_player():
	if invincible == false:
		$DamageSound.play()
		invincible = true
		time -= 5
		invincible_time_start()

func invincible_time_start():
	InvincibleTime.set_wait_time(2)
	InvincibleTime.start()

func _on_InvincibleTime_timeout():
	invincible = false
	InvincibleTime.set_one_shot(true)

func GameTime_start():
	GameTime.set_wait_time(1)
	GameTime.start()

func _on_GameTime_timeout():
	if time == 0 and repeat == true:
		game_over()
		repeat = false
	time -= 1
	GameTime_start()
	GameTime.set_one_shot(false)

func game_over():
	$LoseSound.play()
	GameOverTime.set_wait_time(1)
	GameOverTime.start()

func _on_GameOverTime_timeout():
	get_tree().reload_current_scene()

#Game Over Menu
#func _on_Retry_pressed():
#	get_tree().paused = false
#	get_tree().reload_current_scene()

#func _on_Return_pressed():
#	get_tree().paused = false
#	get_tree().change_scene("res://Scenes/Main Menu.tscn")

