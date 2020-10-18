extends Panel

class_name Inventory

## os estilos que serão utilizados para os slots de inventário
## quando selecionado ou não
onready var style_selected := \
preload("res://scenes/system/inventory/styles/selected.tres")
onready var style_not_selected := \
preload("res://scenes/system/inventory/styles/not_selected.tres")

onready var anim : AnimationPlayer = $"../anim"

var inventory : Array = []
var selected_index := 0		# índice do item selecionado
var opened := false




############################## VIRTUAL ##################################
func _ready():
	init_inventory()
	
	######### TESTE ################
	add_item({
		"name": "graveto"
	})
	add_item({
		"name": "X"
	})
	add_item({
		"name": "Y"
	})
	#################################
	
func _input(event):
	##TODO: condição caso o inventário deva ser bloqueado.
	if event is InputEventKey:
		if event.is_action_pressed("menu"):
			if not opened:
				open()
			else:
				close()
			opened = not opened
		elif opened:
			if event.pressed:
				match event.scancode:
					KEY_DOWN:
						selected_index += 1
					KEY_UP:
						selected_index -= 1
					KEY_LEFT:
						selected_index -= 5
					KEY_RIGHT:
						selected_index += 5
				selected_index = wrapi(selected_index, 0, count())
		render_inventory()
############################# PRINCIPAL ################################
func init_inventory():
	set_visible(false)
	for index in get_child_count():
		inventory.append(Item.empty_item)
	
	render_slots()


func render_inventory():
	clear_slots()
	render_slots()

############################# ABRIR ################################
func open():
	get_tree().paused = true
	Audio.play_audio(Audio.inventory)
	set_visible(true)

func close():
	set_visible(false)
	Audio.play_audio(Audio.inventory)
	get_tree().paused = false
	
############################# RENDERIZAÇÃO #############################
func clear_slots():
	for index in get_child_count():
		clear_slot(get_child(index))


func clear_slot(slot):
	slot.get_node("Label").text = ""


func render_slots():
	# os filhos são os slots
	var slot_index := 0
	for item_index in inventory.size():
		if inventory[item_index] == Item.empty_item:
			continue
		render_slot(get_child(slot_index), inventory[item_index])
		slot_index += 1


func render_slot(slot, item):
	slot.get_node("Label").text = item.name
	if slot.get_index() == selected_index:
		slot.set("custom_styles/panel", style_selected)
	else:
		slot.set("custom_styles/panel", style_not_selected)


############################# MANIPULAÇÃO #############################
func count() -> int:
	var n := 0
	for index in inventory.size():
		if inventory[index] != Item.empty_item:
			n += 1
	return n

func add_item(item) -> bool:
	for index in inventory.size():
		if inventory[index] == Item.empty_item:
			inventory[index] = item
			return true
	return false

	
func remove_item(index) -> void:
	if index < inventory.size():
		inventory[index] = Item.empty_item



func has_item(name) -> bool:
	for index in inventory.size():
		if inventory[index].name == name:
			return true
	return false
	

func get_item_index(name) -> int:
	for index in inventory.size():
		if inventory[index].name == name:
			return index
	return -1


######################## MENU #####################################

# implementar:
# 	abrir e fechar inventário
# 	selecionar itens
#	item -> descrição
#	
