extends CharacterBody2D

var movespeed = 400
# Змінна швидкості руху персонажа (пікселі за секунду)
var bullet_speed = 100
# Швидкість польоту кулі
var bullet = preload("res://bullet.tscn")
# Підвантаження сцени кулі заздалегідь (щоб потім створювати екземпляри)

func _physics_process(delta):
# Функція, що виконується кожен кадр у фізичному циклі (рекомендується для руху)
	var motion = Vector2.ZERO
	# Створюємо вектор руху, початково без руху (0,0)
	if Input.is_action_pressed("up"):
		motion.y -= 1
	# Якщо натиснута кнопка "up" (наприклад, стрілка вгору або W), то рухаємося вгору (по осі Y мінус)
	if Input.is_action_pressed("down"):
		motion.y += 1
	# Аналогічно, для кнопки "down" рухаємося вниз (по осі Y плюс)
	if Input.is_action_pressed("left"):
		motion.x -= 1
	# Для кнопки "left" рух вліво (по осі X мінус)
	if Input.is_action_pressed("right"):
		motion.x += 1
		# Для кнопки "right" рух вправо (по осі X плюс)

	motion = motion.normalized()
	# Нормалізуємо вектор руху, щоб рухати персонажа рівномірно по діагоналі (щоб швидкість не була більшою при діагональному русі)
	velocity = motion * movespeed
	# Задаємо вбудовану властивість velocity (CharacterBody2D) — це швидкість персонажа
	move_and_slide()
	# Метод, який рухає персонажа відповідно до velocity і враховує колізії
	look_at(get_global_mouse_position())
	# Повертаємо персонажа у напрямку позиції миші у глобальних координатах — персонаж "дивиться" на курсор
	if Input.is_action_just_pressed("LMB"):
		fire()
	# Якщо була натиснута ліва кнопка миші ("LMB") — викликаємо функцію fire() для стрільби

func fire(): # Функція створення та запуску кулі
	var bullet_instance = bullet.instantiate()
	# Створюємо новий екземпляр кулі зі сцени bullet.tscn
	bullet_instance.global_position = global_position + Vector2(30, 0).rotated(rotation)
	# Встановлюємо позицію кулі трохи попереду персонажа (30 пікселів вперед за напрямком повороту)
	bullet_instance.rotation = rotation
	# Встановлюємо поворот кулі таким самим, як у персонажа (щоб куля летіла в ту ж сторону)
	bullet_instance.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	# Встановлюємо швидкість руху кулі: вектор вправо зі швидкістю bullet_speed, повернутий на кут rotation
	get_tree().current_scene.add_child(bullet_instance)
	# Додаємо кулю до поточної сцени, щоб вона з’явилась в грі і почала рухатися

func kill():
	get_tree().reload_current_scene()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		kill()
