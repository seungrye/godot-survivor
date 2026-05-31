extends TextureButton

@export var weapon: Weapon:
	set(value):
		weapon = value
		
		texture_normal = value.texture
		$Label.text = 'Lvl ' + str(weapon.level + 1)
		$"Description-Label".text = value.upgrades[value.level - 1].description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and weapon:
		print(weapon.title)
		weapon.upgrade_item()
		self.get_parent().close_option()
