extends Area2D

var speed := 1.0
var direction := Vector2.RIGHT
var next_direction := Vector2.RIGHT
var cell_size := 50

func _ready() -> void:
	move_to_next_tile()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_UP and direction != Vector2.DOWN:
			next_direction = Vector2.UP
		elif event.keycode == KEY_DOWN and direction != Vector2.UP:
			next_direction = Vector2.DOWN
		elif event.keycode == KEY_LEFT and direction != Vector2.RIGHT:
			next_direction = Vector2.LEFT
		elif event.keycode == KEY_RIGHT and direction != Vector2.LEFT:
			next_direction = Vector2.RIGHT

func move_to_next_tile():
	direction = next_direction
	var tween = create_tween()
	var new_direction = position + direction * cell_size
	tween.tween_property(self, "position", new_direction, 1.0 / speed)
	tween.tween_callback(move_to_next_tile)
