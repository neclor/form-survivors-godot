extends Node2D


var player = get_parent()


func _draw():
	draw_circle(Vector2.ZERO, player.BORDER_RADIUS, player.border_color)
	draw_circle(Vector2.ZERO, player.BODY_RADIUS, player.body_color)
	draw_circle(Vector2.ZERO, player.hp_radius, player.hp_color)
