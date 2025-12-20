class_name PlayerStateJump extends PlayerState

# what happens when state is initialized
func init() -> void:
	pass
	
# what happens when we enter the state
func enter() -> void:
	
	player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -player.jump_speed
	pass
	
# what happens when we exit the state
func exit() -> void:
	player.add_debug_indicator(Color.YELLOW)
	pass
	
# what happens an input is pressed or released
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state
	

# what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	return next_state
	
# what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
