"
I am an OSWindow that is used for displaying a Woden Game Framework World. I am also used for injecting user inputs an events into this environment.
"
Class {
	#name : #WDGFWorldOSWindow,
	#superclass : #WDSceneOSWindow,
	#instVars : [
		'playing',
		'wodenWorld'
	],
	#category : #'WodenGameFramework-OSWindow'
}

{ #category : #initialization }
WDGFWorldOSWindow >> initialize [
	super initialize.
	playing := false.
]

{ #category : #accessing }
WDGFWorldOSWindow >> playing [

	^ playing
]

{ #category : #accessing }
WDGFWorldOSWindow >> playing: anObject [

	playing := anObject
]

{ #category : #accessing }
WDGFWorldOSWindow >> wodenWorld [

	^ wodenWorld
]

{ #category : #accessing }
WDGFWorldOSWindow >> wodenWorld: anObject [
	| sceneSubsystem |
	wodenWorld := anObject.
	sceneSubsystem := wodenWorld getOrCreateSubsystemWithClass: WDGFSceneSubsystem.
	self scene: sceneSubsystem scene.
	self camera: (WDCamera new asSceneNode position: (Vector3 x: 0 y: 0 z: 3)).
	sceneSubsystem whenSceneChangedDo: [ self changed ].
	self changed.
]
