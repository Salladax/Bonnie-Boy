## não é um script, 
## mas apenas um guia de 
## como deve ser uma página de diálogo

var collection = {	#coleção de páginas
	page = "",		# pagina inicial
	"000" : {
		"text" : "String",
		"speed" : "float",
		"chars" : "int", #quantidade inicial de caracteres
		"advance": "bool", #pode ou não acelerar o texto
		
		"cmd0" : "comandos", # NAO USAR POR ENQUANTO
		
		"next" : ""	## "" indicará encerramento do dialogo
	}	
}

## parâmetro para 
## [passar ou não direto ao invés de esperar input]

#TODO:
### criar interpretador de comandos
### inserir comandos no text

## paramêtros:
##	speed
##	(passar ou nao)
##	cmd0

##	[por enquanto não, desnecessário]
##	char_id
##	portrait 	


## criar os dialogos e carrega-los, e separar idiomas									
