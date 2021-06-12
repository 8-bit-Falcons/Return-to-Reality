extends Node2D



func _on_Bossman_dying():
	print("he dead")
	get_tree().change_scene("res://scenes/cutscenes/End.tscn")
