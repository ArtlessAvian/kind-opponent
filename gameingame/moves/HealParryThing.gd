extends Node

export (int) var advantage_cost = 10
export (float, 0, 2) var regen = 0.6

func _get_heal_value(user, opportunity):
	return min(user.last_damage * regen * (2 if opportunity else 1), user.max_health - user._health)

func run(user, opponent, opportunity):
	user.advantage -= advantage_cost
	user.get_healed(_get_heal_value(user, opportunity))

func available(user):
	return user.advantage >= advantage_cost and user._health < user.max_health

func summary(user, opportunity):
	return 'Regenerate [0/-%d/+%d]' % [advantage_cost, _get_heal_value(user, opportunity)]

func describe(user, opportunity):
	return """
		Use concentrated mana to reinforce your shields.
		Repairs 60%% of the damage taken last time you were attacked.
		%s
		Mana Cost: %d
		Shield Recharge: %d
	""" % ['\nPERFECT OPPORTUNITY: Double shield recharge\n' if opportunity else '', advantage_cost, _get_heal_value(user, opportunity)]