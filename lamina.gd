extends Item
@export var pontuacao:float
@export var tamanho:String
@export var sprites_tamanhos:Array[Texture2D]
@export var dicionario:Dictionary[String,int]
@export var sprites_tamanhos_moldes:Array[Texture2D]

func _ready() -> void:
	sprite_2d.texture = sprites_tamanhos[dicionario[tamanho]]
	print_debug("lamina pronta")
	super()
