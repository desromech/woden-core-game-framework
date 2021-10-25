"
I am the scene subsystem in the game framework
"
Class {
	#name : #WDGFSceneSubsystem,
	#superclass : #WDGFSubsystem,
	#instVars : [
		'scene'
	],
	#category : #'WodenGameFramework-Core'
}

{ #category : #initialization }
WDGFSceneSubsystem >> initialize [
	super initialize.
	scene := WDScene new.
]

{ #category : #accessing }
WDGFSceneSubsystem >> scene [

	^ scene
]
