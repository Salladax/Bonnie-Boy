extends Node2D

func _ready():
	Globals.level = self
	SceneChanger.enter_room()
