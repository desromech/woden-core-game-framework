"
I am a component which is used for controlling the fog of a level.
"
Class {
	#name : 'WDGFFogComponent',
	#superclass : 'WDGFActorSceneComponent',
	#instVars : [
		'color',
		'startDistance',
		'endDistance',
		'density',
		'mode'
	],
	#category : 'WodenGameFramework-Core-Components-Scene',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Scene'
}

{ #category : 'accessing' }
WDGFFogComponent >> color [

	^ color
]

{ #category : 'accessing' }
WDGFFogComponent >> color: anObject [

	color := anObject
]

{ #category : 'accessing' }
WDGFFogComponent >> density [

	^ density
]

{ #category : 'accessing' }
WDGFFogComponent >> density: anObject [

	density := anObject
]

{ #category : 'accessing' }
WDGFFogComponent >> endDistance [

	^ endDistance
]

{ #category : 'accessing' }
WDGFFogComponent >> endDistance: anObject [

	endDistance := anObject
]

{ #category : 'initialization' }
WDGFFogComponent >> initialize [
	super initialize.
	color := Vector4 zeros.
	startDistance := 0.0.
	endDistance := 1.0.
	density := 1.0.
	mode := WDFogNoneMode asFogMode.
]

{ #category : 'testing' }
WDGFFogComponent >> isActive [
	^ true
]

{ #category : 'accessing' }
WDGFFogComponent >> mode [

	^ mode
]

{ #category : 'accessing' }
WDGFFogComponent >> mode: aFogMode [
	mode := aFogMode asFogMode
]

{ #category : 'hooks' }
WDGFFogComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	
	ownerWorld sceneSubsystem addFogComponent: self.
]

{ #category : 'hooks' }
WDGFFogComponent >> privateUnregisterFromWorld [
	super privateUnregisterFromWorld.
	
	ownerWorld sceneSubsystem removeFogComponent: self.
]

{ #category : 'accessing' }
WDGFFogComponent >> startDistance [

	^ startDistance
]

{ #category : 'accessing' }
WDGFFogComponent >> startDistance: anObject [

	startDistance := anObject
]
