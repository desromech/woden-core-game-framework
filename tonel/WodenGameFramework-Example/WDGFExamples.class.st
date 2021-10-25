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
	| cubeMesh cubeActor world |
	cubeMesh := WDMeshBuilder new
		addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
		mesh.

	cubeActor := WDGFActor new.
	cubeActor addComponent: (WDGFActorStaticMeshSceneComponent with: cubeMesh).

	world := WDGFWorld new.
	world spawnActor: cubeActor.

	world openInMorphic
]

{ #category : #'see class side' }
WDGFExamples >> seeClassSide [
]
