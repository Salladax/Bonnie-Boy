extends Camera2D

func _ready():
	Globals.camera = self
	current = true

func set_limits(left : int, top : int, right : int, bottom : int):
	limit_left = left
	limit_top = top
	limit_right = right
	limit_bottom = bottom
