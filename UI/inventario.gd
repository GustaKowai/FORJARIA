extends CanvasLayer
@export var item_coletado_scene:PackedScene
@onready var item_1: TextureButton = %item1
@onready var item_2: TextureButton = %item2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GerenciadorItens.Item_coletado.connect(AdicionaItem)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func AdicionaItem(slot:int,item:DadosItens):
	print_debug(slot,item)
	var item_coletado:DadosItens = item_coletado_scene.instantiate()
	item_coletado.item_name = item.item_name
	item_coletado.qualidade = item.qualidade
	item_coletado.sprite = item.sprite
	GerenciadorItens.inventario[slot] = item_coletado
	if slot == 0:
		item_1.texture_normal = item_coletado.sprite
	if slot == 1:
		item_2.texture_normal = item_coletado.sprite
