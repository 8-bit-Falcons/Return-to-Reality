extends TileMap

const tileUtils = preload("res://tilesets/util/TileSetUtils.gd")
const clouds = preload("res://scenes/misc/BouncyClouds/BouncyClouds.tscn")


func _ready():
	tileUtils.replace_placeholders(get_used_cells_by_id(0), clouds, self)
