"
I am a bloc element which is used for displaying a Woden Game Framework World inside of Bloc.
"
Class {
	#name : #WDBlGFWorldElement,
	#superclass : #WDBlSceneElement,
	#instVars : [
		'wodenWorld',
		'defaultCamera',
		'playing',
		'updateTask',
		'convertedEventQueue'
	],
	#category : #'WodenGameFramework-Bloc'
}

{ #category : #'event handling' }
WDBlGFWorldElement >> dispatchQueuedEvents [
	| inputSubsystem |
	inputSubsystem := wodenWorld ifNotNil: [ :world | world inputSubsystem ].

	[convertedEventQueue isEmpty ] whileFalse: [ 
		| convertedEvent |
		convertedEvent := convertedEventQueue next.
		inputSubsystem ifNotNil: [
			inputSubsystem dispatchEvent: convertedEvent
		]
	]
]

{ #category : #'event handling' }
WDBlGFWorldElement >> enqueueConvertedEvent: aConvertedEvent [
	convertedEventQueue nextPut: aConvertedEvent.
	self invalidate.
]

{ #category : #accessing }
WDBlGFWorldElement >> getOrCreateDefaultCamera [
	^ defaultCamera ifNil: [defaultCamera := WDCamera new asSceneNode
			position: (Vector3 x: 0 y: 0 z: 0);
			yourself
		]
]

{ #category : #initialization }
WDBlGFWorldElement >> initialize [
	super initialize.
	playing := false.
	convertedEventQueue := AtomicSharedQueue new.
	self addEventHandler: WDBlGFWorldEventListener new.
]

{ #category : #'instance creation' }
WDBlGFWorldElement >> newUpdateTask [
	^ WDBlGFUpdateTask new worldElement: self
]

{ #category : #accessing }
WDBlGFWorldElement >> playing [

	^ playing
]

{ #category : #initialization }
WDBlGFWorldElement >> playing: aBoolean [
	playing := aBoolean.
	playing ifTrue: [
		self startUpdateTask.
	] ifFalse: [
		self stopUpdateTask
	].
]

{ #category : #accessing }
WDBlGFWorldElement >> selectCurrentCamera [
	wodenWorld ifNotNil: [ 
		(wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem) findActiveCameraComponent ifNotNil: [ :cameraComponent |
				cameraComponent viewportExtent: self extent.
				^ cameraComponent sceneNode
		]
	].

	^ self getOrCreateDefaultCamera
]

{ #category : #initialization }
WDBlGFWorldElement >> startUpdateTask [
	self stopUpdateTask.
	playing ifFalse: [ ^ self ].
	self enqueueTask: (updateTask := self newUpdateTask)
]

{ #category : #initialization }
WDBlGFWorldElement >> stopUpdateTask [
	updateTask ifNotNil: [ 
		updateTask stop.
		self dequeueTask: updateTask
	].


]

{ #category : #updating }
WDBlGFWorldElement >> updateTimestep: deltaTime [
	self dispatchQueuedEvents.
	wodenWorld ifNil: [ ^ self ].
	
	wodenWorld updateWithDeltaTime: deltaTime.
	self camera: self selectCurrentCamera.
	self camera ifNotNil: [ :validCamera |
		validCamera cameras first currentTime: wodenWorld currentTime.
	].
	wodenWorld isPlaying ifTrue: [ 
		self invalidate.
	].

]

{ #category : #accessing }
WDBlGFWorldElement >> wodenWorld [

	^ wodenWorld
]

{ #category : #accessing }
WDBlGFWorldElement >> wodenWorld: anObject [
	| sceneSubsystem |
	wodenWorld := anObject.
	sceneSubsystem := wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	self scene: sceneSubsystem scene.
	self camera: self selectCurrentCamera.
	sceneSubsystem whenSceneChangedDo: [ self invalidate ].
	self invalidate.
]
