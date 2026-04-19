extends Resource

class_name Weapon

@export var title: String
@export var texture: Texture2D

@export var damage:float
@export var cooldown: float
@export var speed: float

# variable to preload projectile node
@export var projectile_node_reference: PackedScene \
	= preload("res://scenes/projectile.tscn")

# abstract method that will be overriden in Concrete Class
func activate(_source, _target, _scene_tree):
	pass
