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
		'defaultCamera'
	],
	#category : #'WodenGameFramework-Morphic'
}

{ #category : #accessing }
WDGFWorldMorph >> getOrCreateDefaultCamera [
	^ defaultCamera ifNil: [defaultCamera := WDCamera new asSceneNode
			position: (Vector3 x: 0 y: 0 z: 0);
			yourself
		]
]

{ #category : #initialization }
WDGFWorldMorph >> initialize [
	super initialize.
	playing := false.
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
