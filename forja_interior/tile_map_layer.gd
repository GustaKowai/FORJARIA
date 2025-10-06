extends TileMapLayer

@onready var obstacles:TileMapLayer = $"../props"

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	for n in range(0,4):
		if coords in obstacles.get_used_cells_by_id(n):
			return true
	return false

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	tile_data.set_navigation_polygon(0,null)
