extends Node

export (float, 0, 2) var efficiency = 0.8
export (float, 0, 2) var regen = 0.03

func _get_damage_value(user):
	return user.advantage * efficiency

func _get_advantage_cost(user, opportunity):
	return (user.advantage / 2) if opportunity else user.advantage

func _get_regen_value(user):
	return regen * (user.max_health - user._health)

func run(user, opponent, opportunity):
	opponent.take_damage(_get_damage_value(user))
	user.advantage = (user.advantage / 2) if opportunity else 0
	user.get_healed(_get_regen_value(user))

func available(user):
	return user.advantage > 0

func summary(user, opportunity):
	return 'Advantage Attack [%d/-%d/+%d]' % [_get_damage_value(user), _get_advantage_cost(user, opportunity), _get_regen_value(user)]

func describe(user, opportunity):
	return """
		Uses all your advantage to deal damage.
		Damage is equal to 80%% of your advantage.
		Tiny amount of health regen.
		%s
		Damage: %d
		Advantage Cost: %d
		Health Regen: %d
	""" % ['\nPERFECT OPPORTUNITY: Half advantage cost\n' if opportunity else '', _get_damage_value(user), _get_advantage_cost(user, opportunity), _get_regen_value(user)]