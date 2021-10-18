"
I am a world in the game framework. I typically contain a list of actors and different subsystems that are used for sequencing mutations between the different actors and their components.
"
Class {
	#name : #WDGFWorld,
	#superclass : #Object,
	#instVars : [
		'actors',
		'firstPendingMessage',
		'lastPendingMessage'
	],
	#category : #'WodenGameFramework-Core'
}

{ #category : #accessing }
WDGFWorld >> actors [
	^ actors
]

{ #category : #messages }
WDGFWorld >> enqueueMessage: aMessage [
	self assert: aMessage nextMessage isNil.
	lastPendingMessage ifNil: [ 
		self assert: firstPendingMessage isNil.
		firstPendingMessage := lastPendingMessage := aMessage
	] ifNotNil: [
		lastPendingMessage nextMessage: aMessage.
		lastPendingMessage := aMessage
	]
]

{ #category : #initialization }
WDGFWorld >> initialize [
	super initialize.
	actors := OrderedCollection new.
]

{ #category : #messages }
WDGFWorld >> nextPendingMessage [
	| result |
	result := firstPendingMessage.
	result ifNil: [ ^ nil ].
	
	firstPendingMessage := firstPendingMessage nextMessage.
	firstPendingMessage ifNotNil: [
		lastPendingMessage := nil
	].

	result nextMessage: nil.
	^ result
]

{ #category : #messages }
WDGFWorld >> processAllPendingMessages [
	| message |
	[ (message := self nextPendingMessage) isNotNil ] whileTrue: [ 
		message process
	]
]

{ #category : #'actor lifecycle' }
WDGFWorld >> spawnActor: anActor [
	self assert: anActor world isNil.
	anActor handle world: self.
	actors add: anActor.
	
	anActor send: #beginPlay.
]

{ #category : #update }
WDGFWorld >> updateSingleTimeStep: delta [
	self processAllPendingMessages
]
