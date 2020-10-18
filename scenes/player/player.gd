extends KinematicBody2D

class_name Player

var movedir : Vector2
var speed : float

var facedir : String

var interact_pressed : bool
var run_pressed : bool

var interactive_areas : Array		# guarda as areas de interação que estão colidindo com o player

var animSprite : AnimatedSprite
var audio : AudioStreamPlayer

func _ready():
	#inicialização
	
	Globals.player = self
	
	movedir = Vector2.ZERO
	speed = 80.0
	
	position = SceneChanger.player_start_pos
	facedir = SceneChanger.player_start_dir
	
	interact_pressed = false
	run_pressed = false
	
	interactive_areas = []
	
	animSprite = $AnimatedSprite
	audio = $AudioStreamPlayer
	
	set_active(false)
	animSprite.play("idle_" + facedir)
	

func _physics_process(delta):
	input()
	movement()
	facing()
	animation()
	
	interaction_check()

func set_active(active : bool): # ativa ou bloqueia o controle e colisão do player
	if active:
		set_physics_process(true)
		set_collision_layer_bit(0, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)
	else:
		animSprite.stop()
		set_physics_process(false)
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
		set_collision_mask_bit(1, false)
	
func input():
	movedir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	movedir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	interact_pressed = Input.is_action_just_pressed("interact")
	run_pressed = Input.is_action_pressed("cancel")


func movement():
	if movedir != Vector2.ZERO:
		if not run_pressed:
			move_and_slide(movedir.normalized() * speed)
		else:
			move_and_slide(movedir.normalized() * speed * 2.0)
		if not audio.playing:
			audio.play()
	else:
		audio.stop()
	
func facing():	# define a direção em que o player está olhando
	# se o input é diagonal, 
	# a direção será a anterior.
	match movedir:
		Vector2.UP:
			facedir = "up"
		Vector2.RIGHT:
			facedir = "right"
		Vector2.DOWN:
			facedir = "down"
		Vector2.LEFT:
			facedir = "left"

func animation():
	if movedir == Vector2.ZERO:
		animSprite.play("idle_" + facedir)
	else:
		animSprite.play("walk_" + facedir)


### checa se houve alguma interação	
func interaction_check():
	if interact_pressed:
		for area in interactive_areas:
			#TODO: checar lado para o qual estar olhando
			# por agora o player pode interagir 
			# se estiver dentro da area,
			# mas olhando para o lado oposto por exemplo
			interact(area)
				
func interact(area):
	if area.interaction != null:
		# pegar direção
		area.interaction.call_func()

	


