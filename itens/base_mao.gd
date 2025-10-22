extends Item
class_name base_mao

func _collect():
	if GerenciadorItens.inventario[2] == null:
		GerenciadorItens.Item_coletado.emit(2,self)
		print_debug(item_name+" coletado")
		print_debug(GerenciadorItens.inventario)
		queue_free()
	else:
		print_debug("mao ocupada")
