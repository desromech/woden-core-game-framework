"
I am an utility used for loading a game framework world from a serialized level from the editor.
"
Class {
	#name : #WDGFWorldLoader,
	#superclass : #Object,
	#instVars : [
		'world',
		'materials'
	],
	#category : #'WodenGameFramework-Core-Serialization'
}

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor bspBrushFrom: bspBrushDesc [
	| transform meshBuilder |
	transform := TRSTransform3D identity.
	(bspBrushDesc at: 'transform' ifAbsent: [ nil ]) ifNotNil: [ :transformDesc |
		transform := TRSTransform3D loadFromJson: transformDesc
	].
	
	meshBuilder := WDMeshBuilder new.
	
	(bspBrushDesc at: 'faces' ifAbsent: [ nil ]) ifNotNil: [ :faces |
		faces do: [ :eachFace |
			self loadBSPBrushFace: eachFace into: meshBuilder
		]
	].

	meshBuilder isEmpty ifFalse: [
		meshBuilder generateTangentSpaceFrame.
		actor addComponent: ((WDGFActorMeshSceneComponent with: meshBuilder mesh)
			transform: transform;
			yourself)
	].

	(bspBrushDesc at: 'vertices' ifAbsent: [ nil ]) ifNotNil: [ :verticesData |
		| convexHullPoints |
		convexHullPoints := (0 to: verticesData size // 3 - 1) collect: [:vi |
			transform transformPosition: (
				Vector3 x: (verticesData at: vi*3 + 1) y: (verticesData at: vi*3 + 2) z: (verticesData at: vi*3 + 3)
			)
		].
		actor addComponent: (WDGFConvexHullCollisionShapeComponent withPoints: convexHullPoints)
	].
]

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor childFrom: childDesc [
	| childType |
	childType := (childDesc at: '__type__' ifAbsent: [ nil ]).
	childType ifNil: [ ^ self ].
	
	childType = 'BSPBrush' ifTrue: [ ^ self loadActor: actor bspBrushFrom: childDesc ].
	childType = 'ModelReference' ifTrue: [ ^ self loadActor: actor modelReferenceFrom: childDesc ].
	childType = 'PointLightSource' ifTrue: [ ^ self loadActor: actor pointLightSourceFrom: childDesc ].
	childType = 'SpotLightSource' ifTrue: [ ^ self loadActor: actor spotLightSourceFrom: childDesc ].
	childType = 'DirectionalLightSource' ifTrue: [ ^ self loadActor: actor directionalLightSourceFrom: childDesc ].
	self error: 'Unsupport actor child with type ' -- childType
]

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor childrenFrom: childrenDesc [
	childrenDesc do: [ :eachChild |
		self loadActor: actor childFrom: eachChild
	]
]

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor directionalLightSourceFrom: lightSourceDesc [
	| lightSource color intensity transform |
	transform := TRSTransform3D identity.
	lightSource := WDDirectionalLightSource new.
	color := Vector3 ones.
	(lightSourceDesc at: 'color' ifAbsent: [nil]) ifNotNil: [ :colorDesc |
		color := Vector3 loadFromJson: colorDesc
	].
	intensity := (lightSourceDesc at: 'intensity' ifAbsent: [nil]) ifNil: [ 1.0 ].
	
	lightSource
		castShadows: ((lightSourceDesc at: 'castShadows' ifAbsent: [nil]) ifNil: [ lightSource castShadows ]);
		intensity: color * intensity.
	
	(lightSourceDesc at: 'transform' ifAbsent: [nil]) ifNotNil: [ :transformDesc |
		transform := TRSTransform3D loadFromJson: transformDesc
	].
	
	actor addComponent: ((WDGFActorLightSourceSceneComponent with: lightSource)
		transform: transform;
		yourself)
]

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor from: actorDescription [
	actor name: ((actorDescription at: 'name' ifAbsent: [ nil ]) ifNil: [ '' ]).
	(actorDescription at: 'transform' ifAbsent: [ nil ]) ifNotNil: [ :transformDesc |
		actor transform: (TRSTransform3D loadFromJson: transformDesc)
	].
	(actorDescription at: 'children' ifAbsent: [ nil ]) ifNotNil: [ :childrenDesc |
		self loadActor: actor childrenFrom: childrenDesc
	].

]

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor modelReferenceFrom: modelReferenceDesc [
	| transform modelPath modelAsset hasCollisions elementName collisionElementName |
	transform := TRSTransform3D identity.
	(modelReferenceDesc at: 'transform' ifAbsent: [ nil ]) ifNotNil: [ :transformDesc |
		transform := TRSTransform3D loadFromJson: transformDesc
	].
	modelPath := (modelReferenceDesc at: 'path' ifAbsent: [ nil ]) ifNil: [''].
	elementName := (modelReferenceDesc at: 'elementName' ifAbsent: [ nil ]) ifNil: [''].
	hasCollisions := (modelReferenceDesc at: 'hasCollisions' ifAbsent: [ nil ]) ifNil: [false].
	collisionElementName := (modelReferenceDesc at: 'collisionElementName' ifAbsent: [ nil ]) ifNil: [''].

	modelAsset := world applicationSettings loadModelWithPath: modelPath.
	modelAsset ifNil: [ ^ self ].
	
	actor addComponent: (WDGFActorModelAssetSceneComponent new
		modelAsset: modelAsset;
		elementName: elementName;
		transform: transform;
		yourself).
	
	hasCollisions ifTrue: [
		(modelAsset getCollisionShapeNamed: collisionElementName) ifNotNil: [ :collisionShape |
			| transformedCollisionShape |
			transformedCollisionShape := collisionShape transformedWith: transform.
			actor addComponent: (WDGFCollisionShapeComponent with: transformedCollisionShape)
		]
	].

]

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor pointLightSourceFrom: lightSourceDesc [
	| lightSource color intensity transform |
	transform := TRSTransform3D identity.
	lightSource := WDPointLightSource new.
	color := Vector3 ones.
	(lightSourceDesc at: 'color' ifAbsent: [nil]) ifNotNil: [ :colorDesc |
		color := Vector3 loadFromJson: colorDesc
	].
	intensity := (lightSourceDesc at: 'intensity' ifAbsent: [nil]) ifNil: [ 1.0 ].
	
	lightSource
		castShadows: ((lightSourceDesc at: 'castShadows' ifAbsent: [nil]) ifNil: [ lightSource castShadows ]);
		influenceRadius: ((lightSourceDesc at: 'influenceRadius' ifAbsent: [nil]) ifNil: [ lightSource radius ]);
		intensity: color * intensity.
	
	(lightSourceDesc at: 'transform' ifAbsent: [nil]) ifNotNil: [ :transformDesc |
		transform := TRSTransform3D loadFromJson: transformDesc
	].
	
	actor addComponent: ((WDGFActorLightSourceSceneComponent with: lightSource)
		transform: transform;
		yourself)
]

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor propertiesFrom: actorProperties [
	"TODO: Implement this when required."
]

{ #category : #loading }
WDGFWorldLoader >> loadActor: actor spotLightSourceFrom: lightSourceDesc [
	| lightSource color intensity transform |
	transform := TRSTransform3D identity.
	lightSource := WDSpotLightSource new.
	color := Vector3 ones.
	(lightSourceDesc at: 'color' ifAbsent: [nil]) ifNotNil: [ :colorDesc |
		color := Vector3 loadFromJson: colorDesc
	].
	intensity := (lightSourceDesc at: 'intensity' ifAbsent: [nil]) ifNil: [ 1.0 ].
	
	lightSource
		castShadows: ((lightSourceDesc at: 'castShadows' ifAbsent: [nil]) ifNil: [ lightSource castShadows ]);
		influenceRadius: ((lightSourceDesc at: 'influenceRadius' ifAbsent: [nil]) ifNil: [ lightSource radius ]);
		innerCutoff: ((lightSourceDesc at: 'innerCutoff' ifAbsent: [nil]) ifNil: [ lightSource innerCutoff ]);
		outerCutoff: ((lightSourceDesc at: 'outerCutoff' ifAbsent: [nil]) ifNil: [ lightSource outerCutoff ]);
		intensity: color * intensity.
	
	(lightSourceDesc at: 'transform' ifAbsent: [nil]) ifNotNil: [ :transformDesc |
		transform := TRSTransform3D loadFromJson: transformDesc
	].
	
	actor addComponent: ((WDGFActorLightSourceSceneComponent with: lightSource)
		transform: transform;
		yourself)
]

{ #category : #loading }
WDGFWorldLoader >> loadActorsFrom: actorsList [
	| loadedActors |
	"Load the actor contents."
	loadedActors := actorsList collect: [ :each |
		| actorClass |
		actorClass := world applicationSettings findActorClassByName: ((each at: 'className' ifAbsent: [nil]) ifNil: ['Actor']).
		actorClass ifNotNil: [
			| actor |
			actor := actorClass new.
			self loadActor: actor from: each.
			actor
		]
	].

	"Load the actor properties."
	loadedActors doWithIndex: [ :eachActor :eachActorIndex |
		eachActor ifNotNil: [
			| eachActorDesc |
			eachActorDesc := actorsList at: eachActorIndex.
			(eachActorDesc at: 'properties' ifAbsent: [ nil ]) ifNotNil: [ :propertiesDesc |
				self loadActor: eachActor propertiesFrom: propertiesDesc.
			].
		]
	].

	"Spawn the actors."
	loadedActors doWithIndex: [ :eachActor :eachActorIndex |
		eachActor ifNotNil: [
			world spawnActor: eachActor.
		]
	].


]

{ #category : #loading }
WDGFWorldLoader >> loadBSPBrushFace: eachFace into: meshBuilder [
	| plane vertices texcoords material vertexCount nx ny nz |
	plane := (eachFace at: 'plane' ifAbsent: [nil])
		ifNotNil: [:planeDesc | Plane loadFromJson: planeDesc].
	vertices := eachFace at: 'vertices' ifAbsent: [nil].
	texcoords := eachFace at: 'texcoords' ifAbsent: [nil].
	plane ifNil: [ ^ self ].
	texcoords ifNil: [ ^ self ].
	vertices ifNil: [ ^ self ].

	material := nil.
	
	(eachFace at: 'material' ifAbsent: [ nil ]) ifNotNil: [ :materialIndex |
		material := materials at: materialIndex + 1
	].
	
	vertexCount := vertices size / 3.
	nx := plane normal x.
	ny := plane normal y.
	nz := plane normal z.
	meshBuilder
		currentMaterial: material;
		beginTriangles;
		addPositionsData: vertices;
		addTexcoords0Data: texcoords.
	1 to: vertexCount do: [ :vi |
		meshBuilder addNx: nx y: ny z: nz
	].
	2 to: vertexCount - 1 do: [ :i |
		meshBuilder addTriangleI0: 0 i1: i - 1 i2: i
	].
]

{ #category : #loading }
WDGFWorldLoader >> loadFromFileNamed: aFileName in: aTargetWorld [
	world := aTargetWorld.
	self loadWorldFromJson: (STONJSON fromString: aFileName asFileReference contents)
]

{ #category : #loading }
WDGFWorldLoader >> loadMaterialFrom: materialDesc [
	(materialDesc at: 'path' ifAbsent: [ nil ]) ifNotNil: [:path |
		^ world applicationSettings loadMaterialWithPath: path
	].

	^ WDMaterial loadFromJson: materialDesc

]

{ #category : #loading }
WDGFWorldLoader >> loadMaterialList: materialList [
	materials := materialList collect: [ :eachMaterialDesc | self loadMaterialFrom: eachMaterialDesc ]
]

{ #category : #loading }
WDGFWorldLoader >> loadWorldFromJson: json [
	self loadMaterialList: ((json at: 'materials' ifAbsent: [nil]) ifNil: [#()]).
	self loadWorldSettingsFrom: json.
	self loadActorsFrom: ((json at: 'children' ifAbsent: [nil]) ifNil: [#()]).
]

{ #category : #loading }
WDGFWorldLoader >> loadWorldSettingsFrom: worldSettingsDesc [
	| ambientLighting hdriPath useHDRIAsSkybox backgroundActor lightProbe |
	ambientLighting := Vector3 zeros.

	hdriPath := (worldSettingsDesc at: 'hdri' ifAbsent: [ nil ]) ifNil: [ '' ].
	useHDRIAsSkybox := (worldSettingsDesc at: 'useHDRIAsSkybox' ifAbsent: [ nil ]) ifNil: [ true ].
	backgroundActor := WDGFStaticBackgroundActor new name: 'StaticBackground'; yourself.

	hdriPath ifNotEmpty: [
		| hdriSolvedPath |
		hdriSolvedPath := world applicationSettings resolveAssetPath: hdriPath.
		hdriSolvedPath exists ifTrue: [
			lightProbe := WDLightProbe forHDRIFileReference: hdriSolvedPath.
		]
	].

	backgroundActor addComponent: (WDGFAmbientLightProbeComponent new
		ambientLighting: ambientLighting;
		lightProbe: lightProbe;
		yourself).

	useHDRIAsSkybox ifTrue: [
		backgroundActor addComponent: (WDGFSkyBoxComponent with: lightProbe environment).
	].

	world spawnActor: backgroundActor
	
]
