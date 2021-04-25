extends Node

export (PackedScene) var mob_scene

var score: int = 0

onready var mob_spawn_location: PathFollow2D = $MobPath/MobSpawnLocation
onready var score_timer: Timer = $ScoreTimer
onready var start_timer: Timer = $StartTimer
onready var mob_timer: Timer = $MobTimer
onready var hud: Hud = $HUD
onready var player: Player = $Player
onready var start_position: Position2D = $StartPosition
onready var audio_music: AudioStreamPlayer = $Music
onready var audio_death: AudioStreamPlayer = $DeathSound

func _ready() -> void:
	randomize()

func new_game():
	score = 0
	hud.update_score(score)
	
	get_tree().call_group("mobs", "queue_free")
	
	player.start(start_position.position)
	
	hud.show_message("Get ready ...")
	
	start_timer.start()
	audio_music.play()
	
	yield(start_timer, "timeout")
	
	score_timer.start()
	mob_timer.start()
	
func game_over():
	score_timer.stop()
	mob_timer.stop()
	hud.show_game_over()
	audio_music.stop()
	audio_death.play()

func _on_MobTimer_timeout() -> void:
	mob_spawn_location.unit_offset = randf()
	
	var mob = mob_scene.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction: float = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI/4, PI / 4)
	
	mob.rotation = direction
	
	var velocity: Vector2 = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_ScoreTimer_timeout() -> void:
	score += 1
	hud.update_score(score)
