"
I am a game framework mouse wheel event.
"
Class {
	#name : #WDGFMouseWheelEvent,
	#superclass : #WDGFMouseEvent,
	#instVars : [
		'verticalScroll',
		'horizontalScroll'
	],
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFMouseWheelEvent class >> inputEventMessageName [
	^ #mouseWheelEvent:
]

{ #category : #accessing }
WDGFMouseWheelEvent >> horizontalScroll [

	^ horizontalScroll
]

{ #category : #accessing }
WDGFMouseWheelEvent >> horizontalScroll: anObject [

	horizontalScroll := anObject
]

{ #category : #accessing }
WDGFMouseWheelEvent >> verticalScroll [

	^ verticalScroll
]

{ #category : #accessing }
WDGFMouseWheelEvent >> verticalScroll: anObject [

	verticalScroll := anObject
]
