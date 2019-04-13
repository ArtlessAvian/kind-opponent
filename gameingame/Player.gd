#Contains moves, hp, and advantange

extends Node

# Stuff
var opponent;

export (int) var max_health = 100
export (int) var max_adv = 100

export (int) var advantage = 60
var last_damage = 0

# private???
onready var _health = max_health

func do_move(move_id):
	$Moves.get_child(move_id).run(self, self.opponent)

func take_damage(damage):
	self._health = max(0, self._health - damage)
	self.last_damage = damage if damage > 0 else self.last_damage

func is_dead():
	return self._health <= 0