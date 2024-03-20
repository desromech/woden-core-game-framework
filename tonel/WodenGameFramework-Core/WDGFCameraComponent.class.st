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
	#category : #'WodenGameFramework-Core-Components-Scene'
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

{ #category : #accessing }
WDGFCameraComponent >> headFloorTransform [
	^ camera headFloorTransform
]

{ #category : #accessing }
WDGFCameraComponent >> headFloorTransform: aTransform [
	camera headFloorTransform: aTransform
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
	super privateRegisterInWorld.
	camera ifNotNil: [ 
		sceneNode cameras: { camera }
	].

	ownerWorld sceneSubsystem addCameraComponent: self
]

{ #category : #hooks }
WDGFCameraComponent >> privateUnregisterFromWorld [
	super privateRegisterInWorld.
	ownerWorld sceneSubsystem removeCameraComponent: self
]
