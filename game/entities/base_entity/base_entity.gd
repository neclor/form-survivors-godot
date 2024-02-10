extends CharacterBody2D
class_name Entity


@onready var sec_timer = $SecTimer
@onready var hp_regen_cooldown_timer = $HpRegenCooldownTimer
@onready var die_cpu_particles = $DieCPUParticles


#region Draw var
const BORDER_RADIUS = 16.0
const BODY_RADIUS = 14.0
var hp_radius := BODY_RADIUS

var border_color := Color.BLACK
var hp_color : Color
var body_color : Color
#endregion


#region Move var
var speed : int
var move_direction_vector : Vector2 = Vector2.DOWN
#endregion


#region Health var
var max_hp : int
var hp : int
var hp_regen_available : bool
var hp_regen_per_sec : int
var hp_regen_cooldown := 5
#endregion


#region Attack var
var attack_damage : int
#endregion


#region Process functions
func _physics_process(_delta):
	move()

func _on_sec_timer_timeout():
	hp_regen()
#endregion


#region Draw functions
func update_hp_radius():
	hp_radius = BODY_RADIUS * hp / max_hp
	redraw()

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
	start_hp_cooldown()
	if hp <= 0:
		die()

func die():
	start_particle_animation()

func start_particle_animation():
	die_cpu_particles.restart()

func _on_die_cpu_particles_finished():
	queue_free()
#endregion


#region Health functions
func heal_hp(heal : int):
	hp += heal
	if hp > max_hp:
		hp = max_hp

	update_hp_radius()

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
