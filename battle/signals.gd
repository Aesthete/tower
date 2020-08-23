extends Node

signal EnemyAttackTypeMatched(enemy)

signal BattlePhaseStarted()
signal BattlePhasePlayerAttackStarted()
signal BattlePhasePlayerAttackFinished()
signal BattlePhaseEnemyAttackStarted()
signal BattlePhaseEnemyAttackFinished()
signal BattlePhaseEnded()

signal PartyFinishedAttacking()
signal EnemiesFinishedAttack()

signal HeroAttackTriggered(hero, damage)
signal EnemyDamaged(enemy, amount)
signal EnemyKilled(enemy)
signal PlayerKilled()
signal PlayerDamaged(amount)
