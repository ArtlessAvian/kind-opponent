extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var type_prefix

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_value(text):
	self.text = type_prefix + text
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
