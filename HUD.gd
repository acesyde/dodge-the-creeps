extends CanvasLayer

class_name Hud

signal start_game

onready var score_label: Label = $ScoreLabel
onready var message_label: Label = $MessageLabel
onready var start_button: Button = $StartButton
onready var message_timer: Timer = $MessageTimer

func update_score(score: int) -> void:
	score_label.text = str(score)
	
func show_message(text: String) -> void:
	message_label.text = text
	message_label.show()
	message_timer.start()

func show_game_over():
	show_message("Game Over")
	yield(message_timer, "timeout")
	message_label.text = "Dodge the Creeps"
	message_label.show()
	yield(get_tree().create_timer(1.0), "timeout")
	start_button.show()

func _on_StartButton_pressed() -> void:
	start_button.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout() -> void:
	message_label.hide()
