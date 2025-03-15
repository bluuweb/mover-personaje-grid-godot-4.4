extends Area2D

var speed := 1.0
var direction := Vector2.ZERO
var cell_size := 50
var is_moving := false

func _input(event: InputEvent) -> void:
	
	if is_moving:
		return # Evita que el jugador cambie de dirección mientras se mueve
	
	if event is InputEventKey and event.pressed and !is_moving:
		if event.keycode == KEY_UP:
			direction = Vector2.UP
		elif event.keycode == KEY_DOWN:
			direction = Vector2.DOWN
		elif event.keycode == KEY_LEFT:
			direction = Vector2.LEFT
		elif event.keycode == KEY_RIGHT:
			direction = Vector2.RIGHT
			
		if direction != Vector2.ZERO:
			move_to_next_tile()

func move_to_next_tile() -> void:
	is_moving = true
	
	var tween = create_tween()
	var new_position = position + direction * cell_size
	tween.tween_property(self, "position", new_position, 1.0 / speed)

	tween.tween_callback(move_finish)

func move_finish() -> void:
	is_moving = false
