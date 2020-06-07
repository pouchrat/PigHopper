extends KinematicBody2D

signal revive

var timeup = false
var dead = true

export (int) var run_speed = 200
var velocity = Vector2()

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	velocity.x = 0
	velocity.y = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var up = Input.is_action_just_pressed('ui_up')
	var down = Input.is_action_just_pressed('ui_down')
	
	if !dead:
		if down:
			$AnimatedSprite.frame = 0
			if (position.y + 128 < 576):
				position.y += 128
		if up:
			$AnimatedSprite.frame = 3
			if (position.y - 128) > 0:
				position.y -= 128
		if right:
			$AnimatedSprite.frame = 2
			velocity.x += run_speed
		if left:
			$AnimatedSprite.frame = 1
			velocity.x -= run_speed
	z_index = int(position.y)
	position.x = clamp(position.x, 0, screen_size.x + 88)
	

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _on_WinSquare_winner():
	dead = true
	$AnimatedSprite.frame = 0
	$Bubble.animation = "blowup"
	$Bubble.show()
	$Bubble.play()
	yield(get_tree().create_timer(.5), "timeout")
	$Bubble.stop()
	$Bubble.animation = "music"
	$Bubble.play()
	


func _on_Frogger_revived():
	dead = false
	$Bubble.stop()
	$Bubble.hide()
	$AnimatedSprite.show()
	$AnimatedSprite.frame = 0
	


func _on_Frogger_died():
	dead = true
	$Blink.play("Blink")
	$Bubble.animation = "blowup"
	$Bubble.show()
	$Bubble.play()
	yield(get_tree().create_timer(.5), "timeout")
	$Bubble.stop()
	$Bubble.animation = "death"
	$Bubble.play()
	yield(get_tree().create_timer(.5), "timeout")
	$Blink.stop(true)
	$AnimatedSprite.hide()
	yield(get_tree().create_timer(.5), "timeout")
	$Bubble.hide()
	yield(get_tree().create_timer(.5), "timeout")
	emit_signal("revive")
	
