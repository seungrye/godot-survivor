extends Label

func _ready() -> void:
	pop()
	
func pop():
	var tween = self.get_tree().create_tween()
	
	# tween the scale from 1 to 2, then 2 to 1 by chaining
	tween.tween_property(self, "scale", Vector2(2, 2), 0.1)
	tween.chain().tween_property(self, "scale", Vector2(1, 1), 0.1)
	
	await tween.finished
	queue_free()
