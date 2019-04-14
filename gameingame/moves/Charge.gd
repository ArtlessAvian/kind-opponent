extends Node

export (int, 0, 400) var charge = 60

func run(user, opponent, opportunity):
	user.advantage += charge * (2 if opportunity else 1)
	if user.advantage > user.max_adv:
		user.advantage = user.max_adv

func available(user):
	return user.advantage < user.max_adv