extends RichTextLabel

export(float) var reveal_speed
export(float) var reveal_duration
export(float) var fade_duration
var opacity
var fade_timer
var reveal_timer
var perc_visible
export(NodePath) var speech_bubble
func _ready():
	speech_bubble = self.get_node(speech_bubble) 
	speech_bubble.visible = false
	reveal_timer = 0
	fade_timer = fade_duration
	reveal_timer = reveal_duration
	perc_visible = 0

func _process(delta):
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


func set_text(text):
	perc_visible = 0
	self.text = text
	self.percent_visible = perc_visible
	speech_bubble.visible = true
	speech_bubble.modulate = Color(1,1,1,1)
	reveal_timer = reveal_duration
	fade_timer = fade_duration
