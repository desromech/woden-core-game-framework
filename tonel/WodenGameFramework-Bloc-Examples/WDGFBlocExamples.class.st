"
I contain woden examples that use Bloc/Toplo.
"
Class {
	#name : 'WDGFBlocExamples',
	#superclass : 'WDGFExamples',
	#category : 'WodenGameFramework-Bloc-Examples',
	#package : 'WodenGameFramework-Bloc-Examples'
}

{ #category : 'utility' }
WDGFBlocExamples class >> buildBlocScreenActorWithExtent: screenExtent physicalExtent: physicalExtent spaceWith: spaceBuildBlock [
	| space screenTexture |
	space := BlSpace new
		extent: screenExtent;
		host: (WDBlTextureHost extent: screenExtent).
	spaceBuildBlock value: space.
	space show.
	screenTexture := space host texture.

	^ WDGFActor new
		addComponent: (WDGFActorMeshSceneComponent with: (WDMeshBuilder new
			currentMaterial: (WDUnlitMaterial new
				doubleSided: true;
				colorTexture: screenTexture;
				yourself);
			addScreenQuad: physicalExtent;
			generateTexcoords0ForScreenProjection;
			mesh));
		addComponent: (WDGFInteractiveBlocScreenComponent boundingBoxHalfExtent: physicalExtent space: space);
		addComponent: (WDGFBoxCollisionShapeComponent halfExtent: physicalExtent);
		addComponent: (WDGFCollisionObjectComponent new);
		yourself.

]

{ #category : 'utility' }
WDGFBlocExamples class >> buildBlocScreenActorWithExtent: screenExtent physicalScaleFactor: physicalScaleFactor spaceWith: spaceBuildBlock [
	^ self buildBlocScreenActorWithExtent: screenExtent physicalExtent: (Vector3 xy: screenExtent * physicalScaleFactor z: 0.05) spaceWith: spaceBuildBlock
]

{ #category : 'utility' }
WDGFBlocExamples class >> buildBlocScreenActorWithExtent: screenExtent spaceWith: spaceBuildBlock [
	^ self buildBlocScreenActorWithExtent: screenExtent physicalScaleFactor: 2.0 / 1000 spaceWith: spaceBuildBlock
]

{ #category : 'examples' }
WDGFBlocExamples class >> exampleRoom [
	"
	self exampleRoom
	"
	| world screenExtent lightSource menuOverlay hudOverlay |
	world := WDGFWorld new.
	
	lightSource := self buildSampleRoomOn: world.
	screenExtent := 256@128.
	
	menuOverlay := WDGFBlOverlay withExtent: 256@256 buildSpace: [:overlaySpace |
		overlaySpace root addChild: (ToButton new
			label: (ToLabel text: 'Test Menu');
			whenClickedDo: [ lightSource visible: lightSource visible not ];
			yourself)
	].
	menuOverlay centeringFraction: (1/10)@(1/10).
	world menuSubsystem overlay: menuOverlay.

	world spawnActor: ((self buildBlocScreenActorWithExtent: 256@128 spaceWith: [:space |
			space root addChild: (ToButton new
			label: (ToLabel text: 'Toggle Lights');
			whenClickedDo: [ lightSource visible: lightSource visible not ];
			yourself).
		])
		orientation: (Quaternion yRotation: -90 degreesToRadians);
		positionOnTopOf: (Vector3 x: 3 y: 1);
		yourself).

	hudOverlay := WDGFBlOverlay withExtent: 64@32 buildSpace: [:overlaySpace |
		| label count anim |
		label := ToLabel new.
		count := 0.
		anim := BlRepeatedTaskAction new
				delay: 1 second;
				action: [
					label text: (count asString asRopedText
								fontSize: 20;
								foreground: Color gray).
					count := count + 1
				].
		label enqueueTask: anim.

		overlaySpace root
			background: Color transparent;
			addChild: label
	].
	hudOverlay centeringFraction: (9/10)@(9/10).

	world spawnActor: (WDGFPlayerActor new
		addHUDOverlay: hudOverlay;
		position: (Vector3 y: 2.0);
		yourself).

	world playInWindow
]

{ #category : 'see class side' }
WDGFBlocExamples >> seeClassSide [
]
