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
	"
	self exampleRoom
	"
	| world screenExtent screenHalfExtent screenActor screenTexture space lastScreenPosition |
	world := WDGFWorld new.
	
	self buildSampleRoomOn: world.
	
	screenExtent := 256@128.
	screenHalfExtent := Vector3 xy: screenExtent asVector2 / 1000 * 2.0 z: 0.01.

	space := BlSpace new
		extent: screenExtent;
		host: (WDBlTextureHost extent: screenExtent).
	space root addChild: (ToButton new
		label: (ToLabel text: 'Test Button');
		yourself).
	space show.
	screenTexture := space host texture.

	lastScreenPosition := 0@0.
	screenActor := WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			currentMaterial: (WDUnlitMaterial new
				doubleSided: true;
				colorTexture: screenTexture;
				yourself);
			addScreenQuad: screenHalfExtent;
			generateTexcoords0ForScreenProjection;
			mesh));
		addComponent: (WDGFInteractiveBlocScreenComponent boundingBoxHalfExtent: screenHalfExtent space: space);
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
