extends RichTextLabel

export(float) var reveal_speed
export(float) var reveal_duration
export(float) var fade_duration

var opacity
var fade_timer
var reveal_timer
var perc_visible
var lines
export(NodePath) var speech_bubble
var battle_path
var battle
var is_active

func _ready():
	battle = get_node("../../../../Battle")
	speech_bubble = self.get_node(speech_bubble) 
	speech_bubble.visible = false
	reveal_timer = 0
	fade_timer = fade_duration
	reveal_timer = reveal_duration
	perc_visible = 0
	is_active = false
	_initialize_lines()


func _process(delta):
	if is_active:
		if reveal_timer > 0:
			if perc_visible < 1:
				perc_visible += reveal_speed*delta
			reveal_timer -= delta
			self.percent_visible = perc_visible
		else:
			if fade_timer > 0:
				fade_timer -= delta
				opacity = lerp(0,1,fade_timer/fade_duration)
				speech_bubble.modulate = Color(1,1,1,opacity)
			else:
				speech_bubble.visible = false
				is_active = false
			
func _initialize_lines():
	lines = []
	lines.append("I'm gonna get you!")
	lines.append("You're cheating!")
	lines.append("Just you wait...")
	lines.append("F**K!")
	lines.append("I didn't mean to do that.")
	lines.append("Whoops...")
	lines.append("Just give up already!")



func set_rand_line():
	battle.yielding_for_queue.push_back(self)


func _thing(delta):
	var rand_index = randi()%len(lines)
	var text = lines[rand_index]
	perc_visible = 0
	self.text = text
	self.percent_visible = perc_visible
	speech_bubble.visible = true
	speech_bubble.modulate = Color(1,1,1,1)
	reveal_timer = reveal_duration
	fade_timer = fade_duration
	is_active = true
	return true