"
A WDGFWorldTest is a test class for testing the behavior of WDGFWorld
"
Class {
	#name : #WDGFWorldTest,
	#superclass : #TestCase,
	#category : #'WodenGameFramework-Core-Tests'
}

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
	self assert: gotBeginPlay
]
