"
I am a bloc element which is used for displaying a Woden Game Framework World inside of Bloc.
"
Class {
	#name : #WDBlGFWorldElement,
	#superclass : #WDBlSceneElement,
	#instVars : [
		'wodenWorld',
		'defaultCamera'
	],
	#category : #'WodenGameFramework-Bloc'
}

{ #category : #accessing }
WDBlGFWorldElement >> getOrCreateDefaultCamera [
	^ defaultCamera ifNil: [defaultCamera := WDCamera new asSceneNode
			position: (Vector3 x: 0 y: 0 z: 0);
			yourself
		]
]

{ #category : #accessing }
WDBlGFWorldElement >> selectCurrentCamera [
	wodenWorld ifNotNil: [ 
		(wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem) findActiveCameraComponent ifNotNil: [ :cameraComponent |
				^ cameraComponent sceneNode
		]
	].

	^ self getOrCreateDefaultCamera
]

{ #category : #accessing }
WDBlGFWorldElement >> wodenWorld [

	^ wodenWorld
]

{ #category : #accessing }
WDBlGFWorldElement >> wodenWorld: anObject [
	| sceneSubsystem |
	wodenWorld := anObject.
	sceneSubsystem := wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	self scene: sceneSubsystem scene.
	self camera: self selectCurrentCamera.
	sceneSubsystem whenSceneChangedDo: [ self invalidate ].
	self invalidate.
]
