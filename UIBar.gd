extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

var current_perc

func _ready():
	set_value(desired_perc)
	current_perc = desired_perc
	self.set_anchor_and_margin(MARGIN_RIGHT,current_perc,0,false)
	
func set_value(percent):
	print(percent)
	perc = percent
	self.set_anchor_and_margin(MARGIN_RIGHT,perc,0,false)