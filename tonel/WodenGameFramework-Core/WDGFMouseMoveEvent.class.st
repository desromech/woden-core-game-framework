"
I am a game framework mouse move event.
"
Class {
	#name : #WDGFMouseMoveEvent,
	#superclass : #WDGFMouseEvent,
	#instVars : [
		'delta'
	],
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFMouseMoveEvent class >> inputEventMessageName [
	^ #mouseMoveEvent:
]

{ #category : #accessing }
WDGFMouseMoveEvent >> delta [

	^ delta
]

{ #category : #accessing }
WDGFMouseMoveEvent >> delta: anObject [

	delta := anObject
]
