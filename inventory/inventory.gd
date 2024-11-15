extends Control

var inventory_items = []
var items = []
var names = []
var amounts = []
var selected_item = 0
@onready var item_parent = $SubViewport/ItemSlot


func _ready():
	inventory_items.append(items)
	inventory_items.append(names)
	inventory_items.append(amounts)
	items.append(null)
	names.append("")
	amounts.append("")
	print(inventory_items)


func _input(event):
	if event.is_action_pressed("next_item"):
		if inventory_items[0][selected_item] != null and !inventory_items[0][selected_item].visible:
			show_item()
		else:
			hide_item()
			selected_item += 1
			if selected_item == items.size():
				selected_item = 0
			show_item()
	if event.is_action_pressed("previous_item"):
		previous_item()
	#if event.is_action_pressed("hide_item"):
		#hide_item()
	#if event.is_action_pressed("drop_item"):
		#drop_item()
	if event.is_action_pressed("jump"):
		use_item()


func add_to_inventory(item):
	if item.has_method("on_frob") and !item._name in names:
		items.append(item)
		names.append(item._name)
		amounts.append(1)
		print(inventory_items)
		#item.freeze = true
		#item.get_child(0).disabled = true
		item.call_deferred("reparent", item_parent)
		#item.reparent(item_parent)
		item.scale = Vector3(1,1,1)
		item.position = Vector3.ZERO
		item.rotation_degrees = Vector3.ZERO
	else:
		var index = names.find(item._name)
		inventory_items[2][index] += 1
		print(inventory_items)
		item.queue_free()
	hide_item()
	selected_item = names.find(item._name)
	call_deferred("show_item")
		#print(item.get_child(0).get_child(0))
		#item_mesh = item.get_child(0).get_child(0)


func drop_item(pos = 0):
	if inventory_items[0][selected_item] != null:
		var dropped_item = inventory_items[0][selected_item].duplicate()
		dropped_item.freeze = false
		dropped_item.get_child(0).disabled = false
		get_parent().get_parent().add_child(dropped_item)
		var forward = -get_parent().global_transform.basis.z
		# Add a raycast here that checks that the item cannot clip thru a wall
		dropped_item.global_position = pos - forward * 0.1#get_parent().global_transform.origin + forward * 0.75
		#dropped_item.global_position.y += get_parent()._collider.shape.height / 1.5
		remove_from_inventory(dropped_item)


func use_item():
	if inventory_items[0][selected_item] != null and inventory_items[0][selected_item].has_method("eat"):
		if $"..".health.add_health(inventory_items[0][selected_item].nutritional_value):
			remove_from_inventory(inventory_items[0][selected_item])


func remove_from_inventory(item):
	var item_index = names.find(item._name)
	if inventory_items[2][item_index] == 1:
		inventory_items[0][item_index].queue_free()
		inventory_items[0].remove_at(item_index)
		inventory_items[1].remove_at(item_index)
		inventory_items[2].remove_at(item_index)
		selected_item = item_index - 1
		previous_item()
	else:
		inventory_items[2][item_index] -= 1
		show_item()


func previous_item():
	if inventory_items[0][selected_item] != null and !inventory_items[0][selected_item].visible:
			show_item()
	else:
		hide_item()
		selected_item -= 1
		if selected_item < 0:
			selected_item = items.size() - 1
		show_item()


func show_item():
	if inventory_items[0][selected_item] != null:
		inventory_items[0][selected_item].visible = true
		inventory_items[0][selected_item].scale = Vector3(1,1,1)
		inventory_items[0][selected_item].position = Vector3.ZERO
		inventory_items[0][selected_item].rotation_degrees = Vector3.ZERO
	$TextureRect/ItemName.text = "[center]" + inventory_items[1][selected_item] + "[/center]"
	if int(inventory_items[2][selected_item]) > 1:
		$TextureRect/ItemAmount.text = "[right]" + str(inventory_items[2][selected_item]) + "[/right]"


func hide_item():
	if inventory_items[0][selected_item] != null:
		inventory_items[0][selected_item].visible = false
	$TextureRect/ItemName.text = ""
	$TextureRect/ItemAmount.text = ""


func get_current_item_name():
	return inventory_items[1][selected_item]

func get_current_item():
	return inventory_items[0][selected_item]
