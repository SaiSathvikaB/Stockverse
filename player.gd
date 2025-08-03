extends CharacterBody2D

@export var speed := 200.0
@onready var anim := $AnimatedSprite2D

func _physics_process(delta):
	var dir := Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1

	if dir != Vector2.ZERO:
		dir = dir.normalized()
		velocity = dir * speed
		move_and_slide()

		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
				anim.play("walkright")
			else:
				anim.play("walkleft")
		else:
			if dir.y > 0:
				anim.play("walkfront")
			else:
				anim.play("walkback")
	else:
		velocity = Vector2.ZERO
		anim.stop()
