extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
export(NodePath) var hit_sound_path
export(NodePath) var click_sound_path
export(NodePath) var heal_sound_path
export(NodePath) var charge_sound_path
var hit_sound
var click_sound
var heal_sound
var charge_sound
func _ready():
	hit_sound = get_node(hit_sound_path)
	click_sound = get_node(click_sound_path)
	heal_sound = get_node(heal_sound_path)
	charge_sound = get_node(charge_sound_path)


func hit_sound():
	hit_sound.play(0)
func click_sound():
	click_sound.play(0)
func heal_sound():
	heal_sound.play(0)
func charge_sound():
	charge_sound.play(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
