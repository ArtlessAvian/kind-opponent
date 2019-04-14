extends Node

export (int) var advantage_cost = 20
export (int) var damage = 10
export (float, 0, 2) var regen = 0.05

func _get_damage_value(opportunity):
	return damage * (2 if opportunity else 1)

func _get_regen_value(user):
	return regen * (user.max_health - user._health)

func run(user, opponent, opportunity):
	user.advantage -= advantage_cost
	opponent.take_damage(_get_damage_value(opportunity))
	user.get_healed(_get_regen_value(user))

func available(user):
	return user.advantage >= advantage_cost

func summary(user, opportunity):
	return 'Attack [%d/-%d/+%d]' % [_get_damage_value(opportunity), advantage_cost, _get_regen_value(user)]

func describe(user, opportunity):
	return """
		Does damage using some advantage.
		Moderate health steal.
		%s
		Damage: %d
		Advantage Cost: %d
		Health Regen: %d
	""" % ['PERFECT OPPORTUNITY: Double damage output\n' if opportunity else '', _get_damage_value(opportunity), advantage_cost, _get_regen_value(user)]