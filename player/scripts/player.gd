class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://bpxam8tipcr5g")


#region /// State Machine Variables
var states : Array[ PlayerState ]
var current_state : PlayerState : 
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// On Ready Variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_shape_cast: ShapeCast2D = $OneWayPlatformShapeCast
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion



#region /// export variables
@export var move_speed : float = 150.0
@export var jump_speed : float = 450.0
@export var crouch_retardation_rate : float = 10
#endregion

#region /// Standard Variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_multiplier : float = 1
#endregion

func _ready() -> void:
	# initialize states
	initialize_states()
	pass


func _process(_delta: float) -> void:
	update_direction()
	change_state( current_state.process( _delta) )
	pass


func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handle_input( event ) )
	pass

# Not framerate dependent
# _delta (_) means variable may not be intended to use
func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta * gravity_multiplier
	move_and_slide()
	change_state( current_state.physics_process( _delta) )
	pass


func initialize_states() -> void:
	states = []
	# gather all states
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
		pass
		
	if states.size() == 0:
		return
		
	# initialize all states
	for state in states:
		state.init()
		
	# set our first state
	change_state( current_state )
	current_state.enter()
	pass


func change_state( new_state : PlayerState) -> void:
	$StateLabel.text = current_state.name
	if new_state == null: 
		return
	elif new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
		
	states.push_front( new_state )
	current_state.enter()
	states.resize( 3 )
	pass

func update_direction() -> void:
	var prev_direction : Vector2 = direction
	#direction = Input.get_vector( "left", "right", "up", "down") // common joystick bug
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	
	if prev_direction.x != direction.x:
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
	pass
	
	
func add_debug_indicator( color : Color = Color.RED) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3 ).timeout
	d.queue_free()
	pass
