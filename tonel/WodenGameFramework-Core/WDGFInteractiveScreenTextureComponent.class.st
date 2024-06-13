Class {
	#name : 'WDGFInteractiveScreenTextureComponent',
	#superclass : 'WDGFAbstractInteractiveScreenComponent',
	#instVars : [
		'texture'
	],
	#category : 'WodenGameFramework-Core-Components-Scene',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Scene'
}

{ #category : 'construction' }
WDGFInteractiveScreenTextureComponent class >> boundingBox: aBoundingBox texture: texture [
	^ self new boundingBox: aBoundingBox; texture: texture; yourself
]

{ #category : 'construction' }
WDGFInteractiveScreenTextureComponent class >> boundingBoxHalfExtent: aHalfExtent texture: texture [
	^ self boundingBox: (AABox halfExtent: aHalfExtent) texture: texture
]

{ #category : 'accessing' }
WDGFInteractiveScreenTextureComponent >> screenExtent [
	^ texture width @ texture height
]

{ #category : 'accessing' }
WDGFInteractiveScreenTextureComponent >> texture [

	^ texture
]

{ #category : 'accessing' }
WDGFInteractiveScreenTextureComponent >> texture: anObject [

	texture := anObject
]
