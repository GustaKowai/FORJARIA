extends Item
class_name Espada

@onready var cabo: Sprite2D = $Cabo
@onready var lamina: Sprite2D = $Lamina

@export var tamanho_cabo:String
@export var tamanho_lamina:String

func _collect():
	if tamanho_cabo == "vazio" or tamanho_lamina == "vazio":
		print_debug("A espada está sem cabo ou lâmina")
		return
	var slot:int
	if GerenciadorItens.inventario[0] == null:
		if GerenciadorItens.inventario[0] == null:
			GerenciadorItens.Item_coletado.emit(0,self.duplicate())
			print_debug(item_name+" coletado no slot 0")
			libera_espada()
			return
	else:
		print_debug("inventario cheio")
	if GerenciadorItens.inventario[2] != null:
		if GerenciadorItens.inventario[2].item_name == "mao de mao" and GerenciadorItens.inventario[1]==null:
			GerenciadorItens.Item_coletado.emit(1,self.duplicate())
			print_debug(item_name+" coletado no slot 1")
			libera_espada()
			return
	else:
		print_debug("mão secundaria indisponivel")
		
func libera_espada():
	tamanho_cabo = "vazio"
	cabo.texture = null
	tamanho_lamina = "vazio"
	lamina.texture = null
