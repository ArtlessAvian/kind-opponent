extends "GenericMove.gd"

export (int) var damage = 10
export (float, 0, 2) var regen = 0.03

func run(user, opponent):
	opponent.take_damage(advantage)
	user.advantage = 0
	user.take_damage(regen * (user.max_health - user._health))