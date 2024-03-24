extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label
@onready var prior_box = $PriorVote
@onready var prior_vote = $PriorVote/MarginContainer/HBoxContainer/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	prior_box.hide()
	pass # Replace with function body.
	
func restart():
	prior_box.hide()

func hide_textbox():
	label.text=""
	textbox_container.hide()

func add_text(new_text:String):
	label.text = new_text
	textbox_container.show()

func add_vote_result(new_text:String):
	prior_vote.text = new_text
	prior_box.show()
