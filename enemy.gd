extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@export var player_reference: CharacterBody2D
var direction: Vector2
var damage: float

var type: Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage

func _physics_process(delta: float) -> void:
	# Note. normalized 를 하는 이유는 대각선으로 이동시 더 빠르게 이동되는 현상을 방지하기 위함
	self.velocity = (player_reference.position - self.position).normalized() * SPEED
	self.move_and_collide(self.velocity * delta)

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
