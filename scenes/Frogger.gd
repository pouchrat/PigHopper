extends Node2D

# VARIABLES
var win = false
var level = 1
export var levelCount = 2

# SIGNALS
signal died
signal revived


# GAME STATES
func _ready():
	get_tree().call_group("levels", "hide")
	$Pig.hide()
	$Pig.position = $"Levels/Level 0/StartArea".position
	$"Levels/Level 0".show()

func gameStart():
	if level == levelCount && win:
		level = 1
	win = false
	get_node("Levels/Level " + str(level - 1)).hide()
	$Pig.position = $"Levels/Level 1/StartArea".position
	get_node("Levels/Level " + str(level)).show()
	$Pig.show()
	emit_signal("revived")

func nextLevel():
	win = false
	get_node("Levels/Level " + str(level)).hide()
	level+=1
	get_node("Levels/Level " + str(level)).show()
	$Pig.position = get_node("Levels/Level " + str(level) + "/StartArea").position
	$Pig.show()
	emit_signal("revived")

func gameOver():
	emit_signal("died")

func winGame():
	win = true
	yield(get_tree().create_timer(1),"timeout")
	$Pig.hide()
	if level != levelCount:
		nextLevel()
	else: _ready()


# SIGNAL HANDLERS
func _on_DeathTimer_timeout():
	if win == false: gameOver()

func _on_Platform_fromArea():
	$DeathTimer.start()
	
func _on_Platform_inArea():
	yield(get_tree().create_timer(0.2), "timeout")
	$DeathTimer.stop()

func _on_WinSquare_winner():
	winGame()


# UNHANDLED INPUTS
func _unhandled_input(_event):
	# RESTART
	if Input.is_action_pressed("restart"):
		gameStart()
	# START / NEXT LEVEL
	if Input.is_action_pressed("ui_select"):
		gameStart()
	# QUIT
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_Pig_revive():
	gameStart()
