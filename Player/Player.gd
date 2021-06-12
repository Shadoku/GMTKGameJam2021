extends Area2D
export var max_speed = 48  # How fast the player will move (pixels/sec).
var max_y_speed = max_speed / 2
var max_x_speed = max_speed / 2
var accelration = 10
var deceleration = 5
var top_collision =0
var bottom_collision =0
var left_collision =0
var right_collision =0

var screen_size  # Size of the game window.
var velocity = Vector2()

#hello world 

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Detect insput and set speed
	  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += accelration
		velocity.x = clamp(velocity.x, max_x_speed*-1, max_x_speed)
		$AnimatedSprite.play("right")
		if right_collision == 0:
			velocity.x += accelration
			velocity.x = clamp(velocity.x, max_x_speed*-1, max_x_speed)
		else:
			velocity.x = clamp(velocity.x, max_x_speed*-1, 0)
	else:
		if velocity.x > 0:
			velocity.x -= deceleration
			velocity.x = clamp(velocity.x, 0, max_x_speed)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= accelration
		velocity.x = clamp(velocity.x, max_x_speed*-1, max_x_speed)
		$AnimatedSprite.play("left")
		if right_collision == 0:
			velocity.x -= accelration
			velocity.x = clamp(velocity.x, max_x_speed*-1, max_x_speed)
		else:
			velocity.x = clamp(velocity.x, 0, max_x_speed)
	else:
		if velocity.x < 0:
			velocity.x += deceleration
			velocity.x = clamp(velocity.x, max_x_speed*-1, 0)
	if Input.is_action_pressed("ui_down"):
		velocity.y += accelration
		velocity.y = clamp(velocity.y, max_y_speed*-1, max_y_speed)
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
	if Input.is_action_pressed("ui_up"):
		velocity.y -= accelration
		velocity.y = clamp(velocity.y, max_y_speed*-1, max_y_speed)
		$AnimatedSprite.play("up")
	else:
		if velocity.y < 0:
			velocity.y += deceleration
			velocity.y = clamp(velocity.y, max_y_speed*-1, 0)
	if velocity.length() > 0:
		#velocity = velocity.normalized() * max_speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
#Update position
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_topcollision_top_collision():
	top_collision = 1
	if velocity.y < 0:
		velocity.y = 0


func _on_bottomcollision_bottom_collision():
	bottom_collision = 1
	print("bottom start")
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
	bottom_collision = 0
	print("bottom end")

func _on_leftcollision_left_collision_end():
	left_collision = 0

func _on_rightcollision_right_collision_end():
	right_collision = 0
