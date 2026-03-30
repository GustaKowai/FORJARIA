extends Control

@onready var ouro_n: Label = %ouro_n
@onready var fama_n: Label = %fama_n
@onready var acertos_n: Label = %acertos_n
@onready var erros_n: Label = %erros_n
@onready var perdidos_n: Label = %perdidos_n



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.fim_do_dia.connect(fim_do_dia)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	GameManager.comeco_do_dia.emit()
	GameManager.pedidos_corretos = 0
	GameManager.pedidos_errados = 0
	GameManager.pedidos_incompletos = 0
	hide()

func fim_do_dia():
	ouro_n.text = str(GameManager.ouro)
	fama_n.text = str(GameManager.fama)
	acertos_n.text = str(GameManager.pedidos_corretos)
	erros_n.text = str(GameManager.pedidos_errados)
	perdidos_n.text = str(GameManager.pedidos_incompletos)
	show()
