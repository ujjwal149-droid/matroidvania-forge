class_name PlayerStateFall extends PlayerState

@export var fall_gravity_multiplier : float = 1.165
@export var cayote_time : float = 0.125
@export var jump_buffer_time : float = 0.2

var cayote_timer : float = 0
var buffer_timer : float = 0

# what happens when state is initialized
func init() -> void:
	pass
	
# what happens when we enter the state
func enter() -> void:
	# Play Animations
	player.gravity_multiplier = fall_gravity_multiplier
	if player.previous_state == jump:
		cayote_timer = 0
	else:
		cayote_timer = cayote_time
	pass
	
# what happens when we exit the state
func exit() -> void:
	player.gravity_multiplier = 1.0
	pass
	
# what happens an input is pressed or released
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if cayote_timer > 0:
			return jump
		else:
			buffer_timer = jump_buffer_time
	return next_state
	

# what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	cayote_timer -= _delta
	buffer_timer -= _delta
	return next_state
	
# what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator(Color.RED)
		if buffer_timer > 0:
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
