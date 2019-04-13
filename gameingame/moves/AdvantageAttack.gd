extends Node

export (int) var damage = 10
export (float, 0, 2) var regen = 0.03

func run(user, opponent):
	opponent.take_damage(user.advantage)
	user.advantage = 0
	user.get_healed(regen * (user.max_health - user._health))

func available(user):
	return user.advantage > 0