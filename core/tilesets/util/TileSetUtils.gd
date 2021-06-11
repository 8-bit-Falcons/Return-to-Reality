extends Node


static func replace_placeholders(placeholder_cells: Array, scene: PackedScene, tile_map_instance: TileMap):
# Replaces all cells in `placeholder_cells` with scenes `scene`.
# placeholder cells: probably `get_cells_by_id(SOMEINT)`
# scene: a preloaded tscn file
# tile_map_instance: probably `self`

	for tile in placeholder_cells:
		var new_tile = scene.instance()  # gets a new instance of the scene, including child nodes
		new_tile.set_position(tile_map_instance.map_to_world(tile))  
		# Gets the position of the placeholder tile and sets the scene position to that
		tile_map_instance.set_cell(tile.x, tile.y, -1)  # clears the tile
		tile_map_instance.add_child(new_tile)  # puts an instance of the scene at the same location
