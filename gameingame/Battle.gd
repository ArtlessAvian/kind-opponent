# Acts as a model in MVC

extends Node

#var action_queue = []
var turn = 0 # why not its free

func _ready():
	$Player.opponent = $Opponent
	$Opponent.opponent = $Player

# Update the model instantly
func _on_button_down(player_action):
	turn += 1
	print(str("Turn ", turn, ":"))
	
	$Player.temporary()
	if ($Opponent.health <= 0):
		print("You are winnr (jk you lose)")
		return
		
	$Opponent.temporary()
	if ($Player.health <= 0):
		print("You are winnr (jk you lose)")
		return	
