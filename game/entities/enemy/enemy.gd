extends Entity


@onready var border_polygon = $BorderPolygon
@onready var body_polygon = $BodyPolygon
@onready var hp_polygon = $HpPolygon
@onready var collision_polygon = $CollisionPolygon
@onready var hit_box_collision_polygon = $HitBox/HitBoxCollisionPolygon

@onready var player = get_parent().get_node_or_null("Player")


#region Polygon var
const MIN_ANGLES_NUMBER = 8
var angles_number : int
var normalized_polygon : PackedVector2Array
#endregion


#region Init functions
func _init(new_angles_number : int = MIN_ANGLES_NUMBER):
	if new_angles_number < MIN_ANGLES_NUMBER:
		new_angles_number = MIN_ANGLES_NUMBER
	angles_number = new_angles_number

	speed = angles_number * 10

	max_hp = angles_number
	hp = max_hp

	attack_damage = angles_number

	set_normalized_polygon()

func _ready():
	var polygon = new_polygon(BORDER_RADIUS)
	collision_polygon.polygon = polygon
	hit_box_collision_polygon.polygon = polygon
	border_polygon.polygon = polygon
	body_polygon.polygon = new_polygon(BODY_RADIUS)
	hp_polygon.polygon = new_polygon(hp_radius)
	set_color()
	set_random_rotation()

func set_color():
	choose_random_color()
	border_polygon.color = border_color
	body_polygon.color = body_color
	hp_polygon.color = hp_color
	die_cpu_particles.color = hp_color

func choose_random_color():
	hp_color = Color(
		Global.rng.randfn(), 
		Global.rng.randfn(), 
		Global.rng.randfn())
	body_color = hp_color / 2
	body_color.a = 1.0

func set_random_rotation():
	self.rotation = Global.rng.randf_range(0.0, 2 * PI)
#endregion


#region Draw functions
func redraw():
	hp_polygon.polygon = new_polygon(hp_radius)
#endregion


#region Move functions
func move():
	if player:
		move_direction_vector = global_position.direction_to(player.global_position).normalized()
		move_step()
	else:
		player = get_parent().get_node_or_null("Player")
#endregion


#region Attack functions
func attack(body):
	body.take_damage(attack_damage)
	die()

func _on_hit_box_body_entered(body):
	if body.is_in_group("player"):
		attack(body)
#endregion


#region Polygon functions
func new_polygon(factor : int):
	var polygon = normalized_polygon.duplicate()
	for i in polygon.size():
		polygon[i] *= factor
	return polygon

func set_normalized_polygon():
	var angle_between_points := 2 * PI / angles_number
	var current_angle := 0.0
	for i in angles_number:
		var next_normalized_point = Vector2.from_angle(current_angle).normalized()
		normalized_polygon.append(next_normalized_point)
		current_angle += angle_between_points
#endregion
