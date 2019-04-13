extends "GenericMove.gd"

export (float, 0, 2) var regen = 0.6

func run(user, opponent):
	user.advantage -= advantage_cost
	user.take_damage(user.last_damage * regen)