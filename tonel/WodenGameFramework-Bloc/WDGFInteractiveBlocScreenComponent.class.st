Class {
	#name : 'WDGFInteractiveBlocScreenComponent',
	#superclass : 'WDGFAbstractInteractiveScreenComponent',
	#traits : 'TWDGFBlEventConverter',
	#classTraits : 'TWDGFBlEventConverter classTrait',
	#instVars : [
		'space',
		'time'
	],
	#category : 'WodenGameFramework-Bloc',
	#package : 'WodenGameFramework-Bloc'
}

{ #category : 'construction' }
WDGFInteractiveBlocScreenComponent class >> boundingBox: aBoundingBox space: space [
	^ self new boundingBox: aBoundingBox; space: space; yourself
]

{ #category : 'construction' }
WDGFInteractiveBlocScreenComponent class >> boundingBoxHalfExtent: aHalfExtent space: texture [
	^ self boundingBox: (AABox halfExtent: aHalfExtent) space: texture
]

{ #category : 'event management' }
WDGFInteractiveBlocScreenComponent >> dispatchEvent: anInputEvent [
	super dispatchEvent: anInputEvent.
	anInputEvent accept: self
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> enqueue: anEvent [
	space ifNil: [ ^ self ].
	space hostSpace ifNil: [ ^ self ].
	space hostSpace enqueueEvent: anEvent
]

{ #category : 'mouse handlers' }
WDGFInteractiveBlocScreenComponent >> initialize [
	super initialize.
	time := BlTime real.
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> screenExtent [
	^ space extent asPoint
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> space [

	^ space
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> space: anObject [

	space := anObject
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> time [

	^ time
]

{ #category : 'accessing' }
WDGFInteractiveBlocScreenComponent >> time: anObject [

	time := anObject
]
