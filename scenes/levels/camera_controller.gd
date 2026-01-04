extends Node

@export var player: CharacterBody2D
@export var pcam: PhantomCamera2D

@export var look_ahead_distance := 64.0
@export var look_ahead_smooth := 6.0
@export var velocity_threshold := 10.0

var current_offset := Vector2.ZERO

func _process(delta):
	if not player or not pcam:
		return

	var target_offset := Vector2.ZERO

	if abs(player.velocity.x) > velocity_threshold:
		target_offset.x = sign(player.velocity.x) * look_ahead_distance

	current_offset = current_offset.lerp(
		target_offset,
		delta * look_ahead_smooth
	)

	pcam.set_follow_offset(current_offset)
