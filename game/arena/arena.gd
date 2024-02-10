extends Node2D

@onready var tile_map = $TileMap
#@onready var tile_map_2 = $ParallaxBackground/ParallaxLayer/TileMap

func _ready():
	var cells_array : Array
	for i in range(-17, 17):
		for j in range(-17, 17):
			cells_array.append(Vector2i(i, j))
			tile_map.set_cell(0, Vector2i(i, j), 0, Vector2i(0, 0))
			#tile_map_2.set_cell(0, Vector2i(i, j), 0, Vector2i(0, 0))
	
	tile_map.set_cells_terrain_connect(0, cells_array, 0, 0)
	#tile_map_2.set_cells_terrain_connect(0, cells_array, 0, 0)

	
	tile_map.update_internals()

