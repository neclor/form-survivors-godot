extends Node2D


@onready var hp_regen_cooldown_timer = $HpRegenCooldownTimer


var max_hp : int
var hp : int
var hp_regen_available : bool
var hp_regen_per_sec : int
var hp_regen_cooldown : int


func redraw_hp():
	get_parent().redraw_hp()


func take_damage(input_damage : int):
	hp -= input_damage
	if hp <= 0:
		die()
		return
	start_hp_cooldown()
	redraw_hp()


func die():
	get_parent().die()


func _on_hp_regen_timer_timeout():
	regen_hp()


func heal_hp(input_heal : int):
	hp += input_heal
	if hp > max_hp:
		hp = max_hp
	redraw_hp()


func regen_hp():
	if hp < max_hp and hp_regen_available:
		heal_hp(hp_regen_per_sec)


func start_hp_cooldown():
	hp_regen_available = false
	hp_regen_cooldown_timer.wait_time = hp_regen_cooldown
	hp_regen_cooldown_timer.start()


func _on_hp_regen_cooldown_timer_timeout():
	hp_regen_available = true
