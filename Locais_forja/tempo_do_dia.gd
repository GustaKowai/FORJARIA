extends Control
var tempo_do_dia:int
var pedaco_tempo:float
@export var valor_tempo:float = 5 #quantos segundos demora para passar 10 minutos no jogo
var time_elapsed_string:String
@onready var time_elapsed: Label = $time_elapsed
@onready var clock: TextureProgressBar = $clock

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pedaco_tempo += delta
	if pedaco_tempo >= valor_tempo:
		pedaco_tempo = 0
		tempo_do_dia += 10
		var minutes_elapsed = tempo_do_dia
		var hours = floori(minutes_elapsed/60.0)+6
		var minutes = minutes_elapsed % 60
		time_elapsed_string = "%02d:%02d" % [hours,minutes]
		time_elapsed.text = time_elapsed_string
		clock.value = minutes_elapsed
