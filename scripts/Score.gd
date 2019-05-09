extends Label

export (int) var paddingLenght = 4

var value = 0

func _ready():
	update()
	
func reset():
	value = 0
	update()
	
func adjust(adjustment):
	value += adjustment
	update()
	
func update():
	get_node("../Score").text = ("SCORE: %0*d" % [paddingLenght, value])