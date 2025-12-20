class_name PlayerStateRun extends PlayerState

# what happens when state is initialized
func init() -> void:
	pass
	
# what happens when we enter the state
func enter() -> void:
	pass
	
# what happens when we exit the state
func exit() -> void:
	pass
	
# what happens an input is pressed or released
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state
	

# what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state
	
# what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if player.is_on_floor() == false:
		return fall
	return next_state
