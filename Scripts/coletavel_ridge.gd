extends RigidBody2D

func _on_cherry_tree_exited():
	queue_free()
