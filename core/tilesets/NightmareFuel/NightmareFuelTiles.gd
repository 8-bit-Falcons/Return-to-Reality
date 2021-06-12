extends TileMap

const tileUtils = preload("res://tilesets/util/TileSetUtils.gd")
const fuel = preload("res://scenes/misc/NightmareFuel/NightmareFuel.tscn")
const base = preload("res://scenes/misc/NightmareFuel/NightmareFuelBase.tscn")


func _ready():
	tileUtils.replace_placeholders(get_used_cells_by_id(0), fuel, self)
	tileUtils.replace_placeholders(get_used_cells_by_id(1), base, self)
