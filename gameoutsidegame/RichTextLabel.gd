extends RichTextLabel

# Declare member variables here. Examples:
var script

# Called when the node enters the scene tree for the first time.
func _ready():
	script = Array("""\"Yeah, mom. What?\" Alex followed his mother to the study, where his father waited.
His father spoke first. \"We know what you\'ve been doing to Ryan.\"
His mother followed. \"It\'s not nice, treating your little brother like that. Constantly beating him at Advant.\"
\"Well, he keeps challenging me. What am I supposed to do?\"
\"Let him win.\"
\"WHAT?\"
\"Let him win.\" Alex\'s father repeated.
\"But I...\"
\"It\'s bad practice to start your sentence with ‘but\'.\"
\"Why should I? I\'m way better at Advant than he is. He barely knows how to play!\"
\"Alex, think about what you are doing to your brother\'s self-image. He keeps fighting you, and he keeps losing!\"
\"Because he sucks!\"
His father sighed. \"Remember our Advant matches when you were six?\"
\"Yeah. You told me already. Occasionally lost to me on purpose so I can feel good about myself. So you can go do that to Ryan; I\'ll have no part.\"
\"Let me tell you how Ryan is feeling. He\'s devastated. He thinks he will never be good enough.\"
His mother cut in. \"In a few minutes, Ryan will issue another challenge. You will give him a good fight, and you will let him win.\"
\"Or what?\"
\"We will be watching.\" His father said.
His mother continued. \"Bottom line, if he didn\'t enjoy the game, we\'re taking away your gaming time for a month.\"
\"Wait, you can\'t do that!\"
\"We can, and we will.\"""".split("\n"))
	self.next_line()

# Called every frame. 'delta' is the elapsed time since the previous frame.
var thingy
func _process(delta):
	if self.percent_visible >= 1:
		if Input.is_action_just_pressed("click_anywhere"):
			if not script.empty():
				self.next_line()
				thingy = false
			else:
				get_tree().change_scene("res://gameingame/BattleWView.tscn")
	else:
		self.percent_visible += delta * 30 * (30 if thingy else 1) / len(self.text)
		if (Input.is_action_just_pressed("click_anywhere") or Input.is_action_just_pressed("ui_accept")):
			thingy = true

func next_line():
	var newln = script.pop_front()
#	self.percent_visible = float(len(self.text)) / (len(self.text) + len(newln))
#	self.text = self.text + ("\n" if self.text else "") + newln
	self.text = newln
	self.percent_visible = 0
#	print(self.text)