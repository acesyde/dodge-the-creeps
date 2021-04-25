extends RigidBody2D

export(float) var min_speed: float = 150.0
export(float) var max_speed: float = 250.0

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

func _ready() -> void:
	randomize()
	animated_sprite.playing = true
	var mob_types: PoolStringArray = animated_sprite.frames.get_animation_names()
	animated_sprite.animation = mob_types[randi() % mob_types.size()]

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
