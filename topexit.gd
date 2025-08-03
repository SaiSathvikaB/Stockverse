extends Area2D

@onready var collision_shape_node = $CollisionShape2D
@onready var shape = collision_shape_node.shape

func _ready():
	queue_redraw()  # Triggers _draw() when the scene loads

func _draw():
	if shape is RectangleShape2D:
		var extents = shape.extents
		var position = collision_shape_node.position  # Local offset of CollisionShape2D
		var rect = Rect2(position - extents, extents * 2)
		draw_rect(rect, Color(0, 0, 0, 0.4), true)  # Solid red rectangle
