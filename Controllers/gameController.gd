extends Node

export var left_dic = {}
export var right_dic = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	EventController.connect("objectUpdate", self, "update")
	EventController.connect("objectRemove", self, "remove")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	
func update(world, pos, state, type):
	if world == 0:
		left_dic[pos] = [state, type]
	else:
		right_dic[pos] = [state, type]
	
	if left_dic.hash() == right_dic.hash():
		EventController.emit_signal("levelComplete")
	
func remove(world, pos):
	if world == 0:
		left_dic.erase(pos)
	else:
		right_dic.erare(pos)
