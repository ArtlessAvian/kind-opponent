extends RichTextLabel

var blocking = true
var done_time = 0
var characters = 0

func _thing(delta):
	self.percent_visible = min(1, self.percent_visible + delta * 60 / characters)
	if (self.percent_visible == 1):
		done_time += delta
		if (done_time > 1 or Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("click_anywhere")):
			return true

func _on_Battle_user_feedback(text, blocking):
	done_time = 0
	
	self.percent_visible = float(characters) / (characters + len(text))
	characters += len(text)
	
	self.text += "\n" + text
	if blocking:
		$"../../../Battle".yielding_for_queue.push_back(self)
