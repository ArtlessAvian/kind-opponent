extends Node

export (int, 0, 400) var charge = 60

func _get_charge_value(user, opportunity):
	return min(charge * (2 if opportunity else 1), user.max_adv - user.advantage)

func run(user, opponent, opportunity):
	user.advantage += charge * (2 if opportunity else 1)
	if user.advantage > user.max_adv:
		user.advantage = user.max_adv

func available(user):
	return user.advantage < user.max_adv

func summary(user, opportunity):
	return 'Charge [0/+%d/0]' % _get_charge_value(user, opportunity)

func describe(user, opportunity):
	return 'Builds advantage.'