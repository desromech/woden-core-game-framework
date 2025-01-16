"
I hold different examples that use the Woden Game Framework.
"
Class {
	#name : 'WDGFExamples',
	#superclass : 'Object',
	#category : 'WodenGameFramework-Examples',
	#package : 'WodenGameFramework-Examples'
}

{ #category : 'sample common' }
WDGFExamples class >> buildSampleRoomOn: world [
	| floorMaterial ceilingMaterial wallMaterial lightSourceActor |
	floorMaterial := WDMetallicRoughnessMaterial new
		baseColorTexture: WDSceneExamples checkboardTexture;
		normalTexture: WDSceneExamples checkboardNormalTexture;
		roughnessFactor: 0.4;
		metallicFactor: 0.0;
		yourself.

	ceilingMaterial := WDMetallicRoughnessMaterial new
		baseColorFactor: Color veryDarkGray;
		roughnessFactor: 0.8;
		metallicFactor: 0.0;
		yourself.
		
	wallMaterial := WDMetallicRoughnessMaterial new
		baseColorFactor: 0.8;
		roughnessFactor: 0.8;
		metallicFactor: 0.0;
		yourself.

	{
		AABox min: (Vector3 x: -10 y: -0.5 z: -10) max: (Vector3 x: 10 y: 0.0 z: 10) . floorMaterial.
		AABox min: (Vector3 x: -10 y: 5.0 z: -10) max: (Vector3 x: 10 y: 5.0 z: 10) . ceilingMaterial.

		AABox min: (Vector3 x: -10 y: 0 z: 10) max: (Vector3 x: 10 y: 5.0 z: 10). wallMaterial.
		AABox min: (Vector3 x: -10 y: 0 z: -10) max: (Vector3 x: 10 y: 5.0 z: -10). wallMaterial.

		AABox min: (Vector3 x: -10 y: 0 z: -10) max: (Vector3 x: -10 y: 5.0 z: 10). wallMaterial.
		AABox min: (Vector3 x: 10 y: 0 z: -10) max: (Vector3 x: 10 y: 5.0 z: 10). wallMaterial.

		AABox min: (Vector3 x: -1 y: 0 z: -6) max: (Vector3 x: 1 y: 1.0 z: -5). wallMaterial.
	} pairsDo: [ :eachBox :eachMaterial |
		world spawnActor: (WDGFActor new
			addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
				currentMaterial: eachMaterial;
				addCubeWithHalfExtent: eachBox halfExtent;
				generateTexcoords0WithFacePlanarTransformWithScale: (Vector2 withAll: 0.5);
				generateTangentSpaceFrame;
				mesh));
			addComponent: (WDGFBoxCollisionShapeComponent halfExtent: eachBox halfExtent);
			addComponent: (WDGFCollisionObjectComponent new);
			position: eachBox center;
			yourself)
	].
	
	{
		(Vector3 x: -1 y: 0.5 z: -3).
		(Vector3 x: 0 y: 0.5 z: -3).
		(Vector3 x: 1 y: 0.5 z: -3).
	} do: [ :eachPosition |
		world spawnActor: (WDGFActor new
			addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
				addCubeWithHalfExtent: 0.150;
				mesh));
			addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.150);
			addComponent: (WDGFRigidBodyObjectComponent mass: 1.0);
			position: eachPosition;
			yourself).
	].
	
	lightSourceActor := WDGFActor new
		addComponent: (WDGFActorLightSourceSceneComponent with: (WDPointLightSource new
			castShadows: true;
			color: (Vector3 x: 0.8 y: 0.8 z: 0.5) normalized;
			intensity: 10.0;
			influenceRadius: 20.0;
			yourself));
		position: (Vector3 x: 0 y: 1.5 z: 0);
		yourself.
	world spawnActor: lightSourceActor.
	^ lightSourceActor
]

{ #category : 'examples' }
WDGFExamples class >> exampleCubeAndLightActor [
	"
	self exampleCubeAndLightActor
	"
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

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleCubeAndLightActor2 [
	"
	self exampleCubeAndLightActor2
	"
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

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleCubeAndLightActor3 [
	"
	self exampleCubeAndLightActor3
	"
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

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleFallingBox [
	"
	self exampleFallingBox
	"
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

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleFallingBoxAndFloor [
	"
	self exampleFallingBoxAndFloor
	"
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

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleFallingBoxStack [
	"
	self exampleFallingBoxStack
	"
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

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleRoom [
	"
	self exampleFallingBoxStack
	"
	| world screenExtent screenHalfExtent screenActor screenForm screenTexture lastScreenPosition |
	world := WDGFWorld new.
	
	self buildSampleRoomOn: world.
	
	screenExtent := 1024@512.
	screenForm := Form extent: screenExtent depth: 32.
	screenForm fillColor: Color black.
	screenTexture := WDTexture forColorForm: screenForm.
	screenHalfExtent := Vector3 xy: screenExtent asVector2 / 1000 z: 0.01.
	lastScreenPosition := 0@0.
	screenActor := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			currentMaterial: (WDMetallicRoughnessMaterial new
				doubleSided: true;
				baseColorFactor: 0.05;
				emissiveTexture: screenTexture;
				emissiveFactor: 1.0;
				metallicFactor: 0.0;
				roughnessFactor: 0.8;
				yourself);
			addScreenQuad: screenHalfExtent;
			generateTexcoords0ForScreenProjection;
			mesh));
		addComponent: (WDGFInteractiveScreenTextureComponent boundingBoxHalfExtent: screenHalfExtent texture: screenTexture);
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: screenHalfExtent);
		addComponent: (WDGFCollisionObjectComponent new);
		addComponent: (WDGFSoundSampleSourceComponent sample: (WDSoundSample generateNoiseWithDuration: 0.5 withRate: 44100 amplitude: 1.0 seed: 1 lowPassCutoff: 50.0) gain: 0.15 pitch: 1.0 looped: true);
		orientation: (Quaternion yRotation: -90 degreesToRadians);
		position: (Vector3 x: 3 y: 1 + screenHalfExtent y);
		onMouseMoveEventDo: [ :event |
			event buttons leftButton ifTrue: [
				(FormCanvas on: screenForm)
					line: lastScreenPosition to: event position color: Color magenta.
				screenTexture changed
			].

			lastScreenPosition := event position.
		];
		yourself.

	world spawnActor: screenActor.

	world spawnActor: (WDGFPlayerActor new
		position: (Vector3 y: 2.0);
		yourself).

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleRoomWithFilm [
	"
	self exampleRoomWithFilm
	"
	| world screenExtent screenHalfExtent screenActor videoPlayer |
	world := WDGFWorld new.
	
	self buildSampleRoomOn: world.
	
	videoPlayer := WDVideoPlayer new
		openWithUrl: 'bbb_sunflower_1080p_60fps_normal.mp4';
		yourself.
		
	screenExtent := 1920@1080.
	screenHalfExtent := Vector3 xy: screenExtent asVector2 / 1000 z: 0.01.
	screenActor := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			currentMaterial: (WDMetallicRoughnessMaterial new
				doubleSided: true;
				baseColorFactor: 0.05;
				emissiveTexture: videoPlayer playbackTexture;
				emissiveFactor: 1.0;
				metallicFactor: 0.0;
				roughnessFactor: 0.8;
				yourself);
			addScreenQuad: screenHalfExtent;
			generateTexcoords0ForScreenProjection;
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: screenHalfExtent);
		addComponent: (WDGFCollisionObjectComponent new);
		orientation: (Quaternion yRotation: -90 degreesToRadians);
		position: (Vector3 x: 3 y: 1 + screenHalfExtent y);
		yourself.

	world spawnActor: screenActor.

	world spawnActor: (WDGFPlayerActor new
		position: (Vector3 y: 2.0);
		yourself).

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleSuspendedBoxWithRod [
	"
	self exampleSuspendedBoxWithRod
	"
	| suspendedBox anchorBox lightSourceActor world constraintActor |
	world := WDGFWorld new.

	suspendedBox := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithHalfExtent: 0.5;
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.5);
		addComponent: (WDGFRigidBodyObjectComponent mass: 1.0);
		position: (Vector3 x: 1.0 y: 1.0);
		yourself.
	world spawnActor: suspendedBox.

	anchorBox := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithHalfExtent: 0.1;
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.5);
		addComponent: (WDGFCollisionObjectComponent new);
		position: (Vector3 y: 1.0);
		yourself.
	world spawnActor: anchorBox.

	constraintActor := WDGFActor new
		addComponent: (WDGFPhysicsRodConstraintComponent new
			firstObject: anchorBox;
			secondObject: suspendedBox;
			secondObjectLocalAnchorPoint: (Vector3 x: -0.5);
			yourself);
		yourself.
	world spawnActor: constraintActor.

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

	world playInWindow
]

{ #category : 'examples' }
WDGFExamples class >> exampleSuspendedBoxWithRope [
	"
	self exampleSuspendedBoxWithRod
	"
	| suspendedBox anchorBox lightSourceActor world constraintActor |
	world := WDGFWorld new.

	suspendedBox := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithHalfExtent: 0.5;
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.5);
		addComponent: (WDGFRigidBodyObjectComponent mass: 1.0);
		position: (Vector3 x: 1.0 y: 1.0);
		yourself.
	world spawnActor: suspendedBox.

	anchorBox := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			addCubeWithHalfExtent: 0.1;
			mesh));
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: 0.5);
		addComponent: (WDGFCollisionObjectComponent new);
		position: (Vector3 y: 1.0);
		yourself.
	world spawnActor: anchorBox.

	constraintActor := WDGFActor new
		addComponent: (WDGFPhysicsRopeConstraintComponent new
			firstObject: anchorBox;
			secondObject: suspendedBox;
			secondObjectLocalAnchorPoint: (Vector3 x: -0.5);
			yourself);
		yourself.
	world spawnActor: constraintActor.

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

	world playInWindow
]

{ #category : 'see class side' }
WDGFExamples >> seeClassSide [
]
