extends "GenericMove.gd"


func run(user, opponent):
	user.advantage -= advantage_cost
	user.take_damage(user.last_damage * -0.9)