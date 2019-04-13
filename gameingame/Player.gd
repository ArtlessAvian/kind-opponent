#Contains moves, hp, and advantange

extends Node

# Stuff
var opponent;

export (int, 0) var maxHealth = 100

onready var health = maxHealth
var advantage = 0

func temporary():
	opponent.health -= 10
	print(self.name, " uses Attack or something!")
	print(opponent.name, " takes 10 damage")