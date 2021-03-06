#Contains moves, hp, and advantange

extends Node

# Stuff
var opponent;

export (int) var max_health = 400
export (int) var max_adv = 240

export (int) var advantage = 0

var last_damage = 0

# private???
onready var _health = max_health
onready var last_health = max_health

func do_move(move_id, opportunity):
	$Moves.get_child(move_id).run(self, self.opponent, opportunity)

func take_damage(damage):
	print("damage taken: ", damage)
	self._health = max(0, self._health - damage)
	self.last_damage = damage if damage > 0 else self.last_damage
	
	while last_health - _health >= 100:
		last_health -= 100
		$"..".threshold_passed(self)
	
func get_healed(healed):
	self._health = min(max_health, self._health + healed)

func is_dead():
	return self._health <= 0