extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

export(float) var desired_perc = 1
export(float) var move_speed

var current_perc

func _ready():
	set_value(desired_perc)
	current_perc = desired_perc
	self.set_anchor_and_margin(MARGIN_RIGHT,current_perc,0,false)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(desired_perc-current_perc)
	if desired_perc - current_perc > move_speed*delta:
		current_perc += move_speed*delta
	elif desired_perc - current_perc < -move_speed*delta:
		current_perc -= move_speed*delta
	else:
		current_perc = desired_perc
	self.set_anchor_and_margin(MARGIN_RIGHT,current_perc,0,false)
	
func set_value(percent):
	desired_perc = percent

