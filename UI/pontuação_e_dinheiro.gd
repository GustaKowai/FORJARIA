extends Control
@onready var ouro_label: Label = $VBoxContainer/ouro/ouro_label
@onready var fama_label: Label = $VBoxContainer/fama/fama_label

func _ready() -> void:
	GameManager.muda_ouro.connect(muda_ouro)
	GameManager.muda_fama.connect(muda_fama)
	
func muda_ouro():
	ouro_label.text = str(GameManager.ouro)

func muda_fama():
	fama_label.text = str(GameManager.fama)
