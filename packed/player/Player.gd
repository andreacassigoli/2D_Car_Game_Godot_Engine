extends RigidBody2D

var speed = 0
var turn_speed = 0.015
var _max_speed = 500
var _acceleration = 0

var _direction = 0
var _target_rot = 0

var _car_width = 0

var lives = 3

func _ready():
	_car_width = get_node("Sprite").get_texture().get_size().x
	connect("body_entered",self,"_on_body_entered")
	set_process(true)
	set_process_input(true)

func _input(event):
	_direction = 0
	_target_rot = 0
	
	# gestisco il gioco con la tastiera
	if(event.is_action("ui_left")):
		_direction = -1
		_target_rot = 5
	if(event.is_action("ui_right")):
		_direction = 1
		_target_rot = -5
	if(event.is_action_released("ui_left") or event.is_action_released("ui_right")):
		_direction = 0
		_target_rot = 0
	
	# esco dal gioco
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _process(delta):
	speed += _acceleration
	speed = min(speed,_max_speed)
	if(speed < _max_speed):
		_acceleration += delta
	var new_pos = position + Vector2(_direction * turn_speed * speed,0)
	new_pos = Vector2(clamp(new_pos.x,0,640 - _car_width),new_pos.y)
	position = new_pos
	var rot = lerp(rotation_degrees,_target_rot,0.3)
	rotation_degrees = rot

func _on_body_entered(other):
	if(other.is_in_group("enemy")):
		other.hit_by_player()
	speed = 0
	$CarCrash.play()
	set_process(false)
	lives = lives - 1
	get_node("../GUI/Lives").text = ("LIVES: %d" % lives)
	if lives > 0:
		get_node("../TimerRestart").start()
	else:
		get_node("../GameOver").visible = true