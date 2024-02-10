extends Entity


@onready var player_circle = $PlayerCircle


#region Draw var
const HP_COLOR = Color.RED
const BODY_COLOR = Color("#800000")
#endregion


#region Init functions
func _init():
	speed = 160

	max_hp = 100
	hp = max_hp
	hp_regen_available = true
	hp_regen_per_sec = 5

	attack_damage = 1

	set_color()

func set_color():
	hp_color = HP_COLOR
	body_color = BODY_COLOR

func _ready():
	die_cpu_particles.color = HP_COLOR
#endregion


#region Draw functions
func redraw():
	player_circle.queue_redraw()
#endregion


#region Move functions
func move():
		var input_move_direction_vector = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
		move_direction_vector = input_move_direction_vector.normalized()
		move_step()
#endregion
