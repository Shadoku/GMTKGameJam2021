extends Area2D
var xmov = 0
var ymov = 0
#Movement lock: up, down, left, right
var mov_lock = [0, 0, 0, 0]
var push_direction = [0, 0, 0, 0]
var mov_delay = 15
var current_delay = 0


var object_collision = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	EventController.connect("push", self, "push")
	$Animations.play()


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
		
	
func push(object, direction):
	if object == self:
		if direction == "up" && ymov == 0 && xmov == 0 && mov_lock[0] == 0:
			current_delay += 1
			print("Added to delay up")
			if current_delay >= mov_delay:
				print("pushed up")
				#position.y -= 16
				ymov = -16
				
		if direction == "down" && ymov == 0 && xmov == 0 && mov_lock[1] == 0:
			
			print("pushed down")
			#position.y -= 16
			ymov = 16
			
		if direction == "left" && ymov == 0 && xmov == 0 && mov_lock[2] == 0:
			
			print("pushed left")
			#position.y -= 16
			xmov = -16
			
		if direction == "right" && ymov == 0 && xmov == 0 && mov_lock[3] == 0:
			
			print("pushed left")
			#position.y -= 16
			xmov = 16

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




