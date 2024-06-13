"
I am component that is used for accessing the state and events of a specific VR tracked device.
"
Class {
	#name : 'WDGFCameraComponent',
	#superclass : 'WDGFActorSceneComponent',
	#instVars : [
		'camera',
		'isActive',
		'viewportExtent',
		'overlay'
	],
	#category : 'WodenGameFramework-Core-Components-Scene',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Scene'
}

{ #category : 'instance creation' }
WDGFCameraComponent class >> with: aCamera [
	^ self new camera: aCamera; yourself
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> aspectRatio [
	^ viewportExtent x / viewportExtent y
]

{ #category : 'accessing' }
WDGFCameraComponent >> camera [

	^ camera
]

{ #category : 'accessing' }
WDGFCameraComponent >> camera: anObject [

	camera := anObject
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> frustum [
	^ camera frustumWithAspect: self aspectRatio.
]

{ #category : 'accessing' }
WDGFCameraComponent >> headFloorTransform [
	^ camera headFloorTransform
]

{ #category : 'accessing' }
WDGFCameraComponent >> headFloorTransform: aTransform [
	camera headFloorTransform: aTransform
]

{ #category : 'initialization' }
WDGFCameraComponent >> initialize [
	super initialize.
	camera := WDCamera new.
	viewportExtent := 1@1.
	isActive := false.
]

{ #category : 'accessing' }
WDGFCameraComponent >> isActive [

	^ isActive
]

{ #category : 'accessing' }
WDGFCameraComponent >> isActive: anObject [

	isActive := anObject
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> localRayForViewportPoint: point [
	| normalizedPoint frustum |
	normalizedPoint := self viewportPointToNormalized: point.
	frustum := self frustum.
	^ frustum rayForNormalizedPoint: point
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> mouseEventPositionToNormalized: mouseEvent [
	self owner world inputSubsystem hasMouseCapture ifTrue: [
		^ Vector2 x: 0.5 y: 0.5
	].

	^ self viewportPointToNormalized: mouseEvent position
]

{ #category : 'accessing' }
WDGFCameraComponent >> overlay [

	^ overlay
]

{ #category : 'accessing' }
WDGFCameraComponent >> overlay: anObject [

	overlay := anObject
]

{ #category : 'hooks' }
WDGFCameraComponent >> privateRegisterInWorld [
	super privateRegisterInWorld.
	camera ifNotNil: [ 
		sceneNode cameras: { camera }
	].

	ownerWorld sceneSubsystem addCameraComponent: self.
	ownerWorld soundSubsystem addCameraComponent: self.
]

{ #category : 'hooks' }
WDGFCameraComponent >> privateUnregisterFromWorld [
	super privateRegisterInWorld.
	ownerWorld sceneSubsystem removeCameraComponent: self.
	ownerWorld soundSubsystem removeCameraComponent: self.
]

{ #category : 'accessing' }
WDGFCameraComponent >> viewportExtent [

	^ viewportExtent
]

{ #category : 'accessing' }
WDGFCameraComponent >> viewportExtent: anObject [

	viewportExtent := anObject
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> viewportPointToNormalized: point [
	^ Vector2 x: (point x / viewportExtent x) y: 1.0 - (point y / viewportExtent y)
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> worldRayForMouseEventPosition: event [
	| normalizedPoint frustum nearPoint farPoint |
	normalizedPoint := self mouseEventPositionToNormalized: event.
	frustum := self frustum.
	nearPoint := frustum normalizedPointInNearPlane: normalizedPoint.
	farPoint := frustum normalizedPointInFarPlane: normalizedPoint.
	^ Ray3D from: (self transformPositionToWorld: nearPoint) to: (self transformPositionToWorld: farPoint)
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> worldRayForMouseEventPosition: point maxDistance: maxDistance [
	^ (self worldRayForMouseEventPosition: point) withMaxDistance: maxDistance
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> worldRayForViewportPoint: point [
	| normalizedPoint frustum nearPoint farPoint |
	normalizedPoint := self viewportPointToNormalized: point.
	frustum := self frustum.
	nearPoint := frustum normalizedPointInNearPlane: normalizedPoint.
	farPoint := frustum normalizedPointInFarPlane: normalizedPoint.
	^ Ray3D from: (self transformPositionToWorld: nearPoint) to: (self transformPositionToWorld: farPoint)
]

{ #category : 'as yet unclassified' }
WDGFCameraComponent >> worldRayForViewportPoint: point maxDistance: maxDistance [
	^ (self worldRayForViewportPoint: point) withMaxDistance: maxDistance
]
