extends Node

# esse nó terá um colisor responsável por trocar de sala
# para isso algumas informações são guardadas

export(String) var change_to : String			# a nova sala
export(NodePath) var trigger_area : NodePath	# colisor
export(Vector2) var player_position : Vector2	# posição do player ao aparecer na nova sala (local ao level/sala)
export(String) var exit_direction : String		# direção do player deve sair da sala (animação)
export(String) var direction : String			# direção do player ao aparecer na nova sala (animação)

func _ready():
	var trigger = get_node(trigger_area)
	if trigger is Area2D:
		trigger.connect("body_entered", self, "_on_body_entered")
	else:
		print("[%s]: Trigger Area não encontrado ou não é Area2D" \
		% self.name)
		
func _on_body_entered(body):
	if body is Player:
		SceneChanger.change_scene_to(change_to, \
		player_position, exit_direction, direction)
		
