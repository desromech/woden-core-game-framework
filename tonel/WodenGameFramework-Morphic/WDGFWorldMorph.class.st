"
I am a morph that displays a single Woden world.
"
Class {
	#name : #WDGFWorldMorph,
	#superclass : #WDSceneMorph,
	#instVars : [
		'wodenWorld',
		'playing',
		'lastStepTime'
	],
	#category : #'WodenGameFramework-Morphic'
}

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

{ #category : #stepping }
WDGFWorldMorph >> step [
	| currentStepTime deltaTime |
	lastStepTime ifNil: [ lastStepTime := Time microsecondClockValue ].
	currentStepTime := Time microsecondClockValue.
	deltaTime := (currentStepTime - lastStepTime) * 1e-6 min: 0.125.
	wodenWorld ifNotNil: [
		wodenWorld updateWithDeltaTime: deltaTime.
		self camera ifNotNil: [ :validCamera |
			validCamera cameras first currentTime: wodenWorld currentTime.
		].
		wodenWorld isPlaying ifTrue: [ 
			self changed.
		].
	].
	
	lastStepTime := currentStepTime
]

{ #category : #stepping }
WDGFWorldMorph >> stepTime [
	^ 16
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
	self camera: (WDCamera new asSceneNode position: (Vector3 x: 0 y: 0 z: 3)).
	sceneSubsystem whenSceneChangedDo: [ self changed ].
	self changed.
]
