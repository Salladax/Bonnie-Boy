extends Node

#Nó global responsável por alterar a cena e fazer transições

#Nodes do SceneChanger
onready var anim : AnimationPlayer = $AnimationPlayer
onready var tween : Tween = $Tween

#variáveis necessárias ao trocar de cena
var scene : PackedScene
var player_start_pos := Vector2(64, 200)
var player_start_dir : String = "right"

var first_level : String

	
func change_scene_to(scene : String, player_pos : Vector2, exit_dir : String, dir : String):
	self.scene = load(scene)
	self.player_start_pos = player_pos
	self.player_start_dir = dir
			
	exit_room(exit_dir)

func exit_room(exit_dir : String):	# ao trocar de sala
	if Globals.player != null:
		Globals.player.set_active(false)	
		
		var p = Globals.player	# apenas para encurtar o nome
		var vec = Globals.string_to_vector2(exit_dir)
		p.animSprite.play("walk_" + exit_dir)
		tween.interpolate_property(p, "position", \
		p.position, p.position + vec * 10, \
		0.7)
	anim.play("fade out")


func enter_room():	# após trocar de sala
	# o player deve permanecer inativo enquanto durar a animação de entrar na sala
	anim.play("fade in")


func _on_animation_finished(anim_name):
	if anim_name == "fade out":
		get_tree().change_scene_to(scene)
	if anim_name == "fade in":
		if Globals.player != null:
			Globals.player.set_active(true)
	if anim_name == "end":
		pass

