extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@export var player_reference: CharacterBody2D
var damage_popup_node = preload("res://damage.tscn")
var direction: Vector2
var damage: float
var knockback : Vector2
var separation: float

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
	self.check_separation(delta)
	self.knockback_update(delta)

func check_separation(_delta):
	# Note. 주인공과 거리가 일정 이상 멀어지면(화면 밖), 삭제 처리
	separation = (player_reference.position - self.position).length()
	if separation >= 1000 and not elite:
		queue_free()

	# 주인공이 알고있는 (가장 가까운)적과의 거리보다 현재 적(self) 가 더 가깝다면
	# 가장 가까운 적(참조)을 갱신
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self

func knockback_update(delta):
	# Note. normalized 를 하는 이유는 대각선으로 이동시 더 빠르게 이동되는 현상을 방지하기 위함
	self.velocity = (player_reference.position - self.position).normalized() * SPEED

	# 만약 내가 knockback 을 받은 상태라면, knockback 을 서서히(1씩) 줄임.
	self.knockback = self.knockback.move_toward(Vector2.ZERO, 1)
	# 넉백이 있다면 속도에 반영
	self.velocity += self.knockback

	# Note. 움직일때 다른 몹과 충돌(collide) 가 발생할 경우, 상대방에게 knockback 을 적용함.
	var collider:KinematicCollision2D = self.move_and_collide(self.velocity * delta)
	if collider:
		# 내가 부딪힌 상대방을 내 반대 방향으로 밀어냄
		var target = collider.get_collider()
		target.knockback = (target.global_position - self.global_position).normalized() * 70

func damage_popup(amount):
	var popup = damage_popup_node.instantiate()
	popup.text = str(amount)
	popup.position = position + Vector2(-50, -25) # why -50, -25??
	self.get_tree().current_scene.add_child(popup)
	
func take_damage(amount):
	self.damage_popup(amount)
	
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
