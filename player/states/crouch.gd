class_name PlayerStateCrouch extends PlayerState

# what happens when state is initialized
func init() -> void:
	pass
	
# what happens when we enter the state
func enter() -> void:
	# play animation
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	player.sprite.scale.y = 0.625
	pass
	
# what happens when we exit the state
func exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	player.sprite.scale.y = 1.0
	pass
	
# what happens an input is pressed or released
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if player.one_way_platform_raycast.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
	return next_state
	

# what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state
	
# what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * player.crouch_retardation_rate * _delta
	if player.is_on_floor() == false:
		return fall
	return next_state
