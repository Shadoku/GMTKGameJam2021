extends CollisionShape2D
signal left_collision
signal left_collision_end

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D3_body_entered(body):
	emit_signal("left_collision")


func _on_Left_Collision_body_exited(body):
	emit_signal("left_collision_end")
