extends Node

export (int) var advantage_cost = 10
export (float, 0, 2) var regen = 0.6

func run(user, opponent):
	user.advantage -= advantage_cost
	user.get_healed(user.last_damage * regen)

func available(user):
	return user.advantage >= advantage_cost