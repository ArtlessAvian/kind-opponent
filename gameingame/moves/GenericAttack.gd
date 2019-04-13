extends "GenericMove.gd"

export (int) var damage = 10

func run(user, opponent):
	opponent.take_damage(damage)
	user.advantage -= advantage_cost