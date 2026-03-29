extends Control
var tempo_do_dia:int
var pedaco_tempo:float
@export var valor_tempo:float = 5 #quantos segundos demora para passar 10 minutos no jogo
var time_elapsed_string:String
@onready var time_elapsed: Label = $time_elapsed
@onready var clock: TextureProgressBar = $clock
var hours_back = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.comeco_do_dia.connect(comecar_novo_dia)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if clock.value == clock.max_value:
			GameManager.fim_do_dia.emit()
			return
	pedaco_tempo += delta
	if pedaco_tempo >= valor_tempo:
		pedaco_tempo = 0
		tempo_do_dia += 10
		var minutes_elapsed = tempo_do_dia
		var hours = floori(minutes_elapsed/60.0)+6
		if hours > hours_back and hours < 15:
			hours_back = hours
			GameManager.chama_cliente.emit()
		var minutes = minutes_elapsed % 60
		time_elapsed_string = "%02d:%02d" % [hours,minutes]
		time_elapsed.text = time_elapsed_string
		clock.value = minutes_elapsed

func comecar_novo_dia():
	tempo_do_dia = 0
	clock.value = 0
	hours_back = 0
