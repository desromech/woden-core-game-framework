"
A WDGFWorldTest is a test class for testing the behavior of WDGFWorld
"
Class {
	#name : #WDGFWorldTest,
	#superclass : #TestCase,
	#category : #'WodenGameFramework-Core-Tests'
}

{ #category : #tests }
WDGFWorldTest >> testGetOrCreateSubsystemWithClass [
	| world subsystem |
	world := WDGFWorld new.
	self assert: world subsystems isEmpty.

	subsystem := world getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	self assert: subsystem ownerWorld equals: world.
	self assert: (subsystem isKindOf: WDGFSceneSubsystem).
	self assert: (world subsystems includes: subsystem).
]

{ #category : #tests }
WDGFWorldTest >> testNew [
	| world |
	world := WDGFWorld new.
	self assert: world actors isEmpty.
]

{ #category : #tests }
WDGFWorldTest >> testSpawnActor [
	| world actor gotBeginPlay |
	world := WDGFWorld new.
	self assert: world actors isEmpty.
	
	actor := WDGFActor new.
	gotBeginPlay := false.
	actor onBeginPlayDo: [gotBeginPlay := true].

	self assert: actor world isNil.
	world spawnActor: actor.
	self assert: actor world equals: world.
	self deny: gotBeginPlay.
	
	world updateSingleTimeStep: 0.125.
	self deny: gotBeginPlay.
	
	world beginPlay.
	world updateSingleTimeStep: 0.125.
	self assert: gotBeginPlay
]

{ #category : #tests }
WDGFWorldTest >> testSpawnActorAfterBeginPlay [
	| world actor gotBeginPlay |
	world := WDGFWorld new.
	world beginPlay.
	self assert: world actors isEmpty.
	
	actor := WDGFActor new.
	gotBeginPlay := false.
	actor onBeginPlayDo: [gotBeginPlay := true].

	self assert: actor world isNil.
	world spawnActor: actor.
	self assert: actor world equals: world.
	self deny: gotBeginPlay.
	
	world updateSingleTimeStep: 0.125.
	self assert: gotBeginPlay
]

{ #category : #tests }
WDGFWorldTest >> testSpawnTickingActor [
	| world actor expectedTick receivedTickDelta |
	world := WDGFWorld new.
	self assert: world actors isEmpty.
	
	actor := WDGFActor new.
	actor wantsToTick: true.
	expectedTick := 0.125.
	receivedTickDelta := nil.
	actor onTickDo: [:delta | receivedTickDelta := delta].

	self assert: actor world isNil.
	world spawnActor: actor.
	self assert: actor world equals: world.
	self assert: receivedTickDelta equals: nil.
	
	world updateSingleTimeStep: expectedTick.
	self assert: receivedTickDelta equals: nil.
	
	world beginPlay.
	world updateSingleTimeStep: expectedTick.
	self assert: receivedTickDelta equals: expectedTick.
]
