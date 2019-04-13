extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

export(float) var perc = 1
func _ready():
	set_value(perc)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#self.set_anchor_and_margin(MARGIN_RIGHT,perc,0,false)
	
	
func set_value(percent):
	print(percent)
	perc = percent
	self.set_anchor_and_margin(MARGIN_RIGHT,perc,0,false)
