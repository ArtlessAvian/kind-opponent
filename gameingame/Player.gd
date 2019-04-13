#Contains moves, hp, and advantange

extends Node

# Stuff
var opponent;

export (int, 0) var max_health = 100

var advantage = 0
var last_damage = 0

# private???
onready var _health = max_health

#func temporary():
#	opponent._health -= 10
#	print(self.name, " uses Attack or something!")
#	print(opponent.name, " takes 10 damage")

func do_move(move_id):
	$Moves.get_child(move_id).run(self, self.opponent)

func take_damage(damage):
	self._health -= damage
	self.last_damage = damage

func is_dead():
	return self._health <= 0