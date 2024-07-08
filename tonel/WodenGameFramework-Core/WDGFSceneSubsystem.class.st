"
I am the scene subsystem in the game framework
"
Class {
	#name : 'WDGFSceneSubsystem',
	#superclass : 'WDGFSubsystem',
	#instVars : [
		'scene',
		'sceneChangedSubscriptions',
		'cameraComponents',
		'fogComponents'
	],
	#category : 'WodenGameFramework-Core-Subsystem',
	#package : 'WodenGameFramework-Core',
	#tag : 'Subsystem'
}

{ #category : 'adding' }
WDGFSceneSubsystem >> addCameraComponent: aCameraComponent [
	cameraComponents add: aCameraComponent
]

{ #category : 'adding' }
WDGFSceneSubsystem >> addFogComponent: aFogComponent [
	fogComponents add: aFogComponent
]

{ #category : 'as yet unclassified' }
WDGFSceneSubsystem >> findActiveCameraComponent [
	cameraComponents do: [ :each |
		each isActive ifTrue: [ ^ each ]
	].
	^ nil
]

{ #category : 'as yet unclassified' }
WDGFSceneSubsystem >> findActiveFogComponent [
	fogComponents do: [:each |
		each isActive ifTrue: [ ^ each ]
	].
	^ nil
]

{ #category : 'initialization' }
WDGFSceneSubsystem >> initialize [
	super initialize.
	scene := WDScene new.
	sceneChangedSubscriptions := OrderedCollection new.
	cameraComponents := OrderedCollection new.
	fogComponents := OrderedCollection new.
]

{ #category : 'adding' }
WDGFSceneSubsystem >> removeCameraComponent: aCameraComponent [
	cameraComponents remove: aCameraComponent
]

{ #category : 'adding' }
WDGFSceneSubsystem >> removeFogComponent: aFogComponent [
	fogComponents remove: aFogComponent
]

{ #category : 'accessing' }
WDGFSceneSubsystem >> scene [

	^ scene
]

{ #category : 'as yet unclassified' }
WDGFSceneSubsystem >> sceneChanged [
	sceneChangedSubscriptions do: [ :each | each value ]
]

{ #category : 'accessing' }
WDGFSceneSubsystem >> updatePriority [
	^ SceneUpdatePriority
]

{ #category : 'as yet unclassified' }
WDGFSceneSubsystem >> whenSceneChangedDo: aBlock [
	sceneChangedSubscriptions add: aBlock
]
