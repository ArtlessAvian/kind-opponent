extends Node

export (float, 0, 2) var efficiency = 0.8
export (float, 0, 2) var regen = 0.03

func run(user, opponent, opportunity):
	opponent.take_damage(user.advantage * efficiency)
	user.advantage = (user.advantage / 2) if opportunity else 0
	user.get_healed(regen * (user.max_health - user._health))

func available(user):
	return user.advantage > 0