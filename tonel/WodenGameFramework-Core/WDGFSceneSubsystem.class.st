"
I am the scene subsystem in the game framework
"
Class {
	#name : #WDGFSceneSubsystem,
	#superclass : #WDGFSubsystem,
	#instVars : [
		'scene',
		'sceneChangedSubscriptions',
		'cameraComponents'
	],
	#category : #'WodenGameFramework-Core-Subsystem'
}

{ #category : #adding }
WDGFSceneSubsystem >> addCameraComponent: aCameraComponent [
	cameraComponents add: aCameraComponent
]

{ #category : #'as yet unclassified' }
WDGFSceneSubsystem >> findActiveCameraComponent [
	cameraComponents do: [ :each |
		each isActive ifTrue: [ ^ each ]
	].
	^ nil
]

{ #category : #initialization }
WDGFSceneSubsystem >> initialize [
	super initialize.
	scene := WDScene new.
	sceneChangedSubscriptions := OrderedCollection new.
	cameraComponents := OrderedCollection new.
]

{ #category : #accessing }
WDGFSceneSubsystem >> scene [

	^ scene
]

{ #category : #'as yet unclassified' }
WDGFSceneSubsystem >> sceneChanged [
	sceneChangedSubscriptions do: [ :each | each value ]
]

{ #category : #'as yet unclassified' }
WDGFSceneSubsystem >> whenSceneChangedDo: aBlock [
	sceneChangedSubscriptions add: aBlock
]
