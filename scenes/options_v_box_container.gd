extends VBoxContainer

@export var weapons: HBoxContainer
var OptionSlot = preload("res://scenes/option_slot_texture_button.tscn")

@export var particles: GPUParticles2D
@export var panel: NinePatchRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	particles.hide()
	panel.hide()

func close_option():
	self.hide()
	particles.hide()
	panel.hide()
	get_tree().paused = false

func get_available_weapons():
	var weapon_resources = []
	for weapon in weapons.get_children():
		if weapon.weapon != null:
			weapon_resources.append(weapon.weapon)
	return weapon_resources
			
func show_option():
	var weapons_available = get_available_weapons()
	if weapons_available.size() == 0:
		return
	
	for slot in get_children():
		slot.queue_free()
		
	var option_size = 0
	for weapon in weapons_available:
		if weapon.is_upgradable():
			var option_slot = OptionSlot.instantiate()
			option_slot.weapon = weapon
			add_child(option_slot)
			option_size += 1
			
	if option_size == 0:
		return

	self.show()
	particles.show()
	panel.show()
	get_tree().paused = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
