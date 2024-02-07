Class {
	#name : #WDGFAmbientLightProbeComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'lightProbe'
	],
	#category : #'WodenGameFramework-Core-Components-Scene'
}

{ #category : #'instance creation' }
WDGFAmbientLightProbeComponent class >> with: aLightProbe [
	^ self new lightProbe: aLightProbe; yourself
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
	(ownerWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem) scene
		ambientLighting: 0.0;
		ambientLightProbe: lightProbe
]
