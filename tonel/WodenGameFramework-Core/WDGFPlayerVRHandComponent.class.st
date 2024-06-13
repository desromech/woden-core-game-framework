Class {
	#name : 'WDGFPlayerVRHandComponent',
	#superclass : 'WDGFVRTrackedDeviceComponent',
	#instVars : [
		'modelComponent',
		'localTransform',
		'isPreparingTeleport',
		'lastValidTeleportDestination',
		'lastValidTeleportDestinationNormal',
		'teleportDestinationIndicator',
		'pickedObject',
		'pickedObjectConstraintActor',
		'fallbackModel',
		'pointerModelComponent',
		'hand3DPointer'
	],
	#category : 'WodenGameFramework-Core-Actor-Character',
	#package : 'WodenGameFramework-Core',
	#tag : 'Actor-Character'
}

{ #category : 'defaults' }
WDGFPlayerVRHandComponent class >> defaultHandHalfExtent [
	^ Vector3 x: 0.04 y: 0.02 z: 0.075
]

{ #category : 'defaults' }
WDGFPlayerVRHandComponent class >> defaultMaxTeleportDistance [
	^ 10
]

{ #category : 'defaults' }
WDGFPlayerVRHandComponent class >> defaultMaxTeleportSlopeCosine [
	^ 60 degreeCos
]

{ #category : 'defaults' }
WDGFPlayerVRHandComponent class >> defaultPointerMaxDistance [
	^ 3.0
]

{ #category : 'defaults' }
WDGFPlayerVRHandComponent class >> defaultTeleportIndicatorRadius [
	^ 0.30
]

{ #category : 'defaults' }
WDGFPlayerVRHandComponent class >> defaultTeleportUpVector [
	^ Vector3 y: 1
]

{ #category : 'adding' }
WDGFPlayerVRHandComponent >> addIntoPlayerActor: playerActor [
	| pointerRadius |
	modelComponent := WDGFActorMeshSceneComponent with: self fallbackModel.
	pointerRadius := 0.005.
	pointerModelComponent := WDGFActorMeshSceneComponent with: (WDMeshBuilder new
		currentMaterial: (WDUnlitMaterial new
			withAlphaBlending;
			colorFactor: (Vector4 x: 1.0 y: 0.4 z: 0.2 w: 0.4);
			yourself);
		addCubeMinX: pointerRadius negated y: pointerRadius negated z: self class defaultPointerMaxDistance negated
			maxX: pointerRadius y: pointerRadius z: 0.0;
		mesh).
	modelComponent addChildSceneComponent: pointerModelComponent.
		
	modelComponent visible: false.
	pointerModelComponent visible: false.
	playerActor rootSceneComponent addChildSceneComponent: modelComponent.
	
	playerActor addComponent: self.
	
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> angularVelocity [
	^ owner angularVelocity + (owner transformVectorToWorld: (owner floorToLocalTransform transformVector3: deviceAngularVelocity))
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> attemptToUpdatePointerAction [
	| ray worldPoint |
	pointerModelComponent visible: self hasActivePointer.
	worldPoint := self transformPositionToWorld: Vector3 zeros.
	
	ray := self worldRayFrom: Vector3 zeros to: (Vector3 z: -1) * self class defaultPointerMaxDistance.
			
	hand3DPointer updatePointerActionWithWorldRay: ray touchMask: self currentPointerButtonTouchMask pressedMask: self currentPointerButtonPressedMask
]

{ #category : 'teleport' }
WDGFPlayerVRHandComponent >> attemptToUpdateTeleportDestination [
	| ray rayCastQueryResult teleportDestination teleportNormal slopeCosine |
	ray := self worldRayFrom: Vector3 zeros to: (Vector3 z: -1) * self class defaultMaxTeleportDistance.
	rayCastQueryResult := owner rayCast: ray forFirstActorSuchThat: [ :actor |
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

{ #category : 'teleport' }
WDGFPlayerVRHandComponent >> beginPicking [
	| pickBox pickableActors |
	pickBox := AABox halfExtent: self class defaultHandHalfExtent.
	pickableActors := owner findActorsIntersectingBox: pickBox transform: self worldTransform suchThat: [ :actor |
		actor hasRigidBody and: [ actor mass <= owner class defaultMaxPickableWeight ]
	].
	pickableActors ifEmpty: [ ^ self ].
	
	pickedObject := pickableActors first.
	pickedObjectConstraintActor := WDGFActor new
		addComponent: (WDGFPhysicsHoldObjectConstraintComponent new
			stiffness: 100.0;
			damping: 10.0;
			firstObject: self;
			secondObject: pickedObject;
			targetRelativePosition: (self transformWorldPositionToLocal: pickedObject position);
			targetRelativeOrientation: (self transformWorldOrientationToLocal: pickedObject orientation);
			yourself);
		yourself.
	pickedObject collisionActorExclusionSet: { owner }.
	ownerWorld spawnActor: pickedObjectConstraintActor
]

{ #category : 'teleport' }
WDGFPlayerVRHandComponent >> beginTeleport [
	isPreparingTeleport := true.
	lastValidTeleportDestination := nil.
	lastValidTeleportDestinationNormal := nil.
	self attemptToUpdateTeleportDestination
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> currentPointerButtonPressedMask [
	^ (analogButtonPressedState anyMask: AnalogFirstTriggerPressed) ifTrue: [ 1 ] ifFalse: [ 0 ]
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> currentPointerButtonTouchMask [
	^ (analogButtonTouchedState anyMask: AnalogFirstTriggerPressed) ifTrue: [ 1 ] ifFalse: [ 0 ]
]

{ #category : 'teleport' }
WDGFPlayerVRHandComponent >> endPicking [
	pickedObjectConstraintActor ifNotNil: [ 
		pickedObjectConstraintActor destroy.
		pickedObjectConstraintActor := nil.
	].

	pickedObject ifNil: [ ^ self ].
	
	pickedObject
		collisionActorExclusionSet: #();
		linearVelocity: self throwLinearVelocity;
		angularVelocity: self throwAngularVelocity.
	pickedObject := nil.

]

{ #category : 'teleport' }
WDGFPlayerVRHandComponent >> endTeleport [
	isPreparingTeleport ifFalse: [ self ].
	self attemptToUpdateTeleportDestination ifTrue: [ 
		self performTeleport
	].

	teleportDestinationIndicator ifNotNil: [
		teleportDestinationIndicator destroy.
		teleportDestinationIndicator := nil.
	].

	isPreparingTeleport := false.
	lastValidTeleportDestination := nil.
	lastValidTeleportDestinationNormal := nil.
	
]

{ #category : 'adding' }
WDGFPlayerVRHandComponent >> fallbackModel [
	^ fallbackModel ifNil: [WDMeshBuilder new
		currentMaterial: (WDMetallicRoughnessMaterial new
			baseColorFactor: (Color fromHexString: '#855b40');
			roughnessFactor: 0.6;
			metallicFactor: 0.0;
			yourself);
		addCubeWithHalfExtent: self class defaultHandHalfExtent;
		mesh
	]
]

{ #category : 'testing' }
WDGFPlayerVRHandComponent >> hasActivePointer [
	^ pickedObject isNil and: [ self currentPointerButtonTouchMask ~= 0]
]

{ #category : 'initialization' }
WDGFPlayerVRHandComponent >> initialize [
	super initialize.
	localTransform := TRSTransform3D identity.
	isPreparingTeleport := false.
	lastValidTeleportDestination := nil.
	lastValidTeleportDestinationNormal := nil.
	hand3DPointer := WDGF3DPointerDevice for: self.
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> linearVelocity [
	^ owner linearVelocity + (owner transformVectorToWorld: (owner floorToLocalTransform transformVector3: deviceLinearVelocity))
]

{ #category : 'hooks' }
WDGFPlayerVRHandComponent >> onGotTrackedDevice [
	localTransform := (owner floorToLocalTransform transformTransform: deviceTransform) asTRSTransform3D.
	modelComponent visible: true.
	self attemptToUpdatePointerAction.
]

{ #category : 'hooks' }
WDGFPlayerVRHandComponent >> onLostTrackedDevice [
	modelComponent visible: false.
	self attemptToUpdatePointerAction.
]

{ #category : 'hooks' }
WDGFPlayerVRHandComponent >> onUpdatedTrackedDevice [
	localTransform := (owner floorToLocalTransform transformTransform: deviceTransform) asTRSTransform3D.
	modelComponent
		transform: localTransform;
		mesh: (device renderModel ifNil: [self fallbackModel]).
	isPreparingTeleport ifTrue: [ self attemptToUpdateTeleportDestination ].
	self attemptToUpdatePointerAction.
]

{ #category : 'event handling' }
WDGFPlayerVRHandComponent >> onVRTrackedDeviceAnalogButtonPressed: mask [
	(mask anyMask: AnalogJoystickButtonUp) ifTrue: [ self beginTeleport ].
	(mask anyMask: AnalogFirstTriggerPressed) ifTrue: [ 
		self beginPicking
	].

]

{ #category : 'event handling' }
WDGFPlayerVRHandComponent >> onVRTrackedDeviceAnalogButtonReleased: mask [
	(mask anyMask: AnalogJoystickButtonUp) ifTrue: [ self endTeleport ].
	(mask anyMask: AnalogFirstTriggerPressed) ifTrue: [
		self endPicking
	].
	
]

{ #category : 'teleport' }
WDGFPlayerVRHandComponent >> performTeleport [
	owner teleportTo: lastValidTeleportDestination - owner localBoundingBox bottomPoint
]

{ #category : 'utility' }
WDGFPlayerVRHandComponent >> rayCast: ray forFirstActorSuchThat: aPredictate [
	^ owner rayCast: ray forFirstActorSuchThat: aPredictate
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> throwAngularVelocity [
	^ self angularVelocity
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> throwLinearVelocity [
	^ owner linearVelocity + ((owner transformVectorToWorld: (owner floorToLocalTransform transformVector3: deviceLinearVelocity)) * self throwSpeedFactor)
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> throwSpeedFactor [
	^ 1.0
]

{ #category : 'utility' }
WDGFPlayerVRHandComponent >> transformNormalVectorToWorld: vector [
	^ owner transformNormalVectorToWorld: (localTransform transformNormalVector: vector)
	
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> transformOrientationToWorld: orientation [
	^ owner transformOrientationToWorld: localTransform rotation * orientation
]

{ #category : 'utility' }
WDGFPlayerVRHandComponent >> transformPositionToWorld: position [
	^ owner transformPositionToWorld: (localTransform transformPosition: position)
	
]

{ #category : 'utility' }
WDGFPlayerVRHandComponent >> transformVectorToWorld: vector [
	^ owner transformVectorToWorld: (localTransform transformVector3: vector)
	
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> transformWorldOrientationToLocal: orientation [
	^ localTransform inverseRotation * (owner transformWorldOrientationToLocal: orientation)
]

{ #category : 'utility' }
WDGFPlayerVRHandComponent >> transformWorldPositionToLocal: position [
	^ localTransform inverseTransformPosition: (owner transformWorldPositionToLocal: position)
	
]

{ #category : 'teleport' }
WDGFPlayerVRHandComponent >> updateTeleportDestinationIndicator [
	lastValidTeleportDestination ifNil: [ ^ self ].

	teleportDestinationIndicator ifNil: [
		teleportDestinationIndicator := WDGFActor new
			addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
				currentMaterial: (WDUnlitMaterial new
					withAlphaBlending;
					colorFactor: ((Color fromHexString: '#D4821F') alpha: 0.3);
					yourself);
				addUVSphereWithRadius: self class defaultTeleportIndicatorRadius segments: 16 slices: 16;
				mesh));
			yourself.
		ownerWorld spawnActor: teleportDestinationIndicator
	].

	teleportDestinationIndicator position: lastValidTeleportDestination
]

{ #category : 'transforms' }
WDGFPlayerVRHandComponent >> worldRayFrom: startingPoint to: endPoint [
	^ Ray3D from: (self transformPositionToWorld: startingPoint) to: (self transformPositionToWorld: endPoint)
]

{ #category : 'as yet unclassified' }
WDGFPlayerVRHandComponent >> worldTransform [
	^ owner transform transformTransform: localTransform 
]
