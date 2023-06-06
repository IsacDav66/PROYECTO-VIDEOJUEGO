extends Node2D


func _ready():
	Utils.saveGame()
	Utils.loadGame()
func _on_btn_quit_pressed():
	get_tree().quit()


func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://juego.tscn")
