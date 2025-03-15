extends CharacterBody2D

var speed := 1.0
var direction := Vector2.ZERO
var cell_size := 50
var is_moving := false
var target_position := Vector2.ZERO

func _ready() -> void:
	# Inicializa la posición objetivo con la posición actual
	target_position = position

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

func _physics_process(delta: float) -> void:
	if is_moving:
		# Calcula la velocidad necesaria para llegar al objetivo
		var move_step = speed * cell_size * delta
		var distance_to_target = position.distance_to(target_position)
		
		if distance_to_target < move_step:
			# Si estamos cerca del objetivo, nos ubicamos exactamente allí
			position = target_position
			velocity = Vector2.ZERO
			move_finish()
		else:
			# Movemos el personaje usando velocity (propio de CharacterBody2D)
			velocity = direction * speed * cell_size
			move_and_slide()

func move_to_next_tile() -> void:
	is_moving = true
	target_position = position + direction * cell_size
	
	# Ya no necesitamos el tween, el movimiento se hace en _physics_process

func move_finish() -> void:
	is_moving = false
	direction = Vector2.ZERO
