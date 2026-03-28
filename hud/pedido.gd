extends MarginContainer

@onready var texto_do_pedido: Label = $"PanelContainer/CenterContainer/Texto do pedido"
var lamina_tamanho
var cabo_tamanho
func _ready() -> void:
	var lamina = randi_range(1,3)
	var cabo = randi_range(1,3)
	lamina_tamanho = resultado_sorteio(lamina)
	cabo_tamanho = resultado_sorteio(cabo)
	
	texto_do_pedido.text = "Eu quero uma lamina de tamanho "+lamina_tamanho+" e um cabo "+cabo_tamanho
	
func resultado_sorteio(sorteio):
	var resultado
	match sorteio:
		1:
			resultado = "pequeno"
		2:
			resultado = "medio"
		3:
			resultado = "grande"
			
	return resultado


func _on_panel_container_mouse_entered() -> void:
	modulate = Color(2.0,1.1,1.1)


func _on_panel_container_mouse_exited() -> void:
	modulate = Color(1.0,1.0,1.0)


func _on_panel_container_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.
