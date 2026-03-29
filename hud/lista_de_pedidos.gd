extends Control
var numero_cliente:int = 0
@onready var v_box_container: VBoxContainer = $VBoxContainer

@export var pedido:PackedScene

func _ready() -> void:
	GameManager.chama_cliente.connect(chama_cliente)
	GameManager.pedido_entrou_saiu.connect(pedido_pedido_entrou_saiu)
	position.x = -1000
func chama_cliente():
	if numero_cliente < 5:
		var pedido_scene = pedido.instantiate()
		v_box_container.add_child(pedido_scene)
		numero_cliente += 1
	else:
		print_debug("Lista cheia")
		


func pedido_pedido_entrou_saiu(cliente) -> void:
	numero_cliente += cliente
