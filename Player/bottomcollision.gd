extends CollisionShape2D
signal bottom_collision
signal bottom_collision_end

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bottom_Collison_body_entered(body):
	EventController.emit_signal("push", body.get_parent(), "down")
	emit_signal("bottom_collision")


func _on_Bottom_Collison_body_exited(body):
	EventController.emit_signal("push_end", body.get_parent(), "down")
	emit_signal("bottom_collision_end")
