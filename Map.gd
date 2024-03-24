extends TextureRect

@onready var p0 = $P0
@onready var p1 = $P1
@onready var p2 = $P2
@onready var p3 = $P3
@onready var p4 = $P4
@onready var p5 = $P5
@onready var p6 = $P6
@onready var p7 = $P7

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_image(image_rect, new_pic_id, base_text):
	match new_pic_id:
		-4:
			image_rect.texture = load("res://images/Plauged-region.png")
			image_rect.tooltip_text = base_text + "(Plaugestriken-No military actions possible)"
			image_rect.show()
		-3:
			image_rect.texture = load("res://images/Enemy-plauge.png")
			image_rect.tooltip_text = base_text + "(Enemy Occupied-Plauged)"
			image_rect.show()
		-2:
			image_rect.texture = load("res://images/Enemy-2.png")
			image_rect.tooltip_text = base_text + "(Enemy Occupied Strongly)"
			image_rect.show()
		-1:
			image_rect.texture = load("res://images/Enemy.png")
			image_rect.tooltip_text = base_text + "(Enemy Occupied)"
			image_rect.show()
		0:
			image_rect.texture = load("res://images/Jester-of-Nil.png")
			image_rect.tooltip_text = base_text + "(Unoccupied)"
			image_rect.show()
		1:
			image_rect.texture = load("res://images/Owned.png")
			image_rect.tooltip_text = base_text + "(Friendly Occupied)"
			image_rect.show()
		2:
			image_rect.texture = load("res://images/Owned-2.png")
			image_rect.tooltip_text = base_text + "(Friendly Occupied Strongly)"
			image_rect.show()
		3:
			image_rect.texture = load("res://images/Owned-plauge.png")
			image_rect.tooltip_text = base_text + "(Friendly Occupied-Plauged-Cannot act in tandem)"
			image_rect.show()

func next_state(arr):
	if p0.get_meta("occupant") != arr[0]:
		p0.set_meta("occupant", arr[0])
		update_image(p0, arr[0], "Enemy Capital ")
	if p1.get_meta("occupant") != arr[1]:
		p1.set_meta("occupant", arr[1])
		update_image(p1, arr[1], "Enemy Encampment ")
	if p2.get_meta("occupant") != arr[2]:
		p2.set_meta("occupant", arr[2])
		update_image(p2, arr[2], "Enemy Mountains ")
	if p3.get_meta("occupant") != arr[3]:
		p3.set_meta("occupant", arr[3])
		update_image(p3, arr[3], "Enemy Farmlands ")
	if p4.get_meta("occupant") != arr[4]:
		p4.set_meta("occupant", arr[4])
		update_image(p4, arr[4], "Our Mountains ")
	if p5.get_meta("occupant") != arr[5]:
		p5.set_meta("occupant", arr[5])
		update_image(p5, arr[5], "Our Farmlands ")
	if p6.get_meta("occupant") != arr[6]:
		p6.set_meta("occupant", arr[6])
		update_image(p6, arr[6], "Our Encampment ")
	if p7.get_meta("occupant") != arr[7]:
		p7.set_meta("occupant", arr[7])
		update_image(p7, arr[7], "Our Capital ")
	
	
