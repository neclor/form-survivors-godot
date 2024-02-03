extends Entity


@onready var circle = $Circle


#region Draw var
const HP_COLOR = Color.RED
const BODY_COLOR = Color("#800000")
#endregion


#region Init functions
func _init():
	max_hp = 10
	hp = max_hp
	update_hp_radius()
	set_color()

func set_color():
	hp_color = HP_COLOR
	body_color = BODY_COLOR
#endregion


#region Draw functions
func redraw():
	circle.queue_redraw()
#endregion


#region Move functions
func move():
		var input_move_direction_vector = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
		move_direction_vector = input_move_direction_vector.normalized()
		move_step()
#endregion
