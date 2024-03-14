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
		'isPreparingTeleport',
		'lastValidTeleportDestination',
		'lastValidTeleportDestinationNormal',
		'teleportDestinationIndicator',
		'pickedObjectConstraintActor'
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

{ #category : #defaults }
WDGFPlayerActor class >> defaultMaxTeleportDistance [
	^ 10
]

{ #category : #defaults }
WDGFPlayerActor class >> defaultMaxTeleportSlopeCosine [
	^ 60 degreeCos
]

{ #category : #'as yet unclassified' }
WDGFPlayerActor class >> defaultTeleportIndicatorRadius [
	^ 0.30
]

{ #category : #defaults }
WDGFPlayerActor class >> defaultTeleportUpVector [
	^ Vector3 y: 1
]

{ #category : #teleport }
WDGFPlayerActor >> attemptToUpdateTeleportDestination [
	| ray rayCastQueryResult teleportDestination teleportNormal slopeCosine |
	ray := cameraComponent worldRayFrom: Vector3 zeros to: (Vector3 z: -1) * self class defaultMaxTeleportDistance.
	rayCastQueryResult := self rayCast: ray forFirstActorSuchThat: [ :actor |
		actor hasSolidCollision
	].
	rayCastQueryResult ifNil: [ ^ false ].

	teleportNormal := rayCastQueryResult normal.
	teleportDestination := ray pointAtDistance: rayCastQueryResult distance.
	slopeCosine := teleportNormal dot: self class defaultTeleportUpVector.
	slopeCosine < self class defaultMaxTeleportSlopeCosine ifTrue: [ ^ false ].

	lastValidTeleportDestination := teleportDestination.
	lastValidTeleportDestinationNormal := teleportNormal.
	self updateTeleportDestinationIndicator.
	^ true
]

{ #category : #teleport }
WDGFPlayerActor >> beginTeleport [
	isPreparingTeleport := true.
	lastValidTeleportDestination := nil.
	lastValidTeleportDestinationNormal := nil.
	self attemptToUpdateTeleportDestination
]

{ #category : #teleport }
WDGFPlayerActor >> endTeleport [
	isPreparingTeleport ifFalse: [ self ].
	self attemptToUpdateTeleportDestination ifTrue: [ 
		self performTeleport
	].

	teleportDestinationIndicator destroy.
	teleportDestinationIndicator := nil.

	isPreparingTeleport := false.
	lastValidTeleportDestination := nil.
	lastValidTeleportDestinationNormal := nil.
	
]

{ #category : #initialization }
WDGFPlayerActor >> initialize [
	super initialize.
	cameraAngles := Vector3 zeros.
	isPreparingTeleport := false.
	lastValidTeleportDestination := nil.
	lastValidTeleportDestinationNormal := nil.

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
	event symbol = KeyboardKey T ifTrue: [
		self beginTeleport
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

	event symbol = KeyboardKey T ifTrue: [
		self endTeleport
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

{ #category : #teleport }
WDGFPlayerActor >> performTeleport [
	self teleportTo: lastValidTeleportDestination - self localBoundingBox bottomPoint
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
			firstObject: cameraComponent;
			secondObject: pickedObject;
			targetRelativePosition: (Vector3 z: 1.0);
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
	pickedObjectConstraintActor destroy.
	pickedObject collisionActorExclusionSet: #().

	pickedObject := nil.
	pickedObjectConstraintActor := nil.
	
]

{ #category : #'game events' }
WDGFPlayerActor >> tick: deltaSeconds [
	super tick: deltaSeconds.
	cameraAngles x: (cameraAngles x clampBetween: Float halfPi negated and: Float halfPi).
	cameraComponent orientation: (Quaternion xRotation: cameraAngles x).
	self orientation: (Quaternion yRotation: cameraAngles y).
	isPreparingTeleport ifTrue: [ self attemptToUpdateTeleportDestination ].
]

{ #category : #teleport }
WDGFPlayerActor >> updateTeleportDestinationIndicator [
	lastValidTeleportDestination ifNil: [ ^ self ].

	teleportDestinationIndicator ifNil: [
		teleportDestinationIndicator := WDGFActor new
			addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
				currentMaterial: (WDUnlitMaterial new
					alphaMode: #BLEND;
					colorFactor: ((Color fromHexString: '#D4821F') alpha: 0.3);
					yourself);
				addUVSphereWithRadius: self class defaultTeleportIndicatorRadius segments: 16 slices: 16;
				mesh));
			yourself.
		self world spawnActor: teleportDestinationIndicator
	].

	teleportDestinationIndicator position: lastValidTeleportDestination
]
