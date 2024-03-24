extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	$Title.hide()
	$game.render_state(0)


func _on_quit_button_pressed():
	get_tree().quit()
