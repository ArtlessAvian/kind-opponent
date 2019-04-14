extends ColorRect

var do_fading

func _process(delta):
	if do_fading:
		self.color.a += delta * 0.5

func _on_Battle_game_over():
	do_fading = true
