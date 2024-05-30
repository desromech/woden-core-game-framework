"
I am a morph that displays a single Woden world.
"
Class {
	#name : #WDGFWorldMorph,
	#superclass : #WDSceneMorph,
	#instVars : [
		'wodenWorld',
		'playing',
		'lastStepTime',
		'defaultCamera',
		'convertedEventQueue'
	],
	#category : #'WodenGameFramework-Morphic'
}

{ #category : #'event handling' }
WDGFWorldMorph >> convertEventButton: event [
	event redButtonChanged ifTrue: [ ^ 1 ].
	event blueButtonChanged ifTrue: [ ^ 2 ].
	event yellowButtonChanged ifTrue: [ ^ 3 ].
	^ 0
]

{ #category : #'event handling' }
WDGFWorldMorph >> convertEventButtonState: event [
	^ WDGFInputMouseButtonState new
		leftButton: event redButtonPressed;
		middleButton: event blueButtonPressed;
		rightButton: event yellowButtonPressed;
		yourself
]

{ #category : #'event handling' }
WDGFWorldMorph >> convertEventModifiers: event [
	^ WDGFInputStateModifiers new
		leftShift: event shiftPressed;
		leftAlt: event optionKeyPressed;
		rightCtrl: event controlKeyPressed;
		leftCmd: event commandKeyPressed;
		yourself
]

{ #category : #'as yet unclassified' }
WDGFWorldMorph >> destroyResources [
	super destroyResources.
	wodenWorld ifNotNil: [ wodenWorld closeAndDestroy ].
	
]

{ #category : #'event handling' }
WDGFWorldMorph >> dispatchQueuedEvents [
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
WDGFWorldMorph >> enqueueConvertedEvent: aConvertedEvent [
	convertedEventQueue nextPut: aConvertedEvent.
	self changed.
]

{ #category : #accessing }
WDGFWorldMorph >> getOrCreateDefaultCamera [
	^ defaultCamera ifNil: [defaultCamera := WDCamera new asSceneNode
			position: (Vector3 x: 0 y: 0 z: 0);
			yourself
		]
]

{ #category : #'event handling' }
WDGFWorldMorph >> handlesKeyboard: evt [
	^true
]

{ #category : #'event handling' }
WDGFWorldMorph >> handlesMouseDown: anEvent [
	^ anEvent wasHandled not
]

{ #category : #'event handling' }
WDGFWorldMorph >> handlesMouseMove: anEvent [
	^ anEvent wasHandled not 
]

{ #category : #'event handling' }
WDGFWorldMorph >> handlesMouseWheel: anEvent [
	^ anEvent wasHandled not 
]

{ #category : #initialization }
WDGFWorldMorph >> initialize [
	super initialize.
	playing := false.
	convertedEventQueue := SharedQueue new.
]

{ #category : #'event handling' }
WDGFWorldMorph >> keyDown: event [
	self enqueueConvertedEvent: (WDGFKeyDownEvent new
		modifiers: (self convertEventModifiers: event);
		symbol: event key;
		yourself)
]

{ #category : #'event handling' }
WDGFWorldMorph >> keyUp: event [
	self enqueueConvertedEvent: (WDGFKeyUpEvent new
		modifiers: (self convertEventModifiers: event);
		symbol: event key;
		yourself)
	
]

{ #category : #'event handling' }
WDGFWorldMorph >> mouseDown: evt [
	self enqueueConvertedEvent: (WDGFMouseButtonPressEvent new
		modifiers: (self convertEventModifiers: evt);
		buttons: (self convertEventButtonState: evt);
		position: (evt position - self position) asVector2;
		button: (self convertEventButton: evt);
		yourself).
	evt hand newKeyboardFocus: self.
	
]

{ #category : #'event handling' }
WDGFWorldMorph >> mouseMove: evt [
	self enqueueConvertedEvent: (WDGFMouseMoveEvent new
		modifiers: (self convertEventModifiers: evt);
		buttons: (self convertEventButtonState: evt);
		position: (evt position - self position) asVector2;
		delta: (evt endPoint - evt startPoint) asVector2;
		yourself).
	evt hand newKeyboardFocus: self.
]

{ #category : #'event handling' }
WDGFWorldMorph >> mouseUp: evt [
	self enqueueConvertedEvent: (WDGFMouseButtonReleaseEvent new
		modifiers: (self convertEventModifiers: evt);
		buttons: (self convertEventButtonState: evt);
		position: (evt position - self position) asVector2;
		button: (self convertEventButton: evt);
		yourself).
	evt hand newKeyboardFocus: self.
	
]

{ #category : #'event handling' }
WDGFWorldMorph >> mouseWheel: evt [
	| convertedEvent |
	convertedEvent := WDGFMouseWheelEvent new.
	
	evt isUp ifTrue: [ convertedEvent scrollVertical: 1 ].
	evt isDown ifTrue: [ convertedEvent scrollVertical: -1 ].
	evt isLeft ifTrue: [ convertedEvent scrollHorizontal: -1 ].
	evt isRight ifTrue: [ convertedEvent scrollHorizontal: 1 ].
	
	self enqueueConvertedEvent: convertedEvent.
	evt wasHandled: true
]

{ #category : #accessing }
WDGFWorldMorph >> playing [

	^ playing
]

{ #category : #accessing }
WDGFWorldMorph >> playing: aBoolean [
	playing := aBoolean.
	playing ifTrue: [
		self startStepping.
	] ifFalse: [
		self stopStepping
	].
]

{ #category : #accessing }
WDGFWorldMorph >> selectCurrentCamera [
	wodenWorld ifNotNil: [ 
		(wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem) findActiveCameraComponent ifNotNil: [ :cameraComponent |
				cameraComponent viewportExtent: self extent.
				^ cameraComponent sceneNode
		]
	].

	^ self getOrCreateDefaultCamera
]

{ #category : #stepping }
WDGFWorldMorph >> step [
	| currentStepTime deltaTime |
	lastStepTime ifNil: [ lastStepTime := Time monotonicMicrosecondClockValue ].
	currentStepTime := Time monotonicMicrosecondClockValue.
	deltaTime := (currentStepTime - lastStepTime) * 1e-6 min: 0.125.
	
	self dispatchQueuedEvents.
	wodenWorld ifNotNil: [
		wodenWorld updateWithDeltaTime: deltaTime.
		self camera: self selectCurrentCamera.
		self camera ifNotNil: [ :validCamera |
			validCamera cameras first currentTime: wodenWorld currentTime.
		].
		wodenWorld isPlaying ifTrue: [ 
			self changed.
		].
	].
	
	lastStepTime := currentStepTime
]

{ #category : #accessing }
WDGFWorldMorph >> wodenWorld [

	^ wodenWorld
]

{ #category : #accessing }
WDGFWorldMorph >> wodenWorld: anObject [
	| sceneSubsystem |
	wodenWorld := anObject.
	sceneSubsystem := wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	self scene: sceneSubsystem scene.
	self camera: self selectCurrentCamera.
	sceneSubsystem whenSceneChangedDo: [ self changed ].
	self changed.
]
