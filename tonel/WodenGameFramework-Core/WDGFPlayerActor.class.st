"
I am a character actor that can be used as a player.
"
Class {
	#name : #WDGFPlayerActor,
	#superclass : #WDGFCharacterActor,
	#instVars : [
		'cameraComponent',
		'cameraAngles',
		'pickedObject'
	],
	#category : #'WodenGameFramework-Core-Actor-Character'
}

{ #category : #defaults }
WDGFPlayerActor class >> defaultMaxPickableWeight [
	^ 20
]

{ #category : #initialization }
WDGFPlayerActor >> initialize [
	super initialize.
	cameraAngles := Vector3 zeros.

]

{ #category : #'input events' }
WDGFPlayerActor >> keyDownEvent: event [
	event symbol = KeyboardKey W ifTrue: [
		walkingDirection z: -1.
	].
	event symbol = KeyboardKey A ifTrue: [
		walkingDirection x: -1.
	].
	event symbol = KeyboardKey S ifTrue: [
		walkingDirection z: 1.
	].
	event symbol = KeyboardKey D ifTrue: [
		walkingDirection x: 1.
	].
	event symbol = KeyboardKey E ifTrue: [
		self pickOrThrowObjectInFront
	].
	event symbol = KeyboardKey space ifTrue: [
		self jump
	].

]

{ #category : #'input events' }
WDGFPlayerActor >> keyUpEvent: event [
	event symbol = KeyboardKey W ifTrue: [
		walkingDirection < 0 ifTrue: [
			walkingDirection z: 0.
		].
	].

	event symbol = KeyboardKey A ifTrue: [
		walkingDirection < 0 ifTrue: [
			walkingDirection x: 0.
		].
	].

	event symbol = KeyboardKey S ifTrue: [
		walkingDirection > 0 ifTrue: [
			walkingDirection z: 0.
		].
	].
	
	event symbol = KeyboardKey D ifTrue: [
		walkingDirection > 0 ifTrue: [
			walkingDirection x: 0.
		].
	].

]

{ #category : #'input events' }
WDGFPlayerActor >> mouseMoveEvent: event [
	| delta |
	delta := event delta.

	event buttons leftButton ifTrue: [ 
		cameraAngles := cameraAngles + (Vector3 x: delta y negated degreesToRadians y: delta x negated degreesToRadians z: 0.0).
	].

]

{ #category : #'picking - throwing' }
WDGFPlayerActor >> pickObjectInFront [
	| ray rayCastQueryResult |
	ray := cameraComponent worldRayFrom: Vector3 zeros to: (Vector3 z: -2.0).
	rayCastQueryResult := self rayCast: ray forFirstActorSuchThat: [ :actor |
		actor hasRigidBody and: [ actor mass <= self class defaultMaxPickableWeight ]
	].
	rayCastQueryResult ifNil: [ ^ self ].
	
	pickedObject := rayCastQueryResult actor.
	Transcript show: pickedObject; cr.
	

]

{ #category : #'picking - throwing' }
WDGFPlayerActor >> pickOrThrowObjectInFront [
	pickedObject
		ifNil: [ self pickObjectInFront ]
		ifNotNil: [ self throwPickedObject ]
]

{ #category : #initialization }
WDGFPlayerActor >> setupComponents [
	super setupComponents.
	
	cameraComponent := WDGFCameraComponent new
		isActive: true;
		position: (Vector3 y: self class defaultHeight * 0.5);
		yourself.
	rootSceneComponent addChildSceneComponent: cameraComponent.
	self addComponent: WDGFInputListenerComponent new.

]

{ #category : #'picking - throwing' }
WDGFPlayerActor >> throwPickedObject [
	Transcript show: 'TODO: Throw picked object'; cr.
	pickedObject := nil.
]

{ #category : #'game events' }
WDGFPlayerActor >> tick: deltaSeconds [
	super tick: deltaSeconds.
	cameraAngles x: (cameraAngles x clampBetween: Float halfPi negated and: Float halfPi).
	cameraComponent orientation: (Quaternion xRotation: cameraAngles x).
	self orientation: (Quaternion yRotation: cameraAngles y)
]
