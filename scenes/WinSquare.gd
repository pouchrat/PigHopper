extends Node2D
signal winner



func _on_PlatformBody_body_entered(body):
	emit_signal("winner")
	get_tree().call_group("pfListeners", "_on_WinSquare_winner")
