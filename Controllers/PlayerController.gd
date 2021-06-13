extends Node
#Collets and reemits signals to all nodes in active scene.

#signal push(object, direction)
var coliders = {"up":[], "down":[], "left":[], "right":[]}

func _ready():
	pass

func add_coliders(object, type):
	coliders[type] = object
	print(coliders)
