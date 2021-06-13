extends CollisionShape2D
signal right_collision
signal right_collision_end

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D4_body_entered(body):
	EventController.emit_signal("push", body.get_parent(), "right")
	emit_signal("right_collision")


func _on_Right_Collision_body_exited(body):
	emit_signal("right_collision_end")
