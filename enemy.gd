extends CharacterBody2D

func _physics_process(delta: float) -> void:
	var player = get_parent().get_node("player")
	
	var direction = (player.position - position).normalized()
	position += direction * 100 * delta  # 100 — це швидкість
	
	look_at(player.position)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Bullet" in body.name:
		queue_free() 
