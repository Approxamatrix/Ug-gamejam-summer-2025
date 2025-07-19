extends Node
class_name StateManager


var currentstate : Basestate
var statearray : Array[Basestate]



func _ready() -> void:
	
	initializestatearray()
	if currentstate != null:
		currentstate.StateChangeSignal.connect(change_state)
	
	pass

func initializestatearray():
	
	for child in get_children():
		if child is Basestate:
			
			statearray.append(child)
			child.StateChangeSignal.connect(change_state)
			
			pass
		else:
			pass
		
	
	pass


func change_state(newstate : StringName):
	print("AA")
	for item in statearray:
		
		if item is Basestate and item.name == newstate:
			
			if currentstate != null:
				currentstate.exit()
			
			currentstate = item
			
			if currentstate != null:
				currentstate.enter()
			print(currentstate)
		
		else:
			pass
		
		pass
	
	
	pass


func _physics_process(delta: float) -> void:
	
	if currentstate != null:
		currentstate.update()
	
	pass
