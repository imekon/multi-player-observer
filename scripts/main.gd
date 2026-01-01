extends Node2D

var rocks = {}
var players = {}

var server_address = "localhost"
var server_port = 49641

func _ready() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(server_address, server_port)
	multiplayer.multiplayer_peer = peer

@rpc()
func rock_status(_id, _x, _y):
	var rock = Rock.new(_id, _x, _y)
	rocks[_id] = rock
	
@rpc()
func player_status(_id, _x, _y):
	var player = Player.new(_id, _x, _y)
	players[_id] = player

func _draw() -> void:
	for i in rocks:
		var rock = rocks[i]
		var x = rock.x / 128 + 1152 / 2
		var y = rock.y / 128 + 256
		draw_rect(Rect2(x - 1, y - 1, 3, 3), Color.GREEN)
		
	for i in players:
		var player = players[i]
		var x = player.x / 128 + 1152 / 2
		var y = player.y / 128 + 256
		draw_rect(Rect2(x - 1, y - 1, 3, 3), Color.WHITE)

func _process(_delta: float) -> void:
	queue_redraw()
