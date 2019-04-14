extends RichTextLabel

# Declare member variables here. Examples:
var script

# Called when the node enters the scene tree for the first time.
func _ready():
	script = [
		"welcome to the circus",
		"tl;dr your brother is annoying you to 1v1 him (not irl)",
		"and its easy af to steamroll him",
		"but dont do that bc idk",
		"maybe your parents will ground you",
		"well lets go ig. check out this jarring transition."
	]
	self.next_line()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.percent_visible >= 1:
		if Input.is_action_just_pressed("click_anywhere"):
			if not script.empty():
				self.next_line()
			else:
				get_tree().change_scene("res://gameingame/BattleWView.tscn")
	else:
		self.percent_visible += delta * 30 * (3 if Input.is_action_pressed("click_anywhere") else 1) / len(self.text)

func next_line():
	var newln = script.pop_front()
	self.percent_visible = float(len(self.text)) / (len(self.text) + len(newln))
	self.text = self.text + ("\n" if self.text else "") + newln
	print(self.text)