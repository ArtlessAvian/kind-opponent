extends Button

export (NodePath) var player_path = "../../../../../Battle/Player";
export (int, 0, 3) var move_id
var default_color
var opportunity_color = Color(0.8,0,0)
var battle
var player
var move

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	# temporary hardcoding
	player = self.get_node(player_path)
	battle = player.get_node("..")
	move = player.get_node("Moves").get_child(move_id)
	self.text = move.name
	default_color = get("custom_colors/font_color")

func _process(delta):
	self.disabled = (not move.available(player)) or player.is_dead() or player.get_parent().turn_state != null
	set("custom_colors/font_color",opportunity_color if battle.opportunity_attack == move_id else default_color)
	# ----------------------------------------------------------------- the battle. ^^^^^^^^^^^^ nice
	