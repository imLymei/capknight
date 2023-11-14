extends MultiplayerSynchronizer


@export var direction := Vector2()
var say_hello = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("%d / %d = %s" % [get_multiplayer_authority(), multiplayer.get_unique_id(), get_multiplayer_authority() == multiplayer.get_unique_id()]) 
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not say_hello:
		print('hello from %s at %s' % [multiplayer.get_unique_id(), get_multiplayer_authority()])
		say_hello = true
	direction = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
