extends Item
class_name base_mao

func _collect():
	if GerenciadorItens.inventario[2] == null:
		GerenciadorItens.Item_coletado.emit(2,self.duplicate())
		print_debug(item_name+" coletado")
		print_debug(GerenciadorItens.inventario)
		GameManager.mao_animacao.emit(item_name)
		queue_free()
	else:
		print_debug("mao ocupada")

func termina_dia():
	pass
