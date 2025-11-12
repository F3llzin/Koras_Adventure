extends Control
@onready var drika = $drika
@onready var natally = $natally
@onready var estevao = $estevao
@onready var fellipe = $fellipe
@onready var radielen = $radielen
@onready var endrik = $endrik

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Telainicio.tscn")


func _on_prosseguir_pressed():
		#Simula pressionar "ui_accept
	var ev = InputEventAction.new()
	ev.action = &"ui_accept"
	ev.pressed = true
	Input.parse_input_event(ev)
	#Simula toque rápido
	await get_tree().process_frame
	ev = InputEventAction.new()
	ev.action = &"ui_accept"
	ev.pressed = false
	Input.parse_input_event(ev)

