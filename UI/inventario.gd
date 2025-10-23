extends CanvasLayer
@export var item_coletado_scene:PackedScene
@onready var item_1: TextureButton = %item1
@onready var item_2: TextureButton = %item2
@onready var mao: TextureButton = %mao
@onready var inventory_1: ColorRect = %inventory1
@onready var slot_mao: ColorRect = %slot_mao
@onready var inventory_2: ColorRect = %inventory2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GerenciadorItens.Item_coletado.connect(AdicionaItem)
	GerenciadorItens.item_dropado.connect(RemoveItem)
	inventory_2.hide()
	GerenciadorItens.active_slot = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func AdicionaItem(slot:int,item:Item):
	print_debug(slot,item)
	var item_coletado:Item = item#.instantiate()
	if item.item_name == "mao de mao":
		inventory_2.show()
	item_coletado.item_name = item.item_name
	item_coletado.qualidade = item.qualidade
	item_coletado.sprite = item.sprite
	GerenciadorItens.inventario[slot] = item_coletado
	if slot == 0:
		item_1.texture_normal = item_coletado.sprite
	if slot == 1:
		item_2.texture_normal = item_coletado.sprite
	if slot == 2:
		mao.texture_normal = item_coletado.sprite

func RemoveItem(slot):
	if slot == 0:
		item_1.texture_normal = null
	if slot == 1:
		item_2.texture_normal = null
	if slot == 2:
		mao.texture_normal = null
		inventory_2.hide()

func _on_item_1_pressed() -> void:
	click_inventory(0)

func _on_item_2_pressed() -> void:
	click_inventory(1)

func _on_mao_pressed() -> void:
	click_inventory(2)

func click_inventory(slot:int):
	if GerenciadorItens.active_slot == slot and GerenciadorItens.inventario[slot] != null:
		drop_item(slot)
	else:
		GerenciadorItens.active_slot = slot
		match slot:
			0:
				inventory_1.modulate = Color.RED
				inventory_2.modulate = Color.WHITE
				slot_mao.modulate = Color.WHITE
			1:
				inventory_1.modulate = Color.WHITE
				inventory_2.modulate = Color.RED
				slot_mao.modulate = Color.WHITE
			2:
				inventory_1.modulate = Color.WHITE
				inventory_2.modulate = Color.WHITE
				slot_mao.modulate = Color.RED
		print_debug("clicado ",slot,inventory_1.modulate)

func drop_item(slot):
	#print_debug(slot, GerenciadorItens.inventario[2].item_name, GerenciadorItens.inventario[1])
	if slot == 2 and GerenciadorItens.inventario[2].item_name == "mao de mao" and GerenciadorItens.inventario[1] != null:
		print_debug("larguei a mao")
		GerenciadorItens.drop_item.emit(1)
	GerenciadorItens.drop_item.emit(slot)
	
