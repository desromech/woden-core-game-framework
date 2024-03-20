Class {
	#name : #WDGFPlayerVRHandComponent,
	#superclass : #WDGFVRTrackedDeviceComponent,
	#instVars : [
		'modelComponent',
		'localTransform',
		'isPreparingTeleport',
		'lastValidTeleportDestination',
		'lastValidTeleportDestinationNormal',
		'teleportDestinationIndicator'
	],
	#category : #'WodenGameFramework-Core-Actor-Character'
}

{ #category : #defaults }
WDGFPlayerVRHandComponent class >> defaultHandHalfExtent [
	^ Vector3 x: 0.04 y: 0.02 z: 0.075
]

{ #category : #defaults }
WDGFPlayerVRHandComponent class >> defaultMaxTeleportDistance [
	^ 10
]

{ #category : #defaults }
WDGFPlayerVRHandComponent class >> defaultMaxTeleportSlopeCosine [
	^ 60 degreeCos
]

{ #category : #defaults }
WDGFPlayerVRHandComponent class >> defaultTeleportIndicatorRadius [
	^ 0.30
]

{ #category : #defaults }
WDGFPlayerVRHandComponent class >> defaultTeleportUpVector [
	^ Vector3 y: 1
]

{ #category : #adding }
WDGFPlayerVRHandComponent >> addIntoPlayerActor: playerActor [
	modelComponent := WDGFActorMeshSceneComponent with: (WDMeshBuilder new
		currentMaterial: (WDMetallicRoughnessMaterial new
			baseColorFactor: (Color fromHexString: '#855b40');
			roughnessFactor: 0.6;
			metallicFactor: 0.0;
			yourself);
		addCubeWithHalfExtent: self class defaultHandHalfExtent;
		mesh).
		
	modelComponent visible: false.
	playerActor rootSceneComponent addChildSceneComponent: modelComponent.
	
	playerActor addComponent: self.
	
]

{ #category : #teleport }
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

{ #category : #teleport }
WDGFPlayerVRHandComponent >> beginPicking [
]

{ #category : #teleport }
WDGFPlayerVRHandComponent >> beginTeleport [
	isPreparingTeleport := true.
	lastValidTeleportDestination := nil.
	lastValidTeleportDestinationNormal := nil.
	self attemptToUpdateTeleportDestination
]

{ #category : #teleport }
WDGFPlayerVRHandComponent >> endPicking [
]

{ #category : #teleport }
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

{ #category : #initialization }
WDGFPlayerVRHandComponent >> initialize [
	super initialize.
	isPreparingTeleport := false.
	lastValidTeleportDestination := nil.
	lastValidTeleportDestinationNormal := nil.
]

{ #category : #hooks }
WDGFPlayerVRHandComponent >> onGotTrackedDevice [
	modelComponent visible: true.
]

{ #category : #hooks }
WDGFPlayerVRHandComponent >> onLostTrackedDevice [
	modelComponent visible: false.
]

{ #category : #hooks }
WDGFPlayerVRHandComponent >> onUpdatedTrackedDevice [
	localTransform := owner floorToLocalTransform transformTransform: deviceTransform.
	modelComponent transform: localTransform.
	isPreparingTeleport ifTrue: [ self attemptToUpdateTeleportDestination ].
	
]

{ #category : #'event handling' }
WDGFPlayerVRHandComponent >> onVRTrackedDeviceButtonPressedEvent: event [
	event isAxis0 ifTrue: [ self beginTeleport ].
	event isAxis1 ifTrue: [ self beginPicking ].
]

{ #category : #'event handling' }
WDGFPlayerVRHandComponent >> onVRTrackedDeviceButtonReleasedEvent: event [
	event isAxis0 ifTrue: [ self endTeleport ].
	event isAxis1 ifTrue: [ self endPicking ].
]

{ #category : #teleport }
WDGFPlayerVRHandComponent >> performTeleport [
	owner teleportTo: lastValidTeleportDestination - owner localBoundingBox bottomPoint
]

{ #category : #utility }
WDGFPlayerVRHandComponent >> transformPositionToWorld: position [
	^ owner transformPositionToWorld: (localTransform transformPosition: position)
	
]

{ #category : #teleport }
WDGFPlayerVRHandComponent >> updateTeleportDestinationIndicator [
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
		owner world spawnActor: teleportDestinationIndicator
	].

	teleportDestinationIndicator position: lastValidTeleportDestination
]

{ #category : #transforms }
WDGFPlayerVRHandComponent >> worldRayFrom: startingPoint to: endPoint [
	^ Ray3D from: (self transformPositionToWorld: startingPoint) to: (self transformPositionToWorld: endPoint)
]
