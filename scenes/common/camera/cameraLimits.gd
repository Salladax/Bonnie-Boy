tool
extends Node2D

## nó que guarda limites de câmera para serem utilizados
## ao entrar em uma área.
## É Node2D e tool para poder desenhar no editor,
## mas poderia ser um simples Node


export(int) var left := 0
export(int) var top := 0
export(int) var right := 320
export(int) var bottom := 240

export(NodePath) var TriggerArea : NodePath

func _ready():
	if not Engine.editor_hint:
		var trigger_area = get_node(TriggerArea)
		if trigger_area is Area2D:
			trigger_area.connect("body_entered", self, "_on_body_entered")
		else:
			print("[%s]: Trigger Area não encontrado ou não é Area2D" \
			% self.name)
			
func _on_body_entered(body):
	if body is Player:
		Globals.camera.set_limits(left, top, right, bottom)
		
##################### DEBUG: MOSTRAR NO EDITOR #################################

var last_left := left
var last_top := top
var last_right := right
var last_bottom := bottom
var warned := false
var draw_limit_warning := false

export(bool) var DrawInEditor := true
export(Color) var DebugColor := Color("FD8803")
export(float) var DebugLength := 1.5


func _process(delta):
	if Engine.editor_hint:
		update()

func _draw():
	if Engine.editor_hint and DrawInEditor:
		if (left > right or top > bottom):
			if not warned:
				print("[%s]: verificar bordas invertidas")
				warned = true
		else:
			warned = false
		"""
		if right - left < 320 or bottom - top < 240:
			if right != last_right:
				last_left = left
			else:
				last_right = right
			if left != last_left:
				last_right
			if bottom != last_bottom:
				last_top = top
			else:
				last_bottom = bottom
			draw_limit_warning = true
		else:							# setar padrão
			last_left = left
			last_top = top
			last_right = right
			last_bottom = bottom
			draw_limit_warning = false
		
		if (draw_limit_warning):
			var top_left = Vector2(last_left, last_top)
			var bottom_right = Vector2(last_right, last_bottom)
			var rect := Rect2(top_left, bottom_right - top_left)
			draw_rect(rect, DebugColor.darkened(0.7), false, DebugLength * 0.8)
		"""
		var top_left = Vector2(left, top)
		var bottom_right = Vector2(right, bottom)
		var rect := Rect2(top_left, bottom_right - top_left)
		draw_rect(rect, DebugColor, false, DebugLength)
################################################################################

