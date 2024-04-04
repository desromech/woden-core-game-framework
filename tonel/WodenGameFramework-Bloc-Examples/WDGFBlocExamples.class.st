"
I contain woden examples that use Bloc/Toplo.
"
Class {
	#name : #WDGFBlocExamples,
	#superclass : #WDGFExamples,
	#category : #'WodenGameFramework-Bloc-Examples'
}

{ #category : #examples }
WDGFBlocExamples class >> exampleRoom [
	| world screenExtent screenHalfExtent screenActor screenTexture space lastScreenPosition |
	world := WDGFWorld new.
	
	self buildSampleRoomOn: world.
	
	screenExtent := 512@256.
	screenHalfExtent := Vector3 xy: screenExtent asVector2 / 1000 z: 0.01.

	space := BlSpace new
		extent: screenExtent;
		host: (WDBlTextureHost extent: screenExtent).
	space root addChild: (ToLabel text: 'Hello world').
	space show.
	screenTexture := space host texture.

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
		addComponent: (WDGFInteractiveBlocScreenComponent boundingBoxHalfExtent: screenHalfExtent screenExtent: screenExtent);
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: screenHalfExtent);
		addComponent: (WDGFCollisionObjectComponent new);
		orientation: (Quaternion yRotation: -90 degreesToRadians);
		position: (Vector3 x: 3 y: 1 + screenHalfExtent y);
		yourself.

	world spawnActor: screenActor.

	world spawnActor: (WDGFPlayerActor new
		position: (Vector3 y: 2.0);
		yourself).

	world playInMorphic
]

{ #category : #'see class side' }
WDGFBlocExamples >> seeClassSide [
]
