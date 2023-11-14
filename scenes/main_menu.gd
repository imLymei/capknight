extends Control


const PORT = 4433


func _ready():
	if DisplayServer.get_name() == 'headless':
		print("Automatically starting dedicated server.")
		_on_host_pressed().call_deferred()


func _on_host_pressed():
	print("HOST")
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()


func _on_connect_pressed():
	print("CONNECT")
	var address: String = $Address.text
	if address == '':
		OS.alert("Need a address to connect")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(address, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()


func start_game():
	get_tree().change_scene_to_file("res://scenes/main_test.tscn")
