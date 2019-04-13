extends Node


func run(user, opponent):
	user.advantage += 60
	if user.advantage > user.max_adv:
		user.advantage = user.max_adv

func available(user):
	return user.advantage < user.max_adv