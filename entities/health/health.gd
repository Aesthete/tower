extends Node
class_name Health

const SIGNAL_HEALTH_CHANGED : String = "health_changed"
signal health_changed
const SIGNAL_HEALTH_DEPLETED : String = "health_depleted"
signal health_depleted
const SIGNAL_STATUS_CHANGED : String = "status_changed"
signal status_changed

var health = 0
export(int) var max_health = 9

const POISON_DAMAGE = 1

var status = null
var poison_cycles = 0

func _ready():
	health = max_health
	$PoisonTimer.connect('timeout', self, '_on_PoisonTimer_timeout')

func _change_status(new_status):
	match status:
		EntityUtil.EntityStatusEffect.STATUS_POISONED:
			$PoisonTimer.stop()

	match new_status:
		EntityUtil.EntityStatusEffect.STATUS_POISONED:
			poison_cycles = 0
			$PoisonTimer.start()
	status = new_status
	emit_signal('status_changed', new_status)

func take_damage(amount, effect=null):
	if status == EntityUtil.EntityStatusEffect.STATUS_INVINCIBLE:
		return
	health -= amount
	health = max(0, health)	
	emit_signal(SIGNAL_HEALTH_CHANGED, health)

	if not effect:
		return
	match effect[0]:
		EntityUtil.EntityStatusEffect.STATUS_POISONED:
			_change_status(EntityUtil.EntityStatusEffect.STATUS_POISONED)
			poison_cycles = effect[1]
	print("%s got hit and took %s damage. Health: %s/%s" % [get_name(), amount, health, max_health])

func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal(SIGNAL_HEALTH_CHANGED, health)
	print("%s got healed by %s points. Health: %s/%s" % [get_name(), amount, health, max_health])

func _on_PoisonTimer_timeout():
	take_damage(POISON_DAMAGE)
	poison_cycles -= 1
	if poison_cycles == 0:
		_change_status(EntityUtil.EntityStatusEffect.STATUS_NONE)
		return
	$PoisonTimer.start()
