extends Area2D

var object_collision = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if object_collision == 0:
		$Animations.play("off")
	else:
		$Animations.play("on")


func _on_CollisionShape2D_torch_collision():
	object_collision = 1
	print("torch 1 start")


func _on_CollisionShape2D_torch_collision_end():
	object_collision = 0
	print("torch 1 end")
