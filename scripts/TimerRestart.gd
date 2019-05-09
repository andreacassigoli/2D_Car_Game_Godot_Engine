extends Timer

func _ready():
	connect("timeout",self,"_on_timeout")
	
func _on_timeout():
	# riparto dall'ultima collisione
	get_node("../Player").set_process(true)
	# riparto con la scena iniziale
	#get_tree().change_scene("res://scenes/game.tscn")