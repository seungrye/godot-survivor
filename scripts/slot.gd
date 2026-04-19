extends PanelContainer

@export var weapon: Weapon:
	set(value):
		weapon = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown


func _on_cooldown_timeout() -> void:
	if self.weapon:
		$Cooldown.wait_time = self.weapon.cooldown
		# self.owner might be player (see player.gd)
		self.weapon.activate(self.owner, self.owner.nearest_enemy, get_tree())
