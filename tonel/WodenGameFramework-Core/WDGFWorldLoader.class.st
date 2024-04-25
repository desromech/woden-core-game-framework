Class {
	#name : #WDGFWorldLoader,
	#superclass : #Object,
	#instVars : [
		'world',
		'materials'
	],
	#category : #'WodenGameFramework-Core-Serialization'
}

{ #category : #'as yet unclassified' }
WDGFWorldLoader >> loadActorsFrom: actorsList [
	self halt
]

{ #category : #'as yet unclassified' }
WDGFWorldLoader >> loadFromFileNamed: aFileName in: aTargetWorld [
	world := aTargetWorld.
	self loadWorldFromJson: (STONJSON fromString: aFileName asFileReference contents)
]

{ #category : #'as yet unclassified' }
WDGFWorldLoader >> loadMaterialFrom: materialDesc [
	(materialDesc at: 'path' ifAbsent: [ nil ]) ifNotNil: [:path |
		^ world applicationSettings loadMaterialWithPath: path
	].

	^ WDMaterial loadFromJson: materialDesc

]

{ #category : #'as yet unclassified' }
WDGFWorldLoader >> loadMaterialList: materialList [
	materials := materialList collect: [ :eachMaterialDesc | self loadMaterialFrom: eachMaterialDesc ]
]

{ #category : #'as yet unclassified' }
WDGFWorldLoader >> loadWorldFromJson: json [
	self loadMaterialList: ((json at: 'materials' ifAbsent: [nil]) ifNil: [#()]).
	self loadActorsFrom: ((json at: 'children' ifAbsent: [nil]) ifNil: [#()]).
]
