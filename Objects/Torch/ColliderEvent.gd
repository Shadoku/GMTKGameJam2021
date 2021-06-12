extends CollisionShape2D
signal torch_collision
signal torch_collision_end

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_area_entered(area):
	emit_signal("torch_collision")


func _on_Area2D_area_exited(area):
	emit_signal("torch_collision_end")
