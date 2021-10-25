"
I hold different examples that use the Woden Game Framework.
"
Class {
	#name : #WDGFExamples,
	#superclass : #Object,
	#category : #'WodenGameFramework-Example'
}

{ #category : #examples }
WDGFExamples class >> exampleCubeActor [
	| cubeMesh cubeActor world currentTime |
	cubeMesh := WDMeshBuilder new
		addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
		mesh.

	cubeActor := WDGFActor new.
	cubeActor addComponent: (WDGFActorStaticMeshSceneComponent with: cubeMesh).
	
	currentTime := 0.
	cubeActor
		wantsToTick: true;
		onTickDo: [ :delta |
			cubeActor position: (Vector3 x: currentTime sin * 3.0).
			currentTime := currentTime + delta
		].

	world := WDGFWorld new.
	world spawnActor: cubeActor.

	world playInMorphic
]

{ #category : #'see class side' }
WDGFExamples >> seeClassSide [
]
