class_name PlayerStateJump extends PlayerState

# what happens when state is initialized
func init() -> void:
	pass
	
# what happens when we enter the state
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -player.jump_speed
	
	# fix2-> avoid high jump if jump was released before entering here (BUFFER JUMP)
	if player.previous_state == fall and not Input.is_action_pressed("jump"):
		await get_tree().physics_frame
		player.velocity.y *= 0.5
		player.change_state( fall )
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
	set_jump_frame()
	return next_state
	
# what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state

func set_jump_frame() -> void:
	# important
	var frame : float = remap(player.velocity.y, -player.jump_speed, 0.0, 0.0, 0.5)
	player.animation_player.seek( frame, true)
	pass
