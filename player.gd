extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var health: float = 100:
	set(value):
		health = value
		%Health.value = value

func _physics_process(delta: float) -> void:
	self.velocity = Input.get_vector("left", "right", "up", "down") * SPEED
	self.move_and_collide(velocity * delta)

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
	print(amount)

func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)
