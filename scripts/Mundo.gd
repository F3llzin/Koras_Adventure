extends Node2D
@onready var jogador = $jogador
@onready var cena_jogador = preload("res://Scenes/jogador.tscn")
@onready var camera_2d = $Camera2D


func _ready():
	Global.jogador_posicao_inicial = $posicao_inicial
	Global.jogador = jogador
	Global.jogador.seguir_camera(camera_2d )
	Global.jogador.jogador_morreu.connect(recomecar)
	

func recomecar():
	await get_tree().create_timer(1.0).timeout
	var player = cena_jogador.instantiate()
	add_child(player)
	Global.jogador = player
	Global.jogador.seguir_camera(camera_2d )
	Global.jogador.jogador_morreu.connect(recomecar)
	Global.moeda = 0
	Global.vida_jogador = 3
	Global.respawn_player()
	#get_tree().reload_current_scene()

func game_over():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")


func _on_button_pressed():
	#Simula pressionar "ui_cancel
	var ev = InputEventAction.new()
	ev.action = &"ui_cancel"
	ev.pressed = true
	Input.parse_input_event(ev)
	#Simula toque rápido
	await get_tree().process_frame
	ev = InputEventAction.new()
	ev.action = &"ui_cancel"
	ev.pressed = false
	Input.parse_input_event(ev)



func _on_pause_bttn_pressed():
	#Simula pressionar "ui_cancel
	var ev = InputEventAction.new()
	ev.action = &"ui_cancel"
	ev.pressed = true
	Input.parse_input_event(ev)
	#Simula toque rápido
	await get_tree().process_frame
	ev = InputEventAction.new()
	ev.action = &"ui_cancel"
	ev.pressed = false
	Input.parse_input_event(ev)

