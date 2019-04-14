extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_press():
	get_tree().change_scene("res://gameingame/BattleWView.tscn")

func credits_press():
	#get_tree().change_scene("res://Credits.tscn")
	pass
func quit_press():
	get_tree().quit()

