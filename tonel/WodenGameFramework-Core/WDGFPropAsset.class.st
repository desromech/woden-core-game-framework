"
I am a prop asset. I am typically used for associating a model with extra metadata like collision detection and physical properties.
"
Class {
	#name : 'WDGFPropAsset',
	#superclass : 'Object',
	#instVars : [
		'model',
		'mass',
		'modelElementName',
		'collisionElementName'
	],
	#category : 'WodenGameFramework-Core-Serialization',
	#package : 'WodenGameFramework-Core',
	#tag : 'Serialization'
}

{ #category : 'initialization' }
WDGFPropAsset >> initialize [
	super initialize.
	mass := 0.0.
	modelElementName := ''.
	collisionElementName := ''.
	
]

{ #category : 'asset instantiation' }
WDGFPropAsset >> instantiateActor [
	| actor |
	actor := WDGFActor new.
	actor addComponent: WDGFActorSceneComponent new.
	
	model ifNotNil: [ 
		actor addComponent: (WDGFActorModelAssetSceneComponent new
			modelAsset: model;
			elementName: modelElementName;
			yourself).
			
		(model getCollisionShapeNamed: collisionElementName) ifNotNil: [ :collisionShape |
			actor addComponent: (WDGFCollisionShapeComponent with: collisionShape)
		]
	].

	mass > 0.0 ifTrue: [
		actor addComponent: (WDGFRigidBodyObjectComponent mass: mass)
	] ifFalse: [
		actor addComponent: WDGFCollisionObjectComponent new
	].
	
	^ actor
]

{ #category : 'serialization' }
WDGFPropAsset >> loadFromJson: json [
	mass := (json at: 'mass' ifAbsent: [ nil ]) ifNil: [mass].
	modelElementName := (json at: 'modelElementName' ifAbsent: [ nil ]) ifNil: [modelElementName].
	collisionElementName := (json at: 'collisionElementName' ifAbsent: [ nil ]) ifNil: [collisionElementName].
	
	
]

{ #category : 'accessing' }
WDGFPropAsset >> mass [

	^ mass
]

{ #category : 'accessing' }
WDGFPropAsset >> mass: anObject [

	mass := anObject
]

{ #category : 'accessing' }
WDGFPropAsset >> model [

	^ model
]

{ #category : 'accessing' }
WDGFPropAsset >> model: anObject [

	model := anObject
]
