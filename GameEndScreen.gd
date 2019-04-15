extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
export(NodePath) var text_path
export(NodePath) var score_path
var text
var score
var score_value
var lines
func _ready():
	score_value = 0
	text = get_node(text_path)
	score = get_node(score_path)
	lines = []
	lines.append("[center]You beat your brother, but didn't play nice so your parents grounded you.")
	lines.append("[center]You lost to your brother, but he knows you lost to him on purpose.")
	lines.append("[center]You lost to your brother, and he's satisfied with a hard-fought victory")
	self.visible = false
	pass # Replace with function body.

func make_visible(end_index,believability):
	#0 is beating enemy,
	#1 is losing to enemy badly
	#2 is close game loss

	text.bbcode_text = lines[end_index]
	if end_index == 0:
		score.bbcode_text = ""
	else:
		score.bbcode_text = "[center]Your loss was " + str(believability) + "% believable"
	self.visible = true
	
func main_menu_press():
	get_tree().change_scene("res://MainMenu.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
