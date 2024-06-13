"
I hold the result for a specific actor ray casting query.
"
Class {
	#name : 'WDGFActorRayCastingResult',
	#superclass : 'Object',
	#instVars : [
		'actor',
		'ray',
		'distance',
		'normal'
	],
	#category : 'WodenGameFramework-Core-Components-Physics',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Physics'
}

{ #category : 'accessing' }
WDGFActorRayCastingResult >> actor [

	^ actor
]

{ #category : 'accessing' }
WDGFActorRayCastingResult >> actor: anObject [

	actor := anObject
]

{ #category : 'accessing' }
WDGFActorRayCastingResult >> distance [

	^ distance
]

{ #category : 'accessing' }
WDGFActorRayCastingResult >> distance: anObject [

	distance := anObject
]

{ #category : 'accessing' }
WDGFActorRayCastingResult >> normal [

	^ normal
]

{ #category : 'accessing' }
WDGFActorRayCastingResult >> normal: anObject [

	normal := anObject
]

{ #category : 'accessing' }
WDGFActorRayCastingResult >> ray [

	^ ray
]

{ #category : 'accessing' }
WDGFActorRayCastingResult >> ray: anObject [

	ray := anObject
]
