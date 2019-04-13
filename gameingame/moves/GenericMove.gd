extends Node

export (int, FLAGS, "self_health", "self_adv", "other_health", "other_adv") var affects
export (int) var advantage_cost = 0

func run(user, opponent):
	user.advantage += 10