extends Area2D
var xmov = 0
var ymov = 0
#Movement lock: up, down, left, right
var mov_distance = 16
var mov_lock = [0, 0, 0, 0]
var push_direction = [0, 0, 0, 0]
var mov_delay = 25
var current_delay = 0
var player_coliders = PlayerController.coliders
var player_velocity = Vector2()
var player_input = [0,0,0,0,0] 


var object_collision = 0
# Called when the node enters the scene tree for the first time.

static func sum(array):
	var sum = 0.0
	for element in array:
		 sum += element
	return sum

func _ready():
	EventController.connect("push", self, "push")
	EventController.connect("push_end", self, "push_end")
	PlayerController.connect("player_velocity", self, "update_player_velocity")
	PlayerController.connect("player_input", self, "get_player_input")
	$Animations.play()
	
func update_player_velocity(velocity):
	player_velocity = velocity

func get_player_input(input):
	player_input = input
	#print(player_input)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Animations.play()
	if xmov > 0:
		position.x += 1
		xmov -= 1
		
	if xmov < 0:
		position.x -= 1
		xmov += 1
		
	if ymov > 0:
		position.y += 1
		ymov -= 1
		
	if ymov < 0:
		position.y -= 1
		ymov += 1
	
#######################PUSHING############################
	#push down
	#print(push_direction)
	if push_direction[0] == 1 && player_input[0] == true && mov_lock[0] == 0:
#			print("we're pushing up!")
			current_delay += 1
			if current_delay == mov_delay:
				ymov = mov_distance*-1
				current_delay = 0
				
	#push up
	if push_direction[1] == 1 && player_input[1] == true && mov_lock[1] == 0:
#			print("we're pushing down!")
			current_delay += 1
			if current_delay == mov_delay:
				ymov = mov_distance
				current_delay = 0
				
	#push up
	if push_direction[2] == 1 && player_input[2] == true && mov_lock[2] == 0:
#			print("we're pushing left!")
			current_delay += 1
			if current_delay == mov_delay:
				xmov = mov_distance*-1
				current_delay = 0
				
	#push up
	if push_direction[3] == 1 && player_input[3] == true && mov_lock[3] == 0:
#			print("we're pushing right!")
			current_delay += 1
			if current_delay == mov_delay:
				xmov = mov_distance
				current_delay = 0

####################PULLING##########################
				
		#pull down
	#print(push_direction)
	if push_direction[0] == 1 && player_input[1] == true && player_input[4]:
			#print("we're pushing up!")
			current_delay += 1
			if current_delay == mov_delay:
				ymov = mov_distance
				current_delay = 0
				PlayerController.emit_signal("move_player", Vector2(0,16))
	
func push(object, direction):
	if object == self:
		print("touched")
		push_direction = [0,0,0,0]
		if direction == "up" && ymov == 0 && xmov == 0 && mov_lock[0] == 0:
			push_direction[0] = 1
			
		if direction == "down" && ymov == 0 && xmov == 0 && mov_lock[1] == 0:
			push_direction[1] = 1

		if direction == "left" && ymov == 0 && xmov == 0 && mov_lock[2] == 0:
			push_direction[2] = 1

		if direction == "right" && ymov == 0 && xmov == 0 && mov_lock[3] == 0:
			push_direction[3] = 1
				

func push_end(object, direction):
	push_direction = [0,0,0,0]
	current_delay = 0

func _on_CollisionShape2D_object_collision():
	print("Block colided")
	xmov = 0
	ymov = 0
	object_collision = 1
	print("object start")


func _on_CollisionShape2D_object_collision_end():
	object_collision = 0
	print("object end")


func _on_Area2D_body_entered(body):
	print("Block colided")
	xmov = 0
	ymov = 0


func _on_ObjectBase_body_entered(body):
	pass # Replace with function body.


func _on_UpColider3_body_entered(body):
	print("Block colided up")
	mov_lock[0] = 1
	
func _on_DownColider4_body_entered(body):
	print("Block colided down")
	mov_lock[1] = 1
	
func _on_LeftColider2_body_entered(body):
	print("Block colided left")
	mov_lock[2] = 1

func _on_RightColider_body_entered(body):
	print("Block colided right")
	mov_lock[3] = 1
	
#Collision ended events

func _on_UpColider3_body_exited(body):
	print("Block collision ended up")
	mov_lock[0] = 0
	
func _on_DownColider4_body_exited(body):
	print("Block collision ended down")
	mov_lock[1] = 0

func _on_LeftColider2_body_exited(body):
	print("Block collision ended left")
	mov_lock[2] = 0

func _on_RightColider_body_exited(body):
	print("Block collision ended right")
	mov_lock[3] = 0




