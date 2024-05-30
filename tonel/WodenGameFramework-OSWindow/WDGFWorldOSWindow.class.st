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
		'defaultCamera',
		'hasMouseCapture'
	],
	#category : #'WodenGameFramework-OSWindow'
}

{ #category : #'as yet unclassified' }
WDGFWorldOSWindow class >> eventHandlerClass [
	^ WDGFWorldOSWindowEventHandler
]

{ #category : #'mouse capture' }
WDGFWorldOSWindow >> captureMouse [
	osWindow ifNotNil: [
		hasMouseCapture := true.
		osWindow captureMouse
	].
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
WDGFWorldOSWindow >> convertMouseButtonState: osWindowButtonState [
	^ WDGFInputMouseButtonState new
		leftButton: osWindowButtonState button1;
		middleButton: osWindowButtonState button2;
		rightButton: osWindowButtonState button3;
		extraButton: osWindowButtonState button4;
		extraButton2: osWindowButtonState button5;
		yourself
]

{ #category : #'as yet unclassified' }
WDGFWorldOSWindow >> destroyResources [
	super destroyResources.
	wodenWorld ifNotNil: [ wodenWorld closeAndDestroy ]
]

{ #category : #events }
WDGFWorldOSWindow >> dispatchQueuedEvents [
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

{ #category : #accessing }
WDGFWorldOSWindow >> hasMouseCapture [
	^ hasMouseCapture
]

{ #category : #initialization }
WDGFWorldOSWindow >> initialize [
	super initialize.
	playing := false.
	convertedEventQueue := AtomicSharedQueue new.
	hasMouseCapture := false.
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
	(anEvent symbol = 1073741882 and: [anEvent modifiers shift]) ifTrue: [ 
		self releaseMouse
	].
	
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
		buttons: (self convertMouseButtonState: anEvent buttons);
		position: (Vector2 x: anEvent position x y: anEvent position y);
		button: anEvent button;
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onMouseButtonRelease: anEvent [
	self enqueueConvertedEvent: (WDGFMouseButtonReleaseEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		buttons: (self convertMouseButtonState: anEvent buttons);
		position: (Vector2 x: anEvent position x y: anEvent position y);
		button: anEvent button;
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onMouseMove: anEvent [
	self enqueueConvertedEvent: (WDGFMouseMoveEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		buttons: (self convertMouseButtonState: anEvent buttons);
		position: (Vector2 x: anEvent position x y: anEvent position y);
		delta: (Vector2 x: anEvent delta x y: anEvent delta y);
		yourself)
]

{ #category : #events }
WDGFWorldOSWindow >> onMouseWheel: anEvent [
	self enqueueConvertedEvent: (WDGFMouseWheelEvent new
		modifiers: (self convertModifiers: anEvent modifiers);
		buttons: (self convertMouseButtonState: anEvent buttons);
		position: (Vector2 x: anEvent position x y: anEvent position y);
		scrollHorizontal: anEvent scrollHorizontal;
		scrollVertical: anEvent scrollVertical;
		yourself)
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

{ #category : #rendering }
WDGFWorldOSWindow >> pollVREventsAndUpdate [
	vrSystem ifNil: [ ^ self ].
	
	wodenWorld ifNotNil: [
		wodenWorld vrSubsystem updateAndProcessEventsFor: vrSystem
	] ifNil: [
		vrSystem resetTrackedDeviceEventHandlers; pollEvents.
	].
]

{ #category : #'mouse capture' }
WDGFWorldOSWindow >> releaseMouse [
	osWindow ifNotNil: [
		hasMouseCapture := false.
		osWindow releaseMouse
	]
]

{ #category : #accessing }
WDGFWorldOSWindow >> selectCurrentCamera [
	self overlay: nil.
	wodenWorld ifNotNil: [ 
		(wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem) findActiveCameraComponent ifNotNil: [ :cameraComponent |
				cameraComponent viewportExtent: self windowExtent.
				self overlay: cameraComponent overlay.
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
	| sceneSubsystem inputSubsystem |
	wodenWorld := anObject.
	sceneSubsystem := wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	inputSubsystem := wodenWorld getOrCreateSubsystemWithClass: WDGFInputSubsystem.
	self scene: sceneSubsystem scene.
	self camera: self selectCurrentCamera.
	sceneSubsystem whenSceneChangedDo: [ self changed ].
	inputSubsystem
		supportsMouseCapture: true;
		hasMouseCaptureBlock: [ self hasMouseCapture ];
		onCaptureMouseDo: [ self captureMouse ];
		onReleaseMouseDo: [ self releaseMouse ].
	self changed.
]
