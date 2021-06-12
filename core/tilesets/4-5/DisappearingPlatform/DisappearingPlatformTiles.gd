extends TileMap

const tileUtils = preload("res://tilesets/util/TileSetUtils.gd")
const platform = preload("res://scenes/misc/DisappearingPlatform/DisappearingPlatform.tscn")


func _ready():
	tileUtils.replace_placeholders(get_used_cells_by_id(0), platform, self)

