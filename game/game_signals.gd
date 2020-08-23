extends Node

# state changes
signal GoldBalanceChanged(old_balance, new_balance)
signal PlayerHealthChanged(old_health, new_health)

signal TurnEndMatchesReported(turn, matches)

signal GameStart()
signal GameOver()
