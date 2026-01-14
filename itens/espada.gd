extends Item
class_name Espada

@onready var cabo: Sprite2D = $Cabo
@onready var lamina: Sprite2D = $Lamina

@export var tamanho_cabo:String
@export var tamanho_lamina:String

#func _ready() -> void:
	#if (tamanho_cabo != "vazio" and tamanho_lamina != "vazio"):
		#var image1:Image = cabo.texture.get_image()
		#var image2:Image = lamina.texture.get_image()
		#image2.blend_rect(image1,image2.get_used_rect(),Vector2i.ZERO)
		#var texture = ImageTexture.create_from_image(image2)
		#sprite = texture
		#print_debug(sprite)
		#sprite_2d.texture = sprite
	#super()

func _collect():
	if tamanho_cabo == "vazio" or tamanho_lamina == "vazio":
		print_debug("A espada está sem cabo ou lâmina")
		return
	var slot:int
	if GerenciadorItens.inventario[0] == null:
		if GerenciadorItens.inventario[0] == null:
			if item_name == "espada":
				GerenciadorItens.Item_coletado.emit(0,self.duplicate())
				print_debug(item_name+" coletado no slot 0")
				queue_free()
			else:
				item_name = "espada"
				GerenciadorItens.Item_coletado.emit(0,self.duplicate())
				print_debug(item_name+" coletado no slot 0")
				libera_espada()
			return
	else:
		print_debug("inventario cheio")
	if GerenciadorItens.inventario[2] != null:
		if GerenciadorItens.inventario[2].item_name == "mao de mao" and GerenciadorItens.inventario[1]==null:
			if item_name == "espada":
				GerenciadorItens.Item_coletado.emit(0,self.duplicate())
				print_debug(item_name+" coletado no slot 0")
				queue_free()
			else:
				item_name = "espada"
				GerenciadorItens.Item_coletado.emit(0,self.duplicate())
				print_debug(item_name+" coletado no slot 0")
				libera_espada()
			return
	else:
		print_debug("mão secundaria indisponivel")
		
func libera_espada():
	item_name = "molde espada"
	tamanho_cabo = "vazio"
	cabo.texture = null
	tamanho_lamina = "vazio"
	lamina.texture = null
