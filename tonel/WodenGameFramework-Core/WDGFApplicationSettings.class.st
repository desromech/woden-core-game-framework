"
I hold the settings for a specific game framework application.
"
Class {
	#name : #WDGFApplicationSettings,
	#superclass : #Object,
	#instVars : [
		'actorClassNameDictionary'
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

{ #category : #'as yet unclassified' }
WDGFApplicationSettings >> loadMaterialWithPath: path [
	| solvedPath |
	solvedPath := self resolveAssetPath: path.
	solvedPath exists ifFalse: [ ^ nil ].
	^ WDMaterial loadFromFileReference: solvedPath
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
