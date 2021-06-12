extends Area2D
export var max_speed = 48  # How fast the player will move (pixels/sec).
var max_y_speed = max_speed / 2
var max_x_speed = max_speed / 2
var accelration = 10
var deceleration = 5
var screen_size  # Size of the game window.
var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func _process(delta):
	#Detect insput and set speed
	  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += accelration
		velocity.x = clamp(velocity.x, max_x_speed*-1, max_x_speed)
	else:
		if velocity.x > 0:
			velocity.x -= deceleration
			velocity.x = clamp(velocity.x, 0, max_x_speed)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= accelration
		velocity.x = clamp(velocity.x, max_x_speed*-1, max_x_speed)
	else:
		if velocity.x < 0:
			velocity.x += deceleration
			velocity.x = clamp(velocity.x, max_x_speed*-1, 0)
	if Input.is_action_pressed("ui_down"):
		velocity.y += accelration
		velocity.y = clamp(velocity.y, max_y_speed*-1, max_y_speed)
	else:
		if velocity.y > 0:
			velocity.y -= deceleration
			velocity.y = clamp(velocity.y, 0, max_y_speed)
	if Input.is_action_pressed("ui_up"):
		velocity.y -= accelration
		velocity.y = clamp(velocity.y, max_y_speed*-1, max_y_speed)
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

