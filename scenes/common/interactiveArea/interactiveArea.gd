tool
extends Area2D
class_name InteractiveArea

## representa uma area interativa. 
## Ao entrar nessa area, ela será adicionada a variavel interactive_areas 
## do player, e ele terá a oportunidade de interagir.

export(Vector2) var size := Vector2(8, 8)	# altera o extents do collisionShape

var interaction : FuncRef

func _ready():
	# um novo Rectangle2D é criado evitando 
	# alterar o mesmo recurso no editor
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.extents = size
	if not Engine.editor_hint:
		interaction = null
		set_interaction()

func set_interaction():
	assert(get_parent().has_method("_interaction"), \
	"_interaction não definido em [%s]"  % get_parent().name)
	interaction = funcref(get_parent(), "_interaction")

func _on_body_entered(body):
	if body is Player:
		body.interactive_areas.append(self)

func _on_body_exited(body):
	if body is Player:
		body.interactive_areas.erase(self)
		
		
################### TOOL MODE ################
func _physics_process(delta):
	if Engine.editor_hint:
		$CollisionShape2D.shape.extents = size	
		
# Interface:
#
# Dono do InteractiveArea-> interaction()	| função onde deve estar a interação do nó
#											|
# Player-> interact(area) 					| esta função não deve ser modificada, é o único modo de interagir
# Player-> interaction_check() 				| função que deve chamar interact
