"
I am a game framework mouse move event.
"
Class {
	#name : 'WDGFMouseMoveEvent',
	#superclass : 'WDGFMouseEvent',
	#instVars : [
		'delta'
	],
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'message name' }
WDGFMouseMoveEvent class >> inputEventMessageName [
	^ #mouseMoveEvent:
]

{ #category : 'as yet unclassified' }
WDGFMouseMoveEvent >> accept: anEventHandler [
	^ anEventHandler mouseMoveEvent: self
]

{ #category : 'accessing' }
WDGFMouseMoveEvent >> delta [

	^ delta
]

{ #category : 'accessing' }
WDGFMouseMoveEvent >> delta: anObject [

	delta := anObject
]
