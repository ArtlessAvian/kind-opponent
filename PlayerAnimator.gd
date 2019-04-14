extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
signal update_bars
var attack_anim_player
var idle_anim_player
func _ready():
	attack_anim_player = get_node("AttackAnimPlayer")
	idle_anim_player = get_node("IdleAnimPlayer")


func play_attack():
	idle_anim_player.stop(true)
	attack_anim_player.play("AttackAnimation")

func signal_bars():
	print("SIGNAL")
	self.emit_signal("update_bars")
func restart_idle():
	idle_anim_player.play("IdleBounce")

