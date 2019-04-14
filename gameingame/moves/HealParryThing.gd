extends Node

export (int) var advantage_cost = 10
export (float, 0, 2) var regen = 0.6

func run(user, opponent, opportunity):
	user.advantage -= advantage_cost
	user.get_healed(user.last_damage * regen * (2 if opportunity else 1))

func available(user):
	return user.advantage >= advantage_cost