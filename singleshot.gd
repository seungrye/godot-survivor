extends Weapon
class_name SingleShot

func shoot(source, target, scene_tree):
	if target == null:
		print("there is no target")
		return

	var projectile = self.projectile_node_reference.instantiate()
	
	projectile.position = source.position
	# set properties of the projectile with the resource data
	projectile.damage = self.damage
	projectile.speed = self.speed
	projectile.direction = (target.position - source.position).normalized()
	
	scene_tree.current_scene.add_child(projectile)

func activate(_source, _target, _scene_tree):
	self.shoot(_source, _target, _scene_tree)
