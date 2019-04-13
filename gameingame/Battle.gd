# Acts as a model in MVC

extends Node
signal user_feedback
signal update_bars

var yielding_for_queue = []
var turn = 0 # why not its free
var turn_state = null

func _ready():
	$Player.opponent = $Opponent
	$Opponent.opponent = $Player

# Abuses yield to hand off stuff to the view
func _on_button_down(player_action):
	turn_state = _game_logic(player_action)

func _process(delta):
	if (!yielding_for_queue.empty()):
		if (yielding_for_queue[0]._thing(delta)):
			yielding_for_queue.pop_front()
	if (yielding_for_queue.empty() and turn_state != null):
		turn_state = turn_state.resume()

func _get_opponent_move():
	if ($Opponent.advantage < 5): return 3
	return randi() % 3 # dont charge

# hooooooo boy

func _game_logic(player_action):
	turn += 1
	self._text_box(str("Turn ", turn, ":"))
	yield()

	self._text_box("player used " + ["attack", "attack but different", "heal", "charge"][player_action])
	yield()
	$Player.do_move(player_action)
	self.emit_signal("update_bars")
	yield()

	if ($Opponent.is_dead()):
		self._text_box("You are winnr (jk you lose)")
		return

	var opponent_move = _get_opponent_move()
	self._text_box("opponent used " + ["attack", "attack but different", "heal", "charge"][opponent_move])
	yield()
	$Opponent.do_move(opponent_move)
	self.emit_signal("update_bars")
	yield()

	if ($Player.is_dead()):
		self._text_box("You are ded (jk you win)")
		self._text_box(str("Believability: ", 120/$Opponent._health, "%"))
		return

func _text_box(text):
	self.emit_signal("user_feedback", text)