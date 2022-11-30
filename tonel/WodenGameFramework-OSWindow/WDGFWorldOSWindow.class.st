"
I am an OSWindow that is used for displaying a Woden Game Framework World. I am also used for injecting user inputs an events into this environment.
"
Class {
	#name : #WDGFWorldOSWindow,
	#superclass : #WDSceneOSWindow,
	#instVars : [
		'playing',
		'wodenWorld',
		'convertedEventQueue',
		'defaultCamera'
	],
	#category : #'WodenGameFramework-OSWindow'
}

{ #category : #'as yet unclassified' }
WDGFWorldOSWindow class >> eventHandlerClass [
	^ WDGFWorldOSWindowEventHandler
]

{ #category : #events }
WDGFWorldOSWindow >> convertKeySymbol: keySymbol [
	^ OSKeySymbols mapKeySymbolValueToKeyboardKey: keySymbol
]

{ #category : #events }
WDGFWorldOSWindow >> convertModifiers: osWindowModifiers [
	^ WDGFInputStateModifiers new
		leftShift: osWindowModifiers leftShift;
		rightShift: osWindowModifiers rightShift;
		leftAlt: osWindowModifiers leftAlt;
		rightAlt: osWindowModifiers rightAlt;
		leftCtrl: osWindowModifiers leftCtrl;
		rightCtrl: osWindowModifiers rightCtrl;
		leftCmd: osWindowModifiers leftCmd;
		rightCmd: osWindowModifiers rightCmd;
		capsLock: osWindowModifiers capsLock;
		numLock: osWindowModifiers numLock;
		yourself
]

{ #category : #events }
WDGFWorldOSWindow >> dispatchQueuedEvents [
	| inputSubsystem |
	inputSubsystem := wodenWorld ifNotNil: [ :world | world getOrCreateSubsystemWithClass: WDGFInputSubsystem ].

	[convertedEventQueue isEmpty ] whileFalse: [ 
		| convertedEvent |
		convertedEvent := convertedEventQueue next.
		inputSubsystem ifNotNil: [
			inputSubsystem dispatchEvent: convertedEvent
		]
	]
]

{ #category : #update }
WDGFWorldOSWindow >> doUpdate [
	| currentStepTime deltaTime |
	lastSceneUpdateTime ifNil: [ lastSceneUpdateTime := Time monotonicMicrosecondClockValue ].
	currentStepTime := Time monotonicMicrosecondClockValue.
	deltaTime := (currentStepTime - lastSceneUpdateTime) * 1e-6 min: 0.125.

	self dispatchQueuedEvents.
	wodenWorld ifNotNil: [
		wodenWorld updateWithDeltaTime: deltaTime.
		self camera: self selectCurrentCamera.
		self camera ifNotNil: [ :validCamera |
			validCamera cameras first currentTime: wodenWorld currentTime.
		].
		needsToRender := needsToRender or: [ wodenWorld isPlaying ]
	].
	
	lastSceneUpdateTime := currentStepTime
]

{ #category : #events }
WDGFWorldOSWindow >> enqueueConvertedEvent: aConvertedEvent [
	convertedEventQueue nextPut: aConvertedEvent.
	self changed.
]

{ #category : #accessing }
WDGFWorldOSWindow >> getOrCreateDefaultCamera [
	^ defaultCamera ifNil: [defaultCamera := WDCamera new asSceneNode
			position: (Vector3 x: 0 y: 0 z: 0);
			yourself
		]
]

{ #category : #initialization }
WDGFWorldOSWindow >> initialize [
	super initialize.
	playing := false.
	convertedEventQueue := AtomicSharedQueue new.
]

{ #category : #events }
WDGFWorldOSWindow >> onJoyAxis: anEvent [
	self enqueueConvertedEvent: (WDGFGamepadAxisEvent new
		id: anEvent which;
		axis: anEvent axis;
		value: anEvent value;
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onJoyButtonDown: anEvent [
	self enqueueConvertedEvent: (WDGFGamepadButtonPressEvent new
		id: anEvent which;
		button: anEvent button;
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onJoyButtonUp: anEvent [
	self enqueueConvertedEvent: (WDGFGamepadButtonReleaseEvent new
		id: anEvent which;
		button: anEvent button;
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onKeyDown: anEvent [
	self enqueueConvertedEvent: (WDGFKeyDownEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		symbol: (self convertKeySymbol: anEvent symbol);
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onKeyUp: anEvent [
	self enqueueConvertedEvent: (WDGFKeyUpEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		symbol: (self convertKeySymbol: anEvent symbol);
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onMouseButtonPress: anEvent [
	self enqueueConvertedEvent: (WDGFMouseButtonPressEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		position: (Vector2 x: anEvent position x y: anEvent position y);
		button: anEvent button;
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onMouseButtonRelease: anEvent [
	self enqueueConvertedEvent: (WDGFMouseButtonReleaseEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		position: (Vector2 x: anEvent position x y: anEvent position y);
		button: anEvent button;
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onMouseMove: anEvent [
	self enqueueConvertedEvent: (WDGFMouseMoveEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		position: (Vector2 x: anEvent position x y: anEvent position y);
		delta: (Vector2 x: anEvent delta x y: anEvent delta y);
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onMouseWheel: anEvent [
]

{ #category : #events }
WDGFWorldOSWindow >> onTextInput: anEvent [
	self enqueueConvertedEvent: (WDGFTextInputEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		text: anEvent text;
		yourself)
]

{ #category : #accessing }
WDGFWorldOSWindow >> playing [

	^ playing
]

{ #category : #accessing }
WDGFWorldOSWindow >> playing: anObject [

	playing := anObject
]

{ #category : #accessing }
WDGFWorldOSWindow >> selectCurrentCamera [
	wodenWorld ifNotNil: [ 
		(wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem) findActiveCameraComponent ifNotNil: [ :cameraComponent |
				^ cameraComponent sceneNode
		]
	].

	^ self getOrCreateDefaultCamera
]

{ #category : #accessing }
WDGFWorldOSWindow >> wodenWorld [

	^ wodenWorld
]

{ #category : #accessing }
WDGFWorldOSWindow >> wodenWorld: anObject [
	| sceneSubsystem |
	wodenWorld := anObject.
	sceneSubsystem := wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	self scene: sceneSubsystem scene.
	self camera: self selectCurrentCamera.
	sceneSubsystem whenSceneChangedDo: [ self changed ].
	self changed.
]
