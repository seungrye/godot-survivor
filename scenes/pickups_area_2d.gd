extends Area2D

var direction: Vector2
var speed: float = 175
var can_follow: bool = false

@export var type: Pickups
@export var player_reference: CharacterBody2D:
	set(value):
		player_reference = value
		type.player_reference = value

func _ready() -> void:
	$Sprite2D.texture = type.icon

func _physics_process(delta: float) -> void:
	if self.player_reference and self.can_follow:
		self.direction = (self.player_reference.position - self.position).normalized()
		self.position += self.direction * self.speed * delta

func _on_body_entered(body: Node2D) -> void:
	self.type.activate()
	queue_free()

func follow(_target: CharacterBody2D):
	self.can_follow = true
