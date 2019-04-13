extends Button

var advantage_cost

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	# temporary hardcoding
	var move = $"../../Player/Moves".get_child(self.get_index())
	self.text = move.name
	self.advantage_cost = move.advantage_cost

func _process(delta):
	self.disabled = $"../../Player".advantage < advantage_cost or $"../../Player".is_dead() or $"../..".turn_state != null
