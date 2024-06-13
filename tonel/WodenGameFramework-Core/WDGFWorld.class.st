"
I am a world in the game framework. I typically contain a list of actors and different subsystems that are used for sequencing mutations between the different actors and their components.
"
Class {
	#name : 'WDGFWorld',
	#superclass : 'WDGFWorldElement',
	#instVars : [
		'applicationSettings',
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
	#category : 'WodenGameFramework-Core-Actor',
	#package : 'WodenGameFramework-Core',
	#tag : 'Actor'
}

{ #category : 'constructing' }
WDGFWorld class >> withApplicationSettings: applicationSettings [
	^ self new applicationSettings: applicationSettings; yourself
]

{ #category : 'accessing' }
WDGFWorld >> actors [
	^ actors
]

{ #category : 'initialization' }
WDGFWorld >> applicationSettings [
	^ applicationSettings
]

{ #category : 'initialization' }
WDGFWorld >> applicationSettings: newSettings [
	applicationSettings := newSettings asApplicationSettings
]

{ #category : 'actor lifecycle' }
WDGFWorld >> beginPlay [
	isPlaying ifTrue: [ ^ self ].

	isPlaying := true.
	subsystems do: [:each | each beginPlay].
	actors do: [ :each | each send: #beginPlay ].

]

{ #category : 'connection open/close' }
WDGFWorld >> closeAndDestroy [
	subsystems do: [ :each | each closeAndDestroy ]
]

{ #category : 'accessing' }
WDGFWorld >> currentTime [
	^ currentTime
]

{ #category : 'actor lifecycle' }
WDGFWorld >> destroyActor: anActor [
	anActor handle world == self ifFalse: [ ^ self ].
	
	anActor unregisterFromSubsystemsInWorld: self.
	anActor handle world: nil.
	actors remove: anActor.
]

{ #category : 'messages' }
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

{ #category : 'queries' }
WDGFWorld >> findActorsIntersectingBox: box transform: boxTransform suchThat: aPredicate [
	^ self physicsSubsystem findActorsIntersectingBox: box transform: boxTransform suchThat: aPredicate
]

{ #category : 'queries' }
WDGFWorld >> findActorsIntersectingSphere: sphere suchThat: aPredicate [
	^ self physicsSubsystem findActorsIntersectingSphere: sphere suchThat: aPredicate
]

{ #category : 'queries' }
WDGFWorld >> findActorsIntersectingSphere: sphere transform: sphereTransform suchThat: aPredicate [
	^ self physicsSubsystem findActorsIntersectingSphere: sphere transform: sphereTransform suchThat: aPredicate
]

{ #category : 'accessing' }
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

{ #category : 'initialization' }
WDGFWorld >> initialize [
	super initialize.
	self applicationSettings: WDGFApplicationSettings.
	actors := OrderedCollection new.
	subsystems := OrderedCollection new.
	subsystemDirectionary := Dictionary new.
	isPlaying := false.
	accumulatedDeltaTime := 0.0.
	updateTimeStep := 1.0/60.0.
	currentTime := 0.0.
]

{ #category : 'accessing' }
WDGFWorld >> inputSubsystem [
	^ self getOrCreateSubsystemWithClass: WDGFInputSubsystem
]

{ #category : 'accessing' }
WDGFWorld >> isPlaying [
	^ isPlaying
]

{ #category : 'as yet unclassified' }
WDGFWorld >> loadFromFileNamed: aFileName [
	WDGFWorldLoader new loadFromFileNamed: (applicationSettings resolveAssetPath: aFileName) in: self
]

{ #category : 'accessing' }
WDGFWorld >> menuSubsystem [
	^ self getOrCreateSubsystemWithClass: WDGFMenuSubsystem
]

{ #category : 'messages' }
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

{ #category : 'accessing' }
WDGFWorld >> physicsSubsystem [
	^ self getOrCreateSubsystemWithClass: WDGFPhysicsSubsystem
]

{ #category : 'messages' }
WDGFWorld >> processAllPendingMessages [
	| message |
	[ (message := self nextPendingMessage) notNil ] whileTrue: [ 
		message process
	]
]

{ #category : 'queries' }
WDGFWorld >> rayCast: ray excludingActors: exclusionSet forFirstActorSuchThat: aPredicate [
	^ self physicsSubsystem rayCast: ray excludingActors: exclusionSet forFirstActorSuchThat: aPredicate
]

{ #category : 'accessing' }
WDGFWorld >> sceneSubsystem [
	^ self getOrCreateSubsystemWithClass: WDGFSceneSubsystem
]

{ #category : 'accessing' }
WDGFWorld >> soundSubsystem [
	^ self getOrCreateSubsystemWithClass: WDGFSoundSubsystem
]

{ #category : 'actor lifecycle' }
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

{ #category : 'accessing' }
WDGFWorld >> subsystems [
	^ subsystems
]

{ #category : 'update' }
WDGFWorld >> updateSingleTimeStep: delta [
	currentTime := currentTime + delta.
	subsystems do: [ :each | each prePhysicsUpdateSingleTimeStep: delta ].
	self processAllPendingMessages.

	subsystems do: [ :each | each updateSingleTimeStep: delta ].
	self processAllPendingMessages.

	subsystems do: [ :each | each postActorMessagesUpdateSingleTimeStep: delta ].
]

{ #category : 'accessing' }
WDGFWorld >> updateTimeStep [

	^ updateTimeStep
]

{ #category : 'accessing' }
WDGFWorld >> updateTimeStep: anObject [

	updateTimeStep := anObject
]

{ #category : 'update' }
WDGFWorld >> updateWithDeltaTime: deltaTime [
	accumulatedDeltaTime := accumulatedDeltaTime + deltaTime.
	[accumulatedDeltaTime >= updateTimeStep] whileTrue: [
		self updateSingleTimeStep: updateTimeStep.
		accumulatedDeltaTime := accumulatedDeltaTime - updateTimeStep
	].
]

{ #category : 'accessing' }
WDGFWorld >> vrSubsystem [
	^ self getOrCreateSubsystemWithClass: WDGFVRSubsystem
]
