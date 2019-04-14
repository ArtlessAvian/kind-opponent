extends TextureRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
signal update_bars
var action_anim_player
var idle_anim_player
func _ready():
	action_anim_player = get_node("ActionAnimPlayer")
	idle_anim_player = get_node("IdleAnimPlayer")


func do_action(i):
	idle_anim_player.stop(true)
	if i == 0 or i == 1:
		action_anim_player.play("EnemyAttackAnimation")
	elif i == 2:
		action_anim_player.play("HealAnimation")
	else:
		action_anim_player.play("ChargeAnimation")


func signal_bars():
	print("SIGNAL")
	self.emit_signal("update_bars")
	
func restart_idle():
	idle_anim_player.play("IdleBounce")


