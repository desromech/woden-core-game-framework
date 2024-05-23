"
I hold the settings for a specific game framework application.
"
Class {
	#name : #WDGFApplicationSettings,
	#superclass : #Object,
	#instVars : [
		'actorClassNameDictionary',
		'materialAssetCache',
		'modelAssetCache',
		'propAssetCache'
	],
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #converting }
WDGFApplicationSettings class >> asApplicationSettings [
	^ self new
]

{ #category : #converting }
WDGFApplicationSettings >> asApplicationSettings [
	^ self
]

{ #category : #'accessing - ui' }
WDGFApplicationSettings >> assetsLocations [
	^	self projectLocation
			ifNotNil: [ :location | { location / 'assets' } ]
			ifNil: [ #() ]
]

{ #category : #'as yet unclassified' }
WDGFApplicationSettings >> findActorClassByName: className [
	^ self validActorClassNameDictionary at: className ifAbsent: [ nil ]
]

{ #category : #initialization }
WDGFApplicationSettings >> initialize [
	super initialize.
	materialAssetCache := WeakValueDictionary new.
	modelAssetCache := WeakValueDictionary new.
	propAssetCache := WeakValueDictionary new.
]

{ #category : #'as yet unclassified' }
WDGFApplicationSettings >> loadMaterialWithPath: path [
	| solvedPath |
	solvedPath := self resolveAssetPath: path.
	solvedPath exists ifFalse: [ ^ nil ].
	^ materialAssetCache at: solvedPath fullName ifAbsentPut: [
		WDMaterial loadFromFileReference: solvedPath
	]
]

{ #category : #'as yet unclassified' }
WDGFApplicationSettings >> loadModelWithPath: path [
	| solvedPath |
	solvedPath := self resolveAssetPath: path.
	solvedPath exists ifFalse: [ ^ nil ].
	^ modelAssetCache at: solvedPath fullName ifAbsentPut: [
		[
			WDModelAssetReadWriter readFileNamed: solvedPath
		] on: Error do: [ :e | nil ]
	]
]

{ #category : #'as yet unclassified' }
WDGFApplicationSettings >> loadPropWithPath: path [
	| solvedPath |
	solvedPath := self resolveAssetPath: path.
	solvedPath exists ifFalse: [ ^ nil ].
	^ propAssetCache at: solvedPath fullName ifAbsentPut: [
		[
			| json |
			json := STONJSON fromString: solvedPath contents.
			WDGFPropAsset new
				model: ((json at: 'model' ifAbsent: [nil]) ifNotNil: [ :modelPath | self loadModelWithPath: modelPath ]);
				loadFromJson: json;
				yourself
		] on: Error do: [ :e | nil ]
	]
]

{ #category : #'accessing - ui' }
WDGFApplicationSettings >> mapsLocation [
	^ self assetsLocations first / 'maps'
]

{ #category : #'accessing - ui' }
WDGFApplicationSettings >> projectLocation [
	^ FileLocator imageDirectory
]

{ #category : #'as yet unclassified' }
WDGFApplicationSettings >> resolveAssetPath: path [
	| pathFileReference |
	pathFileReference := path asFileReference.
	self assetsLocations do: [ :each |
		| resolved |
		resolved := each resolve: pathFileReference.
		resolved exists ifTrue: [ ^ resolved ]
	].
	^ pathFileReference
]

{ #category : #'as yet unclassified' }
WDGFApplicationSettings >> validActorClassNameDictionary [
	^ actorClassNameDictionary ifNil: [
		actorClassNameDictionary := Dictionary new.
		WDGFActor withAllSubclassesDo: [ :eachSubclass |
			actorClassNameDictionary at: eachSubclass jsonObjectTypeName put: eachSubclass
		].
		
		actorClassNameDictionary
	]
]
