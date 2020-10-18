extends Node

var level : Node
var camera : Camera2D
var player = null


# utilidades
func get_last_child(node : Node) -> Node:
	return node.get_child(node.get_child_count() - 1)

func string_to_vector2(dir : String) -> Vector2:
	match dir:
		"up":
			return Vector2.UP
		"down":
			return Vector2.DOWN
		"left":
			return Vector2.LEFT
		"right":
			return Vector2.RIGHT
		_:
			return Vector2.ZERO
