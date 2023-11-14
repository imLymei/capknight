extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not multiplayer.is_server():
		return
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)
	
	for id in multiplayer.get_peers():
		add_player(id)
	
	if not OS.has_feature('dedicated_server'):
		add_player(1)


func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)


func add_player(id: int):
	var character = preload("res://models/entities/player/player.tscn").instantiate()
	
	character.player = id
	
	character.position = Vector2(300, 140)
	character.name = str(id)
	add_child(character, true)


func del_player(id: int):
	if not has_node(str(id)):
		return
	get_node(str(id)).queue_free()
