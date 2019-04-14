extends Node

export (int) var advantage_cost = 20
export (int) var damage = 10
export (float, 0, 2) var regen = 0.05
export (float, 0, 2) var efficiency = 0.2
export (float, 0, 2) var advantage_percent_cost = 0.2

func _get_damage_value(user, opportunity):
	# return damage * (2 if opportunity else 1)
	return user.advantage * efficiency * (2 if opportunity else 1)

func _get_advantage_cost(user, opportunity):
	return user.advantage * advantage_percent_cost

func _get_regen_value(user):
	return regen * (user.max_health - user._health)

func run(user, opponent, opportunity):
	user.advantage -= _get_advantage_cost(user, opportunity)# advantage_cost
	opponent.take_damage(_get_damage_value(user, opportunity))
	user.get_healed(_get_regen_value(user))

func available(user):
	return user.advantage >= advantage_cost

func summary(user, opportunity):
	return 'Light Attack [%d/-%d/+%d]' % [_get_damage_value(user, opportunity), _get_advantage_cost(user, opportunity), _get_regen_value(user)]

func describe(user, opportunity):
	return """
		Does damage using some advantage.
		Moderate health regen.
		%s
		Damage: %d
		Advantage Cost: %d
		Health Regen: %d
	""" % ['\nPERFECT OPPORTUNITY: Double damage output\n' if opportunity else '', _get_damage_value(user, opportunity), _get_advantage_cost(user, opportunity), _get_regen_value(user)]