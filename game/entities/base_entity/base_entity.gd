extends CharacterBody2D
class_name Entity


@onready var sec_timer = $SecTimer
@onready var hp_regen_cooldown_timer = $HpRegenCooldownTimer
@onready var cpu_particles = $CPUParticles


#region Draw var
const BORDER_RADIUS = 16.0
const BODY_RADIUS = 14.0
var hp_radius := BODY_RADIUS

var border_color := Color.BLACK
var hp_color : Color
var body_color : Color
#endregion


#region Move var
const DEFAULT_SPEED := 100
var speed := DEFAULT_SPEED
var move_direction_vector : Vector2 = Vector2.DOWN
#endregion


#region Health var
var max_hp := 1
var hp := 1
var hp_regen_available := true
var hp_regen_per_sec := 1
var hp_regen_cooldown := 5
#endregion


#region Process functions
func _physics_process(_delta):
	move()

func _on_sec_timer_timeout():
	hp_regen()
#endregion


#region Draw functions
func update_hp_radius():
	hp_radius = BODY_RADIUS * (hp / max_hp)

func redraw():
	pass
#endregion


#region Move functions
func move():
	pass

func move_step():
	velocity = move_direction_vector * speed
	move_and_slide()
#endregion


#region Damage functions
func take_damage(input_damage : int):
	hp -= input_damage

	update_hp_radius()
	redraw()

	if hp <= 0:
		die()

func die():
	queue_free()
#endregion


#region Health functions
func heal_hp(heal : int):
	hp += heal
	if hp > max_hp:
		hp = max_hp

	update_hp_radius()
	redraw()

func hp_regen():
	if hp < max_hp and hp_regen_available:
		heal_hp(hp_regen_per_sec)

func start_hp_cooldown():
	hp_regen_available = false
	hp_regen_cooldown_timer.wait_time = hp_regen_cooldown
	hp_regen_cooldown_timer.start()

func _on_hp_regen_cooldown_timer_timeout():
	hp_regen_available = true
#endregion
