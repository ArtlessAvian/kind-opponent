extends Button

export (NodePath) var player_path = "../../../../../Battle";
export (int, 0, 3) var move_id
var player
var move

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	# temporary hardcoding
	player = self.get_node(player_path)
	move = player.get_node("Moves").get_child(move_id)
	self.text = move.name

func _process(delta):\
	self.disabled = not move.available(player) or player.is_dead() or player.get_parent().turn_state != null
	# ----------------------------------------------------------------- the battle. ^^^^^^^^^^^^ nice