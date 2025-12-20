@icon("res://player/states/state.svg")
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region /// state references
# reference to all other states
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall
@onready var crouch: PlayerStateCrouch = %Crouch

#endregion

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
	return null
	

# what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	return null
	
# what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	return null
