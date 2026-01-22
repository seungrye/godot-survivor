extends Node2D


@export var player_reference : CharacterBody2D
@export var enemy_reference : PackedScene
@export var enemy_types: Array[Enemy]

var distance : float = 400

var minute: int:
	set(value):
		minute = value
		%Minute.text = str(value)

var second: int:
	set(value):
		second = value
		if second >= 10:
			second -= 10
			minute += 1
		%Second.text = str(second).lpad(2, '0')

func spawn(pos: Vector2):
	var enemy_instance = self.enemy_reference.instantiate()
	enemy_instance.type = self.enemy_types[min(self.minute, self.enemy_types.size() - 1)] # 매 분마다 다른 적 웨이브가 발생하도록 처리
	enemy_instance.position = pos
	enemy_instance.player_reference = player_reference
	
	get_tree().current_scene.add_child(enemy_instance)
	
func get_random_position() -> Vector2:
	return self.player_reference.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number: int = 1):
	for i in range(number):
		self.spawn(self.get_random_position())

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_timer_timeout() -> void:
	self.second += 1
	self.amount(second % 10)

func _on_pattern_timeout() -> void:
	pass # Replace with function body.


func _on_elite_timeout() -> void:
	pass # Replace with function body.
