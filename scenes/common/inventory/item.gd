class_name Item

const item_template = {
	"name" : "name",
	"icon_name": "icon_name",
	"type" : 0,
}

const empty_item = {
	"name" : "empty",
	"icon_name" : "empty",
	"type" : 0
	
}

enum type {
	EMPTY,
	CONSUMABLE,
	KEY
}

func _init(name, icon_name, type=type.CONSUMABLE):
	return {
		"name" : name,
		"icon_name": icon_name,
		"type" : type,
	}


