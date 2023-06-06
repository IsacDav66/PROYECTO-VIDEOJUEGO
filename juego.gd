extends Node2D


func _on_button_pressed():
	print("Hola mundo")
	get_tree().change_scene_to_file("res://Main.tscn")
