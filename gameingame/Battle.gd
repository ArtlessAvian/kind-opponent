# Acts as a model in MVC

extends Node
signal user_feedback
signal update_bars
signal opportunity_turn
signal update_text
signal player_action
signal enemy_action

export(NodePath) var end_game_screen_path
var end_game_screen
var yielding_for_queue = []
var turn = 0 # why not its free
var turn_state = null
var opportunity_attack
var bonus_believability = 0

func _ready():
	randomize()
	end_game_screen = get_node(end_game_screen_path)
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
		10, \
		16 * exp(- pow($Opponent.advantage - 100, 2) / 2450), \
		10 / (0.0035 * $Opponent._health + 0.2) * (1 + 0.4 * atan(0.075 * ($Opponent.last_damage - 100))), \
		10 - 5 * atan(0.03 * ($Opponent.advantage - 80)) \
	]

	if $Player._health < 20:
		weights[0] += 1000
	
	if $Player._health < $Opponent.advantage * $Opponent.get_child(0).get_child(1).efficiency:
		weights[1] += 1000
	
	var expected_heal = $Opponent.get_child(0).get_child(2)._get_heal_value($Opponent, false)
	if expected_heal / 2 > $Opponent.max_health - $Opponent._health:
		weights[2] *= ($Opponent.max_health - $Opponent._health) * 2 / expected_heal

	var allowed = [
		$Opponent.get_child(0).get_child(0).available($Opponent),
		$Opponent.get_child(0).get_child(1).available($Opponent),
		$Opponent.get_child(0).get_child(2).available($Opponent),
		$Opponent.get_child(0).get_child(3).available($Opponent)
	]
	
	print(str("weight array ", weights, " allowed ", allowed))

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
				return action_index

func _get_opportunity_attack():
	opportunity_attack = randi() % 12
	print("opportunity_attack ", opportunity_attack)

# hooooooo boy
func update_bars():
	self.emit_signal("update_bars")
	
func _game_logic(player_action):
	turn += 1
	self._text_box(str("Turn ", turn, ":"))
	yield()

	self._text_box("Player " + ["zaps the opponent with concentrated magic", "calls down a series of lightning bolts", "reinforces its shields", "gathers energy from the earth"][player_action] + "!")
	self.emit_signal("player_action",player_action)
	if (opportunity_attack == player_action):
		bonus_believability += 1
	$Player.do_move(player_action, opportunity_attack == player_action)
	yield()

	self.emit_signal("update_bars")

	yield()

	if ($Opponent.is_dead()):
		self._text_box("You are winnr (jk you lose)")
		end_game_screen.make_visible(0,0)
	
	else:
		var opponent_move = _get_opponent_move()
		self._text_box("The opponent " + ["bashes you with its staff", "calls down a meteor", "reinforces its shields", "raises its staff and focuses"][opponent_move] + "!")
		yield()
		$Opponent.do_move(opponent_move, false)
		self.emit_signal("enemy_action",opponent_move)

		yield()
		self.emit_signal("update_bars")
		if ($Player.is_dead()):
			self._text_box("You are ded (jk you win)")
			var score = floor(min(100, pow($Opponent._health - 400, 2)/1500 + 10 * bonus_believability))
#			self._text_box(str("Believability: ", 120/$Opponent._health, "%"))
			if score <80:
				end_game_screen.make_visible(1,score)
			else:
				end_game_screen.make_visible(2,score)
				
	if randi()%3 == 0:
		self.emit_signal("update_text")
	self._get_opportunity_attack()

func _text_box(text):
	print(text)
	self.emit_signal("user_feedback", text, true)

func threshold_passed(thingy):
	_text_box(str("A layer of ", thingy.name, "'s shield shatters, and it gathers the residual energy."))
#	self.emit_signal("update_bars")
	thingy.advantage += 60
	thingy.max_health -= 100