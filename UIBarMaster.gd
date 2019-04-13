extends ColorRect


export (bool) var copy_health #copy health of target if true, copy advantage if false
export (NodePath) var target_path
var target
var bar
var label
var health = 100
var max_health = 100
var adv = 100
var max_adv = 100

func _ready():
	
	target = self.get_node(target_path).get_node("Player")
	health = target._health
	max_health = target.max_health
	adv = target.advantage
	max_adv = 100
	bar = $"UIBar"
	label = $"UIBarLabel"

	
func update_children():
	health = target._health
	adv = target.advantage
	var update_value = health if copy_health else adv
	var update_value_max = max_health if copy_health else max_adv
	bar.set_value(update_value)
	label.update_value(str(update_value) + "/" + str(update_value_max))



