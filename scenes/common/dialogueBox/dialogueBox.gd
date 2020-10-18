extends RichTextLabel

onready var panel = $"../"

var default : Dictionary = {
	"text": "",
	"speed": 32,
	"chars": 0,
	"advance": true,
	"next": ""
	#(passar ou não) : (esperar input)
}

var dialogue : Dictionary
var speed : float = 1.0
var next : String = ""
#var pause : float = 0.0
#var commands : Array

var accumulated_speed : float = 0.0
var advance_multiplier : float = 2.5


func _ready():
	panel.set_visible(false)
	set_physics_process(false)
	
	####TESTE
	load_dialogue({
		"page": "000",
		"000": {
			"text" : """Por que você é assim? O que te trás aqui?\nPor que faz o que faz?""",
			"speed" : 10
		}
	})
	start()
	######

func _physics_process(delta):
	update_dialogue(delta)


func update_dialogue(delta):
	if visible_characters < text.length() and visible_characters != -1: 
		#if pause > 0:
			#pause -= delta
		#else:
		
		# adiantar o texto
		if Input.is_action_pressed("cancel"):
			accumulated_speed += speed * advance_multiplier * delta
		else:
			accumulated_speed += speed * delta
		# escrever o texto
		if accumulated_speed > 1.0:
			visible_characters += 1
			accumulated_speed -= 1.0
	else:
		# receber input para trocar de pagina
		if Input.is_action_just_released("interact") \
		and not Input.is_action_pressed("cancel"):
			if next != "":
				next_page()
			else:
				end()

	
func load_dialogue(dialogue : Dictionary):
	self.dialogue = dialogue

func load_page(page : Dictionary):
	speed = page.speed if page.has("speed") else default.speed
	visible_characters = page.chars if page.has("chars") else default.chars
	next = page.next if page.has("next") else default.next
	bbcode_text = page.text

func next_page():
	set_physics_process(false)
	load_page(dialogue[next])
	set_physics_process(true)


func start():
	open()
	load_page(dialogue[dialogue.page])
	set_physics_process(true)
	
func end():
	set_physics_process(false)
	close()

func open():
	Globals.player.paused = true
	panel.set_visible(true)
	
func close():
	panel.set_visible(false)



