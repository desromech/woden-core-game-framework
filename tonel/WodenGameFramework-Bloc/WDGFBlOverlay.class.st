"
I am a Woden Bloc overlay capable of dispatching woden game framework events.
"
Class {
	#name : 'WDGFBlOverlay',
	#superclass : 'WDBlOverlay',
	#traits : 'TWDGFBlEventConverter',
	#classTraits : 'TWDGFBlEventConverter classTrait',
	#instVars : [
		'time'
	],
	#category : 'WodenGameFramework-Bloc',
	#package : 'WodenGameFramework-Bloc'
}

{ #category : 'converting' }
WDGFBlOverlay >> convertScreenPosition: aPoint [
	^ aPoint - drawingPosition
]

{ #category : 'actions' }
WDGFBlOverlay >> enqueue: anEvent [
	space ifNil: [ ^ self ].
	space hostSpace ifNil: [ ^ self ].
	space hostSpace enqueueEvent: anEvent
]

{ #category : 'initialization' }
WDGFBlOverlay >> initialize [
	super initialize.
	time := BlTime real.
]

{ #category : 'accessing' }
WDGFBlOverlay >> time [

	^ time
]

{ #category : 'accessing' }
WDGFBlOverlay >> time: anObject [

	time := anObject
]
