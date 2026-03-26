extends Item
class_name Espada

@onready var cabo: Sprite2D = %Cabo
@onready var lamina: Sprite2D = %Lamina

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
	sprite_2d = $Area2D/Sprite2D
	if tamanho_cabo == "vazio" or tamanho_lamina == "vazio":
		print_debug("A espada está sem cabo ou lâmina")
		return
	var slot:int
	if GerenciadorItens.inventario[0] == null:
		if GerenciadorItens.inventario[0] == null:
			if item_name == "espada":
				GerenciadorItens.Item_coletado.emit(0,self.duplicate())
				print_debug(item_name+" coletado no slot 0")
				coletado = true
				queue_free()
			else:
				item_name = "espada"
				GerenciadorItens.Item_coletado.emit(0,self.duplicate())
				print_debug(item_name+" coletado no slot 0")
				coletado = true
				libera_espada()
			return
	else:
		print_debug("inventario cheio")
	if GerenciadorItens.inventario[2] != null:
		if GerenciadorItens.inventario[2].item_name == "mao de mao" and GerenciadorItens.inventario[1]==null and !coletado:
			if item_name == "espada":
				GerenciadorItens.Item_coletado.emit(1,self.duplicate())
				print_debug(item_name+" coletado no slot 1")
				queue_free()
			else:
				item_name = "espada"
				GerenciadorItens.Item_coletado.emit(1,self.duplicate())
				print_debug(item_name+" coletado no slot 1")
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
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		#modulate = Color(1.5,1.5,1.5)
		if item_name == "espada":
			seta_item.visible = true
		print_debug("Da pra pegar")
		#_collect()
		pass
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		#modulate = Color(1,1,1)
		seta_item.visible = false
		print_debug("Saiu do range")
	pass # Replace with function body.
