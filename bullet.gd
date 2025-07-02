extends RigidBody2D

func _ready():
	# автоматично знищується через 2 секунди
	await get_tree().create_timer(2.0).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
