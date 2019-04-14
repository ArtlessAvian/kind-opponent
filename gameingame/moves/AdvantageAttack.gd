extends Node

export (float, 0, 2) var efficiency = 0.8
export (float, 0, 2) var regen = 0.03
export (float, 0, 2) var knockback = 5

func _get_damage_value(user):
	return user.advantage * efficiency

func _get_advantage_cost(user, opportunity):
	return (user.advantage / 2) if opportunity else user.advantage

func _get_regen_value(user):
	return regen * (user.max_health - user._health)

func _get_knockback_value(user):
	return knockback * (1 if user.advantage else 0)

func run(user, opponent, opportunity):
	opponent.take_damage(_get_damage_value(user))
	user.take_damage(_get_knockback_value(user))
	user.advantage = (user.advantage / 2) if opportunity else 0
	#user.get_healed(_get_regen_value(user))

func available(user):
	return user.advantage > 0

func summary(user, opportunity):
	return 'Lightning Barrage [%d/-%d/-%d]' % [_get_damage_value(user), _get_advantage_cost(user, opportunity), _get_knockback_value(user)]

func describe(user, opportunity):
	return """
		Use all your mana to fire a devastating barrage of lightning.
		Damage is equal to 80%% of your current mana.
		The hail is unpredictable and deals a small amount of damage backlash to the caster.
		%s
		Damage: %d
		Mana Cost: %d
		Damage to Caster: %d
	""" % ['\nPERFECT OPPORTUNITY: Half advantage cost\n' if opportunity else '', _get_damage_value(user), _get_advantage_cost(user, opportunity), _get_knockback_value(user)]