"
I am a character actor that can be used as a player.
"
Class {
	#name : #WDGFPlayerActor,
	#superclass : #WDGFCharacterActor,
	#instVars : [
		'cameraComponent',
		'cameraAngles',
		'pickedObject',
		'pickedObjectConstraintActor',
		'floorToLocalTransform'
	],
	#category : #'WodenGameFramework-Core-Actor-Character'
}

{ #category : #defaults }
WDGFPlayerActor class >> defaultMaxPickableWeight [
	^ 20
]

{ #category : #defaults }
WDGFPlayerActor class >> defaultMaxPickingDistance [
	^ 2
]

{ #category : #'as yet unclassified' }
WDGFPlayerActor class >> defaultThrowSpeed [
	^ 10.0
]

{ #category : #accessing }
WDGFPlayerActor >> cameraComponent [
	^ cameraComponent
]

{ #category : #accessing }
WDGFPlayerActor >> floorToLocalTransform [
	^ floorToLocalTransform
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
		walkingDirection z < 0 ifTrue: [
			walkingDirection z: 0.
		].
	].

	event symbol = KeyboardKey A ifTrue: [
		walkingDirection x < 0 ifTrue: [
			walkingDirection x: 0.
		].
	].

	event symbol = KeyboardKey S ifTrue: [
		walkingDirection z > 0 ifTrue: [
			walkingDirection z: 0.
		].
	].
	
	event symbol = KeyboardKey D ifTrue: [
		walkingDirection x > 0 ifTrue: [
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
	ray := cameraComponent worldRayFrom: Vector3 zeros to: (Vector3 z: -1) * self class defaultMaxPickingDistance.
	rayCastQueryResult := self rayCast: ray forFirstActorSuchThat: [ :actor |
		actor hasRigidBody and: [ actor mass <= self class defaultMaxPickableWeight ]
	].
	rayCastQueryResult ifNil: [ ^ self ].
	
	pickedObject := rayCastQueryResult actor.
	pickedObjectConstraintActor := WDGFActor new
		addComponent: (WDGFPhysicsHoldObjectConstraintComponent new
			stiffness: 100.0;
			damping: 10.0;
			firstObject: cameraComponent;
			secondObject: pickedObject;
			targetRelativePosition: (Vector3 z: -1.0);
			targetRelativeOrientation: (cameraComponent transformWorldOrientationToLocal: pickedObject orientation);
			yourself);
		yourself.
	pickedObject collisionActorExclusionSet: { self }.
	self world spawnActor: pickedObjectConstraintActor
	

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
	
	floorToLocalTransform := ReversibleAffineTransform3D translation: (Vector3 y: self class defaultHeight * -0.5).
	
	cameraComponent := WDGFCameraComponent new
		isActive: true;
		position: (Vector3 y: self class defaultHeight * 0.5);
		headFloorTransform: (ReversibleAffineTransform3D translation: (Vector3 y: self class defaultHeight negated));
		yourself.
	rootSceneComponent addChildSceneComponent: cameraComponent.
	self addComponent: WDGFInputListenerComponent new.

	WDGFPlayerVRHandComponent new
		setupForLeftHand;
		addIntoPlayerActor: self.

	WDGFPlayerVRHandComponent new
		setupForRightHand;
		addIntoPlayerActor: self.

]

{ #category : #'picking - throwing' }
WDGFPlayerActor >> throwPickedObject [
	pickedObjectConstraintActor destroy.
	pickedObject
		collisionActorExclusionSet: #();
		position: (cameraComponent transformPositionToWorld: (Vector3 z: -1.0));
		linearVelocity: self linearVelocity + ((cameraComponent transformVectorToWorld: (Vector3 z: -1.0)) * self class defaultThrowSpeed);
		angularVelocity: self angularVelocity.

	pickedObject := nil.
	pickedObjectConstraintActor := nil.
	
]

{ #category : #'game events' }
WDGFPlayerActor >> tick: deltaSeconds [
	super tick: deltaSeconds.
	cameraAngles x: (cameraAngles x clampBetween: Float halfPi negated and: Float halfPi).
	cameraComponent orientation: (Quaternion xRotation: cameraAngles x).
	self orientation: (Quaternion yRotation: cameraAngles y).
]
