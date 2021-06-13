extends Area2D
var xmov = 0
var ymov = 0


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
		if direction == "up" && ymov == 0 && xmov == 0:
			
			print("pushed up")
			#position.y -= 16
			ymov = -16
		if direction == "down" && ymov == 0 && xmov == 0:
			
			print("pushed down")
			#position.y -= 16
			ymov = 16
			
		if direction == "left" && ymov == 0 && xmov == 0:
			
			print("pushed left")
			#position.y -= 16
			xmov = -16
			
		if direction == "right" && ymov == 0 && xmov == 0:
			
			print("pushed left")
			#position.y -= 16
			xmov = 16

func _on_CollisionShape2D_object_collision():
	object_collision = 1
	print("object start")


func _on_CollisionShape2D_object_collision_end():
	object_collision = 0
	print("object end")
