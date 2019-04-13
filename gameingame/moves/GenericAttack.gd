extends "GenericMove.gd"

export (int) var damage = 10
export (float, 0, 2) var regen = 0.05

func run(user, opponent):
	opponent.take_damage(damage)
	user.advantage -= advantage_cost
	user.take_damage(regen * (user.max_health - user._health))