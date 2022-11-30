"
I am component that is used for controling a specific camera in the scene.
"
Class {
	#name : #WDGFCameraComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'camera'
	],
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #'instance creation' }
WDGFCameraComponent class >> with: aCamera [
	^ self new camera: aCamera; yourself
]

{ #category : #accessing }
WDGFCameraComponent >> camera [

	^ camera
]

{ #category : #accessing }
WDGFCameraComponent >> camera: anObject [

	camera := anObject
]
