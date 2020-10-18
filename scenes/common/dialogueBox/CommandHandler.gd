extends Node2D
class_name CommandHandler

#TODO:
# tudo ainda. Um interpretador de comandos de texto



# float regex: \d+(?:\.\d+)?
var regex : RegEx


func _ready():
	regex = RegEx.new()
	regex.compile("(?<!\\\\)\\<(?<param>speed)=(?<value>\\d+(?:\\.\\d+)?)\\>")
	print(regex.get_pattern())
	

func execute(command : Dictionary):
	pass
	#match command.
