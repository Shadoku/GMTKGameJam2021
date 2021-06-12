extends CollisionShape2D
signal object_collision
signal object_collision_end

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	emit_signal("object_collision")


func _on_Area2D_body_exited(body):
	emit_signal("object_collision_end")


func _on_Area2D_area_entered(area):
	emit_signal("object_collision")


func _on_Area2D_area_exited(area):
	emit_signal("object_collision_end")