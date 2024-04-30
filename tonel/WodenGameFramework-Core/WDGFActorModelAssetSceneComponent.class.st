Class {
	#name : #WDGFActorModelAssetSceneComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'modelAsset',
		'elementName'
	],
	#category : #'WodenGameFramework-Core-Components-Scene'
}

{ #category : #'instance creation' }
WDGFActorModelAssetSceneComponent class >> with: aModelAsset [
	^ self new modelAsset: aModelAsset; yourself
]

{ #category : #accessing }
WDGFActorModelAssetSceneComponent >> elementName [

	^ elementName
]

{ #category : #accessing }
WDGFActorModelAssetSceneComponent >> elementName: anObject [

	elementName := anObject
]

{ #category : #accessing }
WDGFActorModelAssetSceneComponent >> modelAsset [

	^ modelAsset
]

{ #category : #accessing }
WDGFActorModelAssetSceneComponent >> modelAsset: anObject [

	modelAsset := anObject
]

{ #category : #hooks }
WDGFActorModelAssetSceneComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	modelAsset ifNotNil: [
		(modelAsset instanceSceneNodeForElementNamed: elementName) ifNotNil: [ :modelSceneNode |
			sceneNode add: modelSceneNode
		]
	].

]
