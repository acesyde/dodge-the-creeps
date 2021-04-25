extends Area2D

class_name Player

signal hit

export(float) var speed: float = 400.0

var screen_size: Vector2 = Vector2.ZERO

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()

func _process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		animated_sprite.play()
	else:
		animated_sprite.stop()
	
	position += direction * speed * delta
	
	position.x = clamp(position.x, 0 , screen_size.x)
	position.y = clamp(position.y, 0 , screen_size.y)
	
	if direction.x != 0:
		animated_sprite.animation = "right"
		animated_sprite.flip_h = direction.x < 0
		animated_sprite.flip_v = false
	elif direction.y != 0:
		animated_sprite.animation = "up"
		animated_sprite.flip_v = direction.y > 0

func start(new_position):
	position = new_position
	show()
	collision_shape.set_deferred("disabled", false)

func _on_Player_body_entered(body: Node) -> void:
	hide()
	collision_shape.set_deferred("disabled", true)
	emit_signal("hit")
