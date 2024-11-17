extends Node

@onready var animation_player = $CanvasLayer/Control/AnimationPlayer
@onready var fade_out_rect = $CanvasLayer/Control/FadeOut

@export var inventory : Control

var player_texture = null

var in_menu = true


func fade_in():
	if fade_out_rect.visible:
		animation_player.play_backwards("fade_out")
	else:
		animation_player.play("fade_in")


func fade_out():
	fade_out_rect.visible = true
	animation_player.play("fade_out")
