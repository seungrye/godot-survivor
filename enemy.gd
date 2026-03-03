extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@export var player_reference: CharacterBody2D
var direction: Vector2
var damage: float
var knockback : Vector2

var elite: bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://shaders/rainbow.tres")
			self.scale = Vector2(1.5, 1.5)
			#self.scale = Vector2(2.5, 2.5)
		#else:
			#self.scale = Vector2(2, 2)

var type: Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage

func _physics_process(delta: float) -> void:
	# Note. 주인공과 거리가 일정 이상 멀어지면(화면 밖), 삭제 처리
	var separation = (player_reference.position - position).length()
	if separation >= 1000 and not elite:
		queue_free()
		
	# Note. normalized 를 하는 이유는 대각선으로 이동시 더 빠르게 이동되는 현상을 방지하기 위함
	self.velocity = (player_reference.position - self.position).normalized() * SPEED

	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback

	# Note. 움직일때 다른 몹과 충돌(collide) 가 발생할 경우, knockback 을 적용함.
	var collider:KinematicCollision2D = self.move_and_collide(self.velocity * delta)
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 70
		

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
