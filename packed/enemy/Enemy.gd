extends RigidBody2D

var textures = [
    preload("res://assets/images/car1.png"),
    preload("res://assets/images/car2.png"),
    preload("res://assets/images/car3.png"),
    preload("res://assets/images/car4.png"),
    preload("res://assets/images/car5.png"),
    preload("res://assets/images/car6.png")
]

var _player = null
var _speed_factor = 0.5

func _ready():
	var random_texture = textures[rand_range(0,textures.size())]
	get_node("Sprite").set_texture(random_texture)
	_player = get_node("../Player")
	add_to_group("enemy")
	set_process(true)

func _process(delta):
	position = position + Vector2(0, _player.speed * _speed_factor * delta)
	
func hit_by_player():
	set_process(false)
	set_mode(MODE_RIGID)
	set_linear_velocity(Vector2(0,-_player.speed * _speed_factor))