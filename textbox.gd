extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hide_textbox():
	label.text=""
	textbox_container.hide()

func show_textbox():
	textbox_container.show()

func add_text(new_text):
	label.text = new_text
	show_textbox()
