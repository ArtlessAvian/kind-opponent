extends Node

export (int) var advantage_cost = 10
export (float, 0, 2) var regen = 0.6

func _get_heal_value(user, opportunity):
	return user.last_damage * regen * (2 if opportunity else 1)

func run(user, opponent, opportunity):
	user.advantage -= advantage_cost
	user.get_healed(_get_heal_value(user, opportunity))

func available(user):
	return user.advantage >= advantage_cost

func summary(user, opportunity):
	return 'Heal [0/-%d/+%d]' % [advantage_cost, _get_heal_value(user, opportunity)]

func describe(user, opportunity):
	return 'Heals for a fraction of what was last dealt.'