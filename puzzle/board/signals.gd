extends Node

signal TilePressed(tile)
signal TileMatched(tile)
signal TileCollected(tile)
signal TileRemovedFromBoard(tile)

signal TileResolveTriggered()
signal TileResolveRemovedMatched()

signal BoardLayoutChanged()

signal TurnTimerExpired()
