extends Area2D
export var max_speed = 48  # How fast the player will move (pixels/sec).
var max_y_speed = max_speed / 2
var max_x_speed = max_speed / 2
var accelration = 10
var deceleration = 5
var player_collisions = [0,0,0,0]
var player_direction = 0
var top_collision =0
var bottom_collision =0
var left_collision =0
var right_collision =0
#Player input array: [up, down, left, right, interact]
var player_input = [0,0,0,0,0]
var locked_input_state = [0,0,0,0,0]
var interact_lock = 0

var screen_size  # Size of the game window.
var velocity = Vector2()
var add_velocity = Vector2()

#signals
signal interact

#hello world 


# Called when the node enters the scene tree for the first time.

func _ready():
	EventController.connect("move_player", self, "move_player")

func get_input():
	player_input = [Input.is_action_pressed("ui_up"),Input.is_action_pressed("ui_down"),Input.is_action_pressed("ui_left"),Input.is_action_pressed("ui_right"),Input.is_action_pressed("ui_accept")]
	PlayerController.emit_signal("player_input", player_input)
	
func move_player(direction):
	add_velocity = direction
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	
####Clean up this mess later, entire script should be converted to used input and collision arrays

	player_collisions = [top_collision, bottom_collision, left_collision, right_collision]
	
###############Prevent player from moving if interacting with tile############
	#print(player_input)
	if interact_lock == 0:
		if player_collisions[player_direction] && player_input[4]:
			print("locking input")
			locked_input_state = [0,0,0,0,1]
			interact_lock = 1
		else:
			locked_input_state = player_input
			#print(locked_input_state)
	else:
		if player_input[4]:
			locked_input_state = [0,0,0,0,1]
			
			if player_direction == 0 && player_input[1]:
				EventController.emit_signal("pull", "down")
				
			if player_direction == 1 && player_input[0]:
				EventController.emit_signal("pull", "up")
				
			if player_direction == 2 && player_input[3]:
				EventController.emit_signal("pull", "right")
				
			if player_direction == 3 && player_input[2]:
				EventController.emit_signal("pull", "left")
				
		else:
			interact_lock = 0
			locked_input_state = player_input
			
		
	if locked_input_state[3]:
		$AnimatedSprite.play("right")
		player_direction = 3
		if right_collision == 0:
			velocity.x += accelration
			velocity.x = clamp(velocity.x, max_x_speed*-1, max_x_speed)
		else:
			velocity.x = clamp(velocity.x, max_x_speed*-1, 0)
	else:
		if velocity.x > 0:
			velocity.x -= deceleration
			velocity.x = clamp(velocity.x, 0, max_x_speed)
	if locked_input_state[2]:
		player_direction = 2
		$AnimatedSprite.play("left")
		if left_collision == 0:
			velocity.x -= accelration
			velocity.x = clamp(velocity.x, max_x_speed*-1, max_x_speed)
		else:
			velocity.x = clamp(velocity.x, 0, max_x_speed)
	else:
		if velocity.x < 0:
			velocity.x += deceleration
			velocity.x = clamp(velocity.x, max_x_speed*-1, 0)
	if locked_input_state[1]:
		player_direction = 1
		$AnimatedSprite.play("down")
		if bottom_collision == 0:
			velocity.y += accelration
			velocity.y = clamp(velocity.y, max_y_speed*-1, max_y_speed)
		else:
			velocity.y = clamp(velocity.y, max_y_speed*-1, 0)
	else:
		if velocity.y > 0:
			velocity.y -= deceleration
			velocity.y = clamp(velocity.y, 0, max_y_speed)
	if locked_input_state[0]:
		player_direction = 0
		$AnimatedSprite.play("up")
		if top_collision == 0:
			velocity.y -= accelration
			velocity.y = clamp(velocity.y, max_y_speed*-1, max_y_speed)
		else:
			velocity.y = clamp(velocity.y, 0, max_y_speed)
	else:
		if velocity.y < 0:
			velocity.y += deceleration
			velocity.y = clamp(velocity.y, 0, max_y_speed*-1)
			
	#if Input.is_action_pressed("ui_left"):
		#emit_signal("interact")
		
	PlayerController.emit_signal("player_velocity", velocity)
	
#Update position
	position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)


func _on_topcollision_top_collision():
	top_collision = 1
	if velocity.y < 0:
		velocity.y = 0


func _on_bottomcollision_bottom_collision():
	print("bottom collision")
	bottom_collision = 1
	if velocity.y < 0:
		velocity.y = 0


func _on_leftcollision_left_collision():
	left_collision = 1
	if velocity.x < 0:
		velocity.x = 0

func _on_rightcollision_right_collision():
	right_collision = 1
	if velocity.x > 0:
		velocity.x = 0

func _on_topcollision_top_collision_end():
	top_collision = 0
	

func _on_bottomcollision_bottom_collision_end():
	print("bottom collision ended")
	bottom_collision = 0
	

func _on_leftcollision_left_collision_end():
	left_collision = 0

func _on_rightcollision_right_collision_end():
	right_collision = 0



