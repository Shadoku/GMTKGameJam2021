extends Area2D


var object_collision = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	EventController.connect("push", self, "push")
	$Animations.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Animations.play()
	
func push(object, direction):
	if object == self:
		if direction == "up":
			print("pushed up")
			position.y -= 16

func _on_CollisionShape2D_object_collision():
	object_collision = 1
	print("object start")


func _on_CollisionShape2D_object_collision_end():
	object_collision = 0
	print("object end")
