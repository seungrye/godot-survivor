extends CharacterBody2D

@export var draw_radius: bool = false # 주인공 주위 영역을 출력
@export var radius: float = 100.0  # 원의 반지름
@export var color: Color = Color.CYAN  # 원의 색상
@export var line_width: float = 2.0  # 선의 굵기

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var health: float = 100:
	set(value):
		health = value
		%Health.value = value

var nearest_enemy: CharacterBody2D
var nearest_enemy_distance: float = INF

var xp: int = 0:
	set(value):
		xp = value
		%"XP-TextureProgressBar".value = value
		
var total_xp: int = 0
var level: int = 1:
	set(value):
		level = value
		%"Level-Label".text = 'Lv ' + str(value)
		
		if level >= 3:
			%"XP-TextureProgressBar".max_value = 20
		elif level >= 7:
			%"XP-TextureProgressBar".max_value = 40

func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy): # store when the instance is valid
		nearest_enemy_distance = nearest_enemy.separation
		#print(nearest_enemy.name)
	else:
		nearest_enemy_distance = INF
		
	self.velocity = Input.get_vector("left", "right", "up", "down") * SPEED
	self.move_and_collide(velocity * delta)
	self.check_xp()

#func _ready() -> void:
	#self.scale = Vector2(2, 2)

func _draw():
	# 채워진 원을 그릴 때
	# draw_circle(Vector2.ZERO, radius, Color(color.r, color.g, color.b, 0.3))
	
	# 테두리만 그릴 때 (더 효과적)
	if draw_radius:
		draw_arc(Vector2.ZERO, radius, 0, TAU, 64, color, line_width, true)

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

func take_damage(amount):
	self.health -= amount
	#print(amount)

func _on_self_damage_body_entered(body: Node2D) -> void:
	self.take_damage(body.damage)


func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)

func gain_xp(amount):
	self.xp += amount
	self.total_xp += amount

func check_xp():
	if self.xp > %"XP-TextureProgressBar".max_value:
		self.xp -= %"XP-TextureProgressBar".max_value
		level += 1


func _on_magnet_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method('follow'):
		area.follow(self)
