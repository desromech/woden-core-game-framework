"
I hold different examples that use the Woden Game Framework.
"
Class {
	#name : #WDGFExamples,
	#superclass : #Object,
	#category : #'WodenGameFramework-Examples'
}

{ #category : #examples }
WDGFExamples class >> exampleCubeAndLightActor [
	| cubeMesh cubeActor lightSourceActor world currentTime |
	world := WDGFWorld new.

	cubeMesh := WDMeshBuilder new
		addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
		mesh.

	cubeActor := WDGFActor new.
	cubeActor addComponent: (WDGFActorStaticMeshSceneComponent with: cubeMesh).
	world spawnActor: cubeActor.
	
	currentTime := 0.
	cubeActor
		wantsToTick: true;
		onTickDo: [ :delta |
			cubeActor position: (Vector3 x: currentTime sin * 3.0).
			currentTime := currentTime + delta
		].

	lightSourceActor := WDGFActor new.
	lightSourceActor addComponent: (WDGFActorLightSourceSceneComponent with: (WDPointLightSource new
			color: (Vector3 x: 0.8 y: 0.8 z: 0.2);
			intensity: 5.0;
			influenceRadius: 4.0;
			yourself)).
	lightSourceActor position: (Vector3 x: 0 y: 1.5 z: 2).
	world spawnActor: lightSourceActor.

	world playInMorphic
]

{ #category : #examples }
WDGFExamples class >> exampleCubeAndLightActor2 [
	| cubeActor lightSourceActor world currentTime |
	world := WDGFWorld new.

	cubeActor := WDGFActor new.
	cubeActor addComponent: (WDMeshBuilder new
		addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
		mesh).
	world spawnActor: cubeActor.
	
	currentTime := 0.
	cubeActor
		wantsToTick: true;
		onTickDo: [ :delta |
			cubeActor position: (Vector3 x: currentTime sin * 3.0).
			currentTime := currentTime + delta
		].

	lightSourceActor := WDGFActor new.
	lightSourceActor addComponent: (WDPointLightSource new
			color: (Vector3 x: 0.8 y: 0.8 z: 0.2);
			intensity: 5.0;
			influenceRadius: 4.0;
			yourself).
	lightSourceActor position: (Vector3 x: 0 y: 1.5 z: 2).
	world spawnActor: lightSourceActor.

	world playInMorphic
]

{ #category : #examples }
WDGFExamples class >> exampleCubeAndLightActor3 [
	| cubeActor world currentTime |
	world := WDGFWorld new.

	cubeActor := WDGFActor new.
	cubeActor addComponent: (WDMeshBuilder new
		addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
		mesh).
	world spawnActor: cubeActor.
	
	currentTime := 0.
	cubeActor
		wantsToTick: true;
		onTickDo: [ :delta |
			cubeActor position: (Vector3 x: currentTime sin * 3.0).
			currentTime := currentTime + delta
		].

	world spawnActor: ((WDPointLightSource new
			color: (Vector3 x: 0.8 y: 0.8 z: 0.2);
			intensity: 5.0;
			influenceRadius: 4.0;
			asGameFrameworkActor)
				position: (Vector3 x: 0 y: 1.5 z: 2);
				yourself).

	world playInMorphic
]

{ #category : #'see class side' }
WDGFExamples >> seeClassSide [
]
