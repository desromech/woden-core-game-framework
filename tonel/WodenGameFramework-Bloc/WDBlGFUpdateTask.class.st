"
I am a task used for updating the simulation of a woden game framework element.
"
Class {
	#name : 'WDBlGFUpdateTask',
	#superclass : 'BlRepeatedTask',
	#instVars : [
		'worldElement'
	],
	#category : 'WodenGameFramework-Bloc',
	#package : 'WodenGameFramework-Bloc'
}

{ #category : 'initialization' }
WDBlGFUpdateTask >> initialize [
	super initialize.
	self delay: 16 milliSeconds.
	
]

{ #category : 'api - running' }
WDBlGFUpdateTask >> onRun [
	worldElement updateTimestep: self delay asMicroseconds * 1e-6
]

{ #category : 'accessing' }
WDBlGFUpdateTask >> worldElement [

	^ worldElement
]

{ #category : 'accessing' }
WDBlGFUpdateTask >> worldElement: anObject [

	worldElement := anObject
]
