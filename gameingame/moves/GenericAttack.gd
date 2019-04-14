extends Node

export (int) var advantage_cost = 20
export (int) var damage = 10
export (float, 0, 2) var regen = 0.05

func run(user, opponent, opportunity):
	user.advantage -= advantage_cost
	opponent.take_damage(damage * (2 if opportunity else 1))
	user.get_healed(regen * (user.max_health - user._health))

func available(user):
	return user.advantage >= advantage_cost