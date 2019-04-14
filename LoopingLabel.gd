extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
export (NodePath) var battle_path = "../../Battle";
var battle
var label1
var label2
var opacity
var fade_duration = .3
var fade_timer = 0
var is_visible = false

func _ready():
	battle = get_node(battle_path)
	label1 = get_node("OpportunityLabel")
	label2 = get_node("OpportunityLabel2")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_visible = battle.opportunity_attack < 4
	_update_opacity(delta)

func _update_opacity(delta):
	if is_visible:
		if fade_timer < fade_duration:
			fade_timer += delta
		else:
			fade_timer = fade_duration
		opacity = lerp(0,1,fade_timer/fade_duration)
	else:
		if fade_timer > 0:
			fade_timer -= delta
		else:
			fade_timer = 0
		opacity = lerp(0,1,fade_timer/fade_duration)
	self.modulate = Color(0,0,0,opacity)
	
