extends CanvasLayer
signal start_game
signal end_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_play_button_pressed():
	start_game.emit()


func _on_quit_button_pressed():
	end_game.emit()
