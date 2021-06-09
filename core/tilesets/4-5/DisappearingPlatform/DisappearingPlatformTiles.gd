extends TileMap

const dt = preload("res://scenes/misc/DisappearingPlatform/DisappearingPlatform.tscn")


func _ready():
	var disappearing_tiles = get_used_cells_by_id(0)
	for tile in disappearing_tiles:
		var new_tile = dt.instance()
		new_tile.set_position(map_to_world(tile))
		set_cell(tile.x, tile.y, -1)
		self.add_child(new_tile)
