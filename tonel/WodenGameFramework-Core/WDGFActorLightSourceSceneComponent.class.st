Class {
	#name : 'WDGFActorLightSourceSceneComponent',
	#superclass : 'WDGFActorSceneComponent',
	#instVars : [
		'light'
	],
	#category : 'WodenGameFramework-Core-Components-Scene',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Scene'
}

{ #category : 'instance creation' }
WDGFActorLightSourceSceneComponent class >> with: aLight [
	^ self new light: aLight; yourself
]

{ #category : 'accessing' }
WDGFActorLightSourceSceneComponent >> light [

	^ light
]

{ #category : 'accessing' }
WDGFActorLightSourceSceneComponent >> light: anObject [

	light := anObject
]

{ #category : 'hooks' }
WDGFActorLightSourceSceneComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	light ifNotNil: [ 
		sceneNode lights: { light }
	].

]
