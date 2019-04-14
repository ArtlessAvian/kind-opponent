extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var play_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if play_pressed:
#		$"../Background".color.r -= 0.7 * delta
#		$"../Background".color.g -= 0.7 * delta
#		$"../Background".color.b -= 0.7 * delta
#		if ($"../Background".color.r <= 0):
	

func play_press():
	play_pressed = true
	$"../TransitionToGame/".visible = true
	$"../TransitionToGame/AnimationPlayer".play("New Anim")

func credits_press():
	$"../Credits".visible = true
	
func quit_press():
	get_tree().quit()

func _on_Button_button_down(): # credits button back
	$"../Credits".visible = false


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://gameoutsidegame/CutsceneThing.tscn")
