Class {
	#name : #WDGFAmbientLightProbeComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'lightProbe',
		'ambientLighting'
	],
	#category : #'WodenGameFramework-Core-Components-Scene'
}

{ #category : #'instance creation' }
WDGFAmbientLightProbeComponent class >> with: aLightProbe [
	^ self new lightProbe: aLightProbe; yourself
]

{ #category : #accessing }
WDGFAmbientLightProbeComponent >> ambientLighting [

	^ ambientLighting
]

{ #category : #accessing }
WDGFAmbientLightProbeComponent >> ambientLighting: anAmbientLighting [
	ambientLighting := anAmbientLighting asVector3
]

{ #category : #initialization }
WDGFAmbientLightProbeComponent >> initialize [
	super initialize.
	ambientLighting := Vector3 zeros.
]

{ #category : #accessing }
WDGFAmbientLightProbeComponent >> lightProbe [

	^ lightProbe
]

{ #category : #accessing }
WDGFAmbientLightProbeComponent >> lightProbe: anObject [

	lightProbe := anObject
]

{ #category : #hooks }
WDGFAmbientLightProbeComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	ownerWorld sceneSubsystem scene
		ambientLighting: ambientLighting;
		ambientLightProbe: lightProbe
]
