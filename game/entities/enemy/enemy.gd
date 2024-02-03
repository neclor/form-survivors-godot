extends Entity


@onready var border_polygon = $BorderPolygon
@onready var body_polygon = $BodyPolygon
@onready var hp_polygon = $HpPolygon
@onready var collision_polygon = $CollisionPolygon


var angles_number := 3


#region Init functions
func _init(new_angles_number : int):
	if new_angles_number > 3:
		angles_number = new_angles_number

	max_hp = angles_number
	hp = max_hp
	update_hp_radius()



	set_color()


func set_color():
	choose_random_color()
	border_polygon.color = border_color
	body_polygon.color = body_color
	hp_polygon.color = hp_color

func choose_random_color():
	hp_color = Color(
		choose_random_color_part(), 
		choose_random_color_part(), 
		choose_random_color_part())
	body_color = hp_color / 2

func choose_random_color_part():
	const UP_COLOR_LIMIT = 1.0
	const LOW_COLOR_LIMIT = 0.5
	return Global.rng.randf_range(LOW_COLOR_LIMIT, UP_COLOR_LIMIT)
#endregion







func set_polygon():
	var angle_between_points := 2 * PI / angles_number
	var current_angle := 0.0
	for i in angles_number:
		var next_point_vector = Vector2.from_angle(current_angle).normalized()
		current_angle += angle_between_points











