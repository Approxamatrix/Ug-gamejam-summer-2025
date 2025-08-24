extends Control
class_name DialogBox

#var inputText : String = "When the imposter is sus !!!"
@export var TextTimer : Timer
@export var DialogLabel : Label
@export var CharLabel : Label
@export var DialogFile : DialogueList

var DialogIndex : int = 0

func _ready() -> void:
	
	
	if DialogFile != null:
		DialogLabel.text = DialogFile.Dialogue[DialogIndex].TalkText
		
	DialogLabel.visible_ratio = 0
	pass

func slowprint():
	
	if DialogLabel.visible_ratio < 1 :
		#DialogLabel.text = DialogFile.Dialogue[DialogIndex].TalkText
		
		DialogLabel.visible_ratio += 0.025
		
		
		
		pass
	
	pass

func sequenceHandler():
	if DialogFile != null:
		if TextTimer.is_stopped():
			TextTimer.start()
		
		if DialogLabel.visible_ratio >= 1:
			#DialogIndex+=1
			if Input.is_action_just_pressed("Jump") and DialogIndex < DialogFile.Dialogue.size()-1:
				#if DialogFile.Dialogue[DialogIndex+1] != null:
				DialogIndex += 1
				DialogLabel.text = DialogFile.Dialogue[DialogIndex].TalkText
				DialogLabel.visible_ratio = 0
				slowprint()

			else:
				DialogIndex = DialogIndex
					#DialogLabel.text = DialogFile.Dialogue[DialogIndex].TalkText
				pass
			
			#DialogLabel.visible_ratio = 0
		pass
		if DialogLabel.visible_ratio < 1:
			#
			#if Input.is_action_just_pressed("Jump"):
				#DialogLabel.visible_ratio = 1
				#pass
			
			pass
		#if DialogLabel.visible_ratio > DialogFile.Dialogue[DialogIndex].TalkText.length() and Input.is_action_just_pressed("Jump"):
			#DialogLabel.visible_ratio = 1
			#pass

	pass



func _physics_process(delta: float) -> void:
	sequenceHandler()
		
	pass
