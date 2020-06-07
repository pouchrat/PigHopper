extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TitleFade_animation_finished(anim_name):
	$ToStartBlink.play("blink")


func _on_Level_0_hide():
	$TitleFade.stop()
	$ToStartBlink.stop()


func _on_Level_0_draw():
	$TitleFade.play("fade")
