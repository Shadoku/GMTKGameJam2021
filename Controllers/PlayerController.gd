extends Node
#Collets and reemits signals to all nodes in active scene.

signal player_velocity(velocity)
signal player_input(input)
export var coliders = {"up":[], "down":[], "left":[], "right":[]}
var player_velocity = Vector2()


func _ready():
	pass

func add_coliders(object, type):
	coliders[type] = object
	print(coliders)
