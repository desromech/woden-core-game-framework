"
I am component that is used for controling a specific camera in the scene.
"
Class {
	#name : #WDGFCameraComponent,
	#superclass : #WDGFActorSceneComponent,
	#instVars : [
		'camera',
		'isActive'
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

{ #category : #initialization }
WDGFCameraComponent >> initialize [
	super initialize.
	camera := WDCamera new.
	isActive := false.
]

{ #category : #accessing }
WDGFCameraComponent >> isActive [

	^ isActive
]

{ #category : #accessing }
WDGFCameraComponent >> isActive: anObject [

	isActive := anObject
]

{ #category : #hooks }
WDGFCameraComponent >> privateRegisterInWorld [
	| sceneSubsystem |
	super privateRegisterInWorld.
	camera ifNotNil: [ 
		sceneNode cameras: { camera }
	].

	sceneSubsystem := ownerWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	sceneSubsystem addCameraComponent: self
]
