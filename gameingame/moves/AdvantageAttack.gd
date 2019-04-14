extends Node

export (float, 0, 2) var efficiency = 0.8
export (float, 0, 2) var regen = 0.03

func run(user, opponent, opportunity):
	opponent.take_damage(user.advantage * efficiency * (2 if opportunity else 1))
	user.advantage = 0
	user.get_healed(regen * (user.max_health - user._health))

func available(user):
	return user.advantage > 0