extends TileMap

const platform_scene = preload("res://scenes/misc/DisappearingPlatform/DisappearingPlatform.tscn")


func _ready():
	var disappearing_tiles = get_used_cells_by_id(0)  
	# gets an array of cells in the tilemap which contain the tile with an index of zero in the tile set
	for tile in disappearing_tiles:
		var new_tile = platform_scene.instance()  # gets a new instance of the scene, including child nodes
		new_tile.set_position(map_to_world(tile))  
		# Gets the position of the placeholder tile and sets the scene position to that
		set_cell(tile.x, tile.y, -1)  # clears the tile
		self.add_child(new_tile)  # puts an instance of the scene at the same location
