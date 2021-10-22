"
A WDGFActorTest is a test class for testing the behavior of WDGFActor
"
Class {
	#name : #WDGFActorTest,
	#superclass : #TestCase,
	#category : #'WodenGameFramework-Core-Tests'
}

{ #category : #tests }
WDGFActorTest >> testAddMeshComponent [
	| cubeMesh cubeActor |
	cubeMesh := WDMeshBuilder new
		addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
		mesh.

	cubeActor := WDGFActor new.
	cubeActor addComponent: (WDGFActorStaticMeshSceneComponent with: cubeMesh).
]

{ #category : #tests }
WDGFActorTest >> testAddSceneComponent [
	| sceneComponent actor |
	sceneComponent := WDGFActorSceneComponent new.

	actor := WDGFActor new.
	actor addComponent: sceneComponent.
	self assert: sceneComponent owner equals: actor.
		
	self assert: (actor components includes: sceneComponent).
	self assert: actor rootSceneComponent equals: sceneComponent
]

{ #category : #tests }
WDGFActorTest >> testChangeOrientation [
	| actor newOrientation |
	actor := WDGFActor new.
	actor addComponent: WDGFActorSceneComponent new.

	newOrientation := Quaternion x: 1 y: 2 z: 3 w: 4.
	actor scale: newOrientation.
	self assert: actor scale equals: newOrientation.
]

{ #category : #tests }
WDGFActorTest >> testChangePosition [
	| actor newPosition |
	actor := WDGFActor new.
	actor addComponent: WDGFActorSceneComponent new.

	newPosition := Vector3 x: 1 y: 2 z: 3.
	actor position: newPosition.
	self assert: actor position equals: newPosition.
]

{ #category : #tests }
WDGFActorTest >> testChangeScale [
	| actor newScale |
	actor := WDGFActor new.
	actor addComponent: WDGFActorSceneComponent new.

	newScale := Vector3 x: 1 y: 2 z: 3.
	actor scale: newScale.
	self assert: actor scale equals: newScale.
]

{ #category : #tests }
WDGFActorTest >> testChangeTransform [
	| actor newTransform |
	actor := WDGFActor new.
	actor addComponent: WDGFActorSceneComponent new.

	newTransform := TRSTransform3D new
		scale: (Vector3 x: 1 y: 2 z: 3);
		rotation: (Quaternion x: 1 y: 2 z: 3 w: 4);
		translation: (Vector3 x: 1 y: 2 z: 3);
		yourself.
	actor transform: newTransform.
	self assert: actor transform equals: newTransform.
]

{ #category : #tests }
WDGFActorTest >> testDummyTransform [
	| actor |
	actor := WDGFActor new.

	actor transform: (TRSTransform3D new
		scale: (Vector3 x: 1 y: 2 z: 3);
		rotation: (Quaternion x: 1 y: 2 z: 3 w: 4);
		translation: (Vector3 x: 1 y: 2 z: 3);
		yourself).
	self assert: actor transform isIdentity.

	actor scale: (Vector3 x: 1 y: 2 z: 3).
	self assert: actor scale isOnes.

	actor	orientation: (Quaternion x: 1 y: 2 z: 3 w: 4).
	self assert: actor orientation isIdentity.

	actor position: (Vector3 x: 1 y: 2 z: 3).
	self assert: actor position isZeros.
]

{ #category : #tests }
WDGFActorTest >> testNew [
	| actor |
	actor := WDGFActor new.
	self assert: actor handle isNotNil.
	self assert: actor handle actor equals: actor.
	self assert: actor world isNil.
]

{ #category : #tests }
WDGFActorTest >> testOnMessageDo [
	| actor gotMessage |
	actor := WDGFActor new.
	gotMessage := false.
	actor onMessage: #testMessage do: [ gotMessage := true ].
	self deny: gotMessage.
	actor processMessage: #testMessage withArguments: #().
	self assert: gotMessage
]

{ #category : #tests }
WDGFActorTest >> testZeroTransform [
	| actor |
	actor := WDGFActor new.
	self assert: actor transform isIdentity.
	self assert: actor scale isOnes.
	self assert: actor orientation isIdentity.
	self assert: actor position isZeros.
]
