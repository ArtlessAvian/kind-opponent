# Acts as a model in MVC

extends Node
signal user_feedback
signal update_bars
signal opportunity_turn

var yielding_for_queue = []
var turn = 0 # why not its free
var turn_state = null
var opportunity_attack

func _ready():
	randomize()
	$Player.opponent = $Opponent
	$Opponent.opponent = $Player
	self._get_opportunity_attack()

# Abuses yield to hand off stuff to the view
func _on_button_down(player_action):
	turn_state = _game_logic(player_action)

func _process(delta):
	if (!yielding_for_queue.empty()):
		for thing in yielding_for_queue:
			if (thing._thing(delta)):
				yielding_for_queue.erase(thing)
	if (yielding_for_queue.empty() and turn_state != null):
		turn_state = turn_state.resume()

func _get_opponent_move():
	# 0 = Attack
	# 1 = Adv Attack
	# 2 = Heal
	# 3 = Charge
	var weights = [
		1000 if $Player._health < 20 else 10, \
		10000 if $Player._health < $Opponent.advantage else 20 * exp(- 0.5 * pow($Opponent.advantage - 100, 2) / 1600), \
		$Opponent.last_damage / 4, \
		200 / max($Opponent.advantage, 0.1) \
	]

	
	var allowed = [
		$Opponent.advantage >= $Opponent.get_child(0).get_child(0).advantage_cost,
		$Opponent.advantage > 0,
		$Opponent.advantage >= $Opponent.get_child(0).get_child(2).advantage_cost,
		true
	]
	
	print("Weight array:", weights)
	print("allowed actions: ", allowed)

	var total_weight = 0
	for action_index in range(4):
		if allowed[action_index]:
			total_weight += pow(weights[action_index], 2) # Probability is proportional to wave function squared
			
	var weight_target = rand_range(0, total_weight)
	print("total weight %f target weight %f" % [total_weight, weight_target])
	for action_index in range(4):
		if allowed[action_index]:
			weight_target -= pow(weights[action_index], 2)

			if weight_target <= 0:
				print("action index ", action_index)
				return action_index

func _get_opportunity_attack():
	opportunity_attack = randi() % 12

# hooooooo boy
	
func _game_logic(player_action):
	turn += 1
	self._text_box(str("Turn ", turn, ":"))
	yield()

	self._text_box("Player " + ["attacks", "attacks (but differently)", "heals", "charges"][player_action] + "!")
	yield()
	$Player.do_move(player_action, opportunity_attack == player_action)
	self.emit_signal("update_bars")
	yield()

	if ($Opponent.is_dead()):
		self._text_box("You are winnr (jk you lose)")
	
	else:
		var opponent_move = _get_opponent_move()
		self._text_box("The opponent " + ["attacks", "attacks (but differently)", "heals", "charges"][opponent_move] + "!")
		yield()
		$Opponent.do_move(opponent_move, false)
		self.emit_signal("update_bars")
		yield()

		if ($Player.is_dead()):
			self._text_box("You are ded (jk you win)")
			self._text_box(str("Believability: ", 120/$Opponent._health, "%"))

	self._get_opportunity_attack()

func _text_box(text):
	print(text)
	self.emit_signal("user_feedback", text, true)