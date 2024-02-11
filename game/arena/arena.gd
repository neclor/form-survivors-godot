extends Node2D


@onready var paralax_tile_map = $ParallaxBackground/ParallaxLayer/ParalaxTileMap
@onready var arena_tile_map = $ArenaTileMap
const ENEMY = preload("res://game/entities/enemy/enemy.tscn")

const ARENA_RADIUS = 17


func _ready():
	create_arena()
	create_paralax_background()


func create_arena():
	arena_tile_map.set_cells_terrain_connect(0, create_cells_array(), 0, 0)


func create_paralax_background():
	paralax_tile_map.set_cells_terrain_connect(0, create_cells_array(), 0, 0)


func create_cells_array():
	var cells_array : Array
	for i in range(-ARENA_RADIUS, ARENA_RADIUS):
		for j in range(-ARENA_RADIUS, ARENA_RADIUS):
			cells_array.append(Vector2i(i, j))
	return cells_array


func _on_enemy_spawner_timer_timeout():
	var a = randi_range(4, 8)
	print(a)

	var new_enemy = Enemy.new(a)
	#new_enemy.instantiate() ENEMY.instantiate(4)
	add_child(new_enemy)
	pass

