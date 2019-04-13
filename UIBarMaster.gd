extends ColorRect


export (bool) var copy_health #copy health of target if true, copy advantage if false
export (bool) var copy_player 
export (NodePath) var target_path
var battle
var character
var bar
var label
var counter

func _ready():
	
	battle = self.get_node(target_path)
	character = battle.get_node("Player") if copy_player else battle.get_node("Opponent")
	
	counter = character.max_health if copy_health else character.advantage

	bar = $UIBar
	label = $UIBarLabel

	bar.set_value(float(counter) / self._get_target_max())
	label.update_value(str(floor(counter), "/", self._get_target_max()))

func _thing(delta):
	var target = self._get_target()
	var diff = target - counter
	counter += delta * sign(diff) * 1/4 * 60
	
	# move towards target, in direction of diff

	# if you move past the target
	if ((target - counter) * (diff) > 0):
		bar.set_value(counter / self._get_target_max())
		label.update_value(str(floor(counter), "/", self._get_target_max()))
	else:
		bar.set_value(float(target) / self._get_target_max())
		label.update_value(str(floor(target), "/", self._get_target_max()))
		return true
	
#	health = target._health
#	adv = target.advantage
#	var update_value = health if copy_health else adv
#	var update_value_max = max_health if copy_health else max_adv
#
#	bar.set_value(update_value)/update_value_max)
#	label.update_value(str(update_value, "/", update_value_max))
#	if ():
#		return true

func update_children():
	if (copy_health):
		if (counter != character._health):
			battle.yielding_for_queue.push_back(self)
	else:
		if (counter != character.advantage):
			battle.yielding_for_queue.push_back(self)

func _get_target():
	if copy_health:
		return character._health
	else:
		return character.advantage
		
func _get_target_max():
	if copy_health:
		return character.max_health
	else:
		return character.max_adv
#
#func _on_Battle_update_bars():

