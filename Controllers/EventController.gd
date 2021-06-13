extends Node
#Collets and reemits signals to all nodes in active scene.

signal push(object, direction)
signal push_end(object, direction)
signal pull(direction)
signal pull_end()

func _ready():
	pass
