extends Button


func _pressed():
	print("hi")
	get_tree().change_scene_to_file("res://node_2d.tscn")
