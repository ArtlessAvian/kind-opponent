extends Node

export (float, 0, 2) var efficiency = 0.8
export (float, 0, 2) var regen = 0.03

func run(user, opponent):
	opponent.take_damage(user.advantage * efficiency)
	user.advantage = 0
	user.get_healed(regen * (user.max_health - user._health))

func available(user):
	return user.advantage > 0