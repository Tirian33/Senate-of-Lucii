extends Node

var weights = [[50, 0, 50], [70, 0, 30], [30, 0, 70], [40,20,40], [30,40,30]]

## Don't worry abouts: Text for pop up box, current position
## GS: 0 - normal; 1 - win, 2 - Draw, 3 - Lose
##Weights: index of wieghts array
## Gamestate# , Weight#, Textbox Prompt, PathA, PathB, PathC
var scenes = [
	[0, 0, "Enemy Troops are upon our border with EoS. War is all but inevitable. Shall we strike first? \n A: Yes     B: No", 1, -1, -1],
	[2, 0, "", 0, 0, 0]
	
]

var left_to = 0
var mid_to = 0
var right_to = 0
var odds = [0, 0 ,0]
var favor = 3

@onready var textbox = $Senate/Textbox
@onready var senate_preview = $Senate/Senate_Preview
@onready var mid_button = $Senate/Option_Mid
# Called when the node enters the scene tree for the first time.
func _ready():
	render_state(0)
	pass # Replace with function body.

func render_state(state_num):
	if scenes[state_num][0] != 0:
		end_game(scenes[state_num][0])
	
	
	odds = weights[scenes[state_num][1]]
	match scenes[state_num][1]:
		1:
			senate_preview.texture = load("res://70-0-30.png")
		2:
			senate_preview.texture = load("res://30-0-70.png")
		3:
			senate_preview.texture = load("res://40-20-40.png")
		4:
			senate_preview.texture = load("res://30-40-30.png")
		_:
			senate_preview.texture = load("res://50-0-50.png")
	
	
	
	left_to = scenes[state_num][3]
	mid_to = scenes[state_num][4]
	right_to = scenes[state_num][5]
	
	if mid_to == -1:
		mid_button.hide()
	else:
		mid_button.show()
	
	textbox.add_text(scenes[state_num][2])
	
func end_game(win_type):
	textbox.add_text(win_type)
	
	
