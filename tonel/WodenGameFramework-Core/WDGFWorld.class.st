"
I am a world in the game framework. I typically contain a list of actors and different subsystems that are used for sequencing mutations between the different actors and their components.
"
Class {
	#name : #WDGFWorld,
	#superclass : #WDGFWorldElement,
	#instVars : [
		'actors',
		'firstPendingMessage',
		'lastPendingMessage',
		'subsystems',
		'subsystemDirectionary',
		'isPlaying',
		'accumulatedDeltaTime',
		'updateTimeStep',
		'currentTime'
	],
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #accessing }
WDGFWorld >> actors [
	^ actors
]

{ #category : #'actor lifecycle' }
WDGFWorld >> beginPlay [
	isPlaying ifTrue: [ ^ self ].

	isPlaying := true.
	subsystems do: [:each | each beginPlay].
	actors do: [ :each | each send: #beginPlay ].

]

{ #category : #accessing }
WDGFWorld >> currentTime [
	^ currentTime
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

{ #category : #accessing }
WDGFWorld >> getOrCreateSubsystemWithClass: aSubsystemClass [
	^ subsystemDirectionary at: aSubsystemClass ifAbsentPut: [ 
		| instance |
		instance := aSubsystemClass new
			createdInWorld: self;
			yourself.
		isPlaying ifTrue: [ instance beginPlay ].
		subsystems add: instance.
		instance
	]
]

{ #category : #initialization }
WDGFWorld >> initialize [
	super initialize.
	actors := OrderedCollection new.
	subsystems := OrderedCollection new.
	subsystemDirectionary := Dictionary new.
	isPlaying := false.
	accumulatedDeltaTime := 0.0.
	updateTimeStep := 1.0/60.0.
	currentTime := 0.0.
]

{ #category : #accessing }
WDGFWorld >> isPlaying [
	^ isPlaying
]

{ #category : #messages }
WDGFWorld >> nextPendingMessage [
	| result |
	result := firstPendingMessage.
	result ifNil: [ ^ nil ].
	
	firstPendingMessage := firstPendingMessage nextMessage.
	firstPendingMessage ifNil: [
		lastPendingMessage := nil
	].

	result nextMessage: nil.
	^ result
]

{ #category : #messages }
WDGFWorld >> processAllPendingMessages [
	| message |
	[ (message := self nextPendingMessage) notNil ] whileTrue: [ 
		message process
	]
]

{ #category : #'actor lifecycle' }
WDGFWorld >> spawnActor: anObjectConvertibleToActor [
	| anActor |
	anActor := anObjectConvertibleToActor asGameFrameworkActor.
	self assert: anActor world isNil.
	anActor handle world: self.
	actors add: anActor.
	
	anActor registerWithSubsystemsInWorld: self.
	isPlaying ifTrue: [ 
		anActor send: #beginPlay.
	].
	^ anActor handle
]

{ #category : #accessing }
WDGFWorld >> subsystems [
	^ subsystems
]

{ #category : #update }
WDGFWorld >> updateSingleTimeStep: delta [
	currentTime := currentTime + delta.
	subsystems do: [ :each | each updateSingleTimeStep: delta ].
	self processAllPendingMessages.
	subsystems do: [ :each | each postActorMessagesUpdateSingleTimeStep: delta ].
]

{ #category : #accessing }
WDGFWorld >> updateTimeStep [

	^ updateTimeStep
]

{ #category : #accessing }
WDGFWorld >> updateTimeStep: anObject [

	updateTimeStep := anObject
]

{ #category : #update }
WDGFWorld >> updateWithDeltaTime: deltaTime [
	accumulatedDeltaTime := accumulatedDeltaTime + deltaTime.
	[accumulatedDeltaTime >= updateTimeStep] whileTrue: [
		self updateSingleTimeStep: updateTimeStep.
		accumulatedDeltaTime := accumulatedDeltaTime - updateTimeStep
	].
]
