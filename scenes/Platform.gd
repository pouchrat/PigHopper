extends Node2D
signal inArea
signal fromArea

export var moveable = false
var moving = false
var moveRight = true
export var speed = 200
export var startArea = false

export var xL = 0
export var xR = 896


# Called when the node enters the scene tree for the first time.
func _ready():
	if startArea:
		$TileMap.hide()


func _physics_process(delta):
	if moveable:
		if moving:
			if moveRight:
				if position.x < xR:
					position.x += speed * delta
				else: moveRight = false
			elif !moveRight:
				if position.x > xL:
					position.x -= speed * delta
				else: moveRight = true



func _on_PlatformBody_body_exited(_body):
	emit_signal("fromArea")
	get_tree().call_group("pfListeners","_on_Platform_fromArea")

func _on_PlatformBody_body_entered(_body):
	emit_signal("inArea")
	get_tree().call_group("pfListeners","_on_Platform_inArea")


func _on_Platform_hide():
	if moveable: moving = false
	$PlatformBorder.set_collision_layer_bit(0,false)
	$PlatformBorder.set_collision_mask_bit(0,false)
	$PlatformBody.set_collision_layer_bit(0,false)
	$PlatformBody.set_collision_mask_bit(0,false)


func _on_Platform_draw():
	if moveable: moving = true
	$PlatformBorder.set_collision_layer_bit(0,true)
	$PlatformBorder.set_collision_mask_bit(0,true)
	$PlatformBody.set_collision_layer_bit(0,true)
	$PlatformBody.set_collision_mask_bit(0,true)
