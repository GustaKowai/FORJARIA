extends Node2D
class_name Item

#@onready var dados_item: DadosItens = $dados_item
@onready var area_2d: Area2D = $Area2D
@export var sprite:Texture2D
@export var item_name: String# = "Item_Base"
@export var qualidade: float# = 50.0 
@onready var sprite_2d: Sprite2D = $Area2D/Sprite2D
var _self_scene:PackedScene

func _ready() -> void:
	#print_debug(sprite)
	#item_name = dados_item.item_name
	#qualidade = dados_item.qualidade
	_self_scene = PackedScene.new()
	_self_scene.pack(self)
	sprite = sprite_2d.texture
	pass
	
func _collect():
	if GerenciadorItens.inventario[0] == null or GerenciadorItens.inventario[1] == null:
		var slot:int
		if GerenciadorItens.inventario[0] == null:
			slot = 0
		elif GerenciadorItens.inventario[2] != null:
			if GerenciadorItens.inventario[2].item_name == "mao de mao":
				slot = 1
		GerenciadorItens.Item_coletado.emit(slot,self.duplicate())
		print_debug(item_name+" coletado")
		print_debug(GerenciadorItens.inventario)
		print_debug(typeof(GerenciadorItens.inventario[0]))
		queue_free()
	else:
		print_debug("inventario cheio")
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		#_collect()
		pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var ta_em_cima = area_2d.get_overlapping_bodies()
		#print_debug(ta_em_cima)
		for ferreiro in ta_em_cima:
			#print_debug(ferreiro.is_in_group("jogador"))
			if ferreiro.is_in_group("jogador"):
				_collect()
