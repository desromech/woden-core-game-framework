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
	cubeActor addComponent: (WDGFActorMeshSceneComponent with: cubeMesh).
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
	world spawnActor: (WDGFActorTemplates staticCameraWithPosition: (Vector3 z: 3.0)).

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
	world spawnActor: (WDGFActorTemplates staticCameraWithPosition: (Vector3 z: 3.0)).

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
	world spawnActor: (WDGFActorTemplates staticCameraWithPosition: (Vector3 z: 3.0)).

	world playInMorphic
]

{ #category : #examples }
WDGFExamples class >> exampleFallingBox [
	| fallingBoxActor lightSourceActor world |
	world := WDGFWorld new.

	fallingBoxActor := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.5);
		addComponent: (WDGFRigidBodyObjectComponent mass: 1.0);
		yourself.
	world spawnActor: fallingBoxActor.
	
	lightSourceActor := WDGFActor new
		addComponent: (WDGFActorLightSourceSceneComponent with: (WDPointLightSource new
			color: (Vector3 x: 0.8 y: 0.8 z: 0.2);
			intensity: 5.0;
			influenceRadius: 4.0;
			yourself));
		position: (Vector3 x: 0 y: 1.5 z: 2);
		yourself.
	world spawnActor: lightSourceActor.

	world spawnActor: (WDGFActorTemplates staticCameraWithPosition: (Vector3 z: 3.0)).

	world playInMorphic
]

{ #category : #examples }
WDGFExamples class >> exampleFallingBoxAndFloor [
	| fallingBoxActor floorActor lightSourceActor world collisionMargin |
	world := WDGFWorld new.

	collisionMargin := 0.01.
	fallingBoxActor := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.5 - collisionMargin);
		addComponent: (WDGFRigidBodyObjectComponent mass: 1.0);
		position: (Vector3 y: 1.0);
		yourself.
	world spawnActor: fallingBoxActor.

	floorActor := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithHalfExtent: (Vector3 x: 5 y: 0.1 z: 20);
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: (Vector3 x: 5 y: 0.1 z: 20) - collisionMargin);
		addComponent: (WDGFCollisionObjectComponent new);
		position: (Vector3 y: -0.8);
		yourself.
	world spawnActor: floorActor.
	
	lightSourceActor := WDGFActor new
		addComponent: (WDGFActorLightSourceSceneComponent with: (WDPointLightSource new
			castShadows: true;
			color: (Vector3 x: 0.8 y: 0.8 z: 0.2);
			intensity: 5.0;
			influenceRadius: 4.0;
			yourself));
		position: (Vector3 x: 0 y: 1.5 z: 2);
		yourself.
	world spawnActor: lightSourceActor.

	world spawnActor: (WDGFActorTemplates staticCameraWithPosition: (Vector3 x: 0.0 y: 1.0 z: 5.0)).

	world playInMorphic
]

{ #category : #examples }
WDGFExamples class >> exampleFallingBoxStack [
	| fallingBoxActor floorActor lightSourceActor world collisionMargin fallingBoxMesh |
	world := WDGFWorld new.

	collisionMargin := 0.01.
	fallingBoxMesh := (WDMeshBuilder new
			addCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
			mesh).
			
	1 to: 10 do: [ :y |
		fallingBoxActor := WDGFActor new
			addComponent: (WDGFActorMeshSceneComponent with: fallingBoxMesh);
			addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.5 - collisionMargin);
			addComponent: (WDGFRigidBodyObjectComponent mass: 1.0);
			position: (Vector3 y: y*1.5);
			yourself.
		world spawnActor: fallingBoxActor.
	].

	floorActor := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithHalfExtent: (Vector3 x: 5 y: 0.1 z: 20);
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: (Vector3 x: 5 y: 0.1 z: 20) - collisionMargin);
		addComponent: (WDGFCollisionObjectComponent new);
		position: (Vector3 y: -0.8);
		yourself.
	world spawnActor: floorActor.
	
	lightSourceActor := WDGFActor new
		addComponent: (WDGFActorLightSourceSceneComponent with: (WDPointLightSource new
			castShadows: true;
			color: (Vector3 x: 0.8 y: 0.8 z: 0.2);
			intensity: 5.0;
			influenceRadius: 4.0;
			yourself));
		position: (Vector3 x: 0 y: 1.5 z: 2);
		yourself.
	world spawnActor: lightSourceActor.

	world spawnActor: (WDGFActorTemplates staticCameraWithPosition: (Vector3 x: 0.0 y: 1.0 z: 5.0)).

	world playInMorphic
]

{ #category : #examples }
WDGFExamples class >> exampleFpsCharacterActor [
	| lightSourceActor world |
	world := WDGFWorld new.
	
	{
		AABox min: (Vector3 x: -10 y: -0.5 z: -10) max: (Vector3 x: 10 y: 0.0 z: 10).
		AABox min: (Vector3 x: -10 y: 5.0 z: -10) max: (Vector3 x: 10 y: 5.0 z: 10).

		AABox min: (Vector3 x: -10 y: 0 z: 10) max: (Vector3 x: 10 y: 5.0 z: 10).
		AABox min: (Vector3 x: -10 y: 0 z: -10) max: (Vector3 x: 10 y: 5.0 z: -10).

		AABox min: (Vector3 x: -10 y: 0 z: -10) max: (Vector3 x: -10 y: 5.0 z: 10).
		AABox min: (Vector3 x: 10 y: 0 z: -10) max: (Vector3 x: 10 y: 5.0 z: 10).

		AABox min: (Vector3 x: -1 y: 0 z: -6) max: (Vector3 x: 1 y: 1.0 z: -5).
	} do: [ :eachBox |
		world spawnActor: (WDGFActor new
			addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
				addCubeWithHalfExtent: eachBox halfExtent;
				mesh));
			addComponent: (WDGFBoxCollisionShapeComponent halfExtent: eachBox halfExtent);
			addComponent: (WDGFCollisionObjectComponent new);
			position: eachBox center;
			yourself)
	].
	
	world spawnActor: (WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithWidth: 0.25 height: 0.25 depth: 0.25;
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.125);
		addComponent: (WDGFRigidBodyObjectComponent mass: 1.0);
		position: (Vector3 x: 0 y: 1.5 z: -3);
		yourself).
	
	lightSourceActor := WDGFActor new
		addComponent: (WDGFActorLightSourceSceneComponent with: (WDPointLightSource new
			castShadows: true;
			color: (Vector3 x: 0.8 y: 0.8 z: 0.2);
			intensity: 5.0;
			influenceRadius: 20.0;
			yourself));
		position: (Vector3 x: 0 y: 1.5 z: 0);
		yourself.
	world spawnActor: lightSourceActor.

	world spawnActor: (WDGFActorTemplates fpsCharacterActor
		position: (Vector3 y: 2.0);
		yourself).

	world playInMorphic
]

{ #category : #'see class side' }
WDGFExamples >> seeClassSide [
]
