class_name Player
extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_input = $PlayerInput
@onready var id = $ID

@export var speed := 100.0
@export var accel := 800.0

@export var player := 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		$PlayerInput.set_multiplayer_authority(id)


func _ready():
	$CanvasLayer/Label.text = str(multiplayer.get_unique_id())
	id.text = str(player)
	
	if player == multiplayer.get_unique_id():
		$Camera.make_current()


func _physics_process(delta: float) -> void:
	player_input.direction = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	
	velocity = velocity.move_toward(player_input.direction * speed, accel * delta)
	
	_update_animation()
	
	move_and_slide()


func _update_animation():
	if player_input.direction == Vector2.ZERO:
		animated_sprite_2d.play("Idle")
		return
	
	animated_sprite_2d.play("Run")
	
	if player_input.direction.x != 0:
		animated_sprite_2d.flip_h = player_input.direction.x < 0 
