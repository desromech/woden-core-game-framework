"
I am a game framework mouse wheel event.
"
Class {
	#name : #WDGFMouseWheelEvent,
	#superclass : #WDGFMouseEvent,
	#instVars : [
		'scrollHorizontal',
		'scrollVertical'
	],
	#category : #'WodenGameFramework-Core-Events'
}

{ #category : #'message name' }
WDGFMouseWheelEvent class >> inputEventMessageName [
	^ #mouseWheelEvent:
]

{ #category : #accessing }
WDGFMouseWheelEvent >> scrollHorizontal [

	^ scrollHorizontal
]

{ #category : #accessing }
WDGFMouseWheelEvent >> scrollHorizontal: anObject [

	scrollHorizontal := anObject
]

{ #category : #accessing }
WDGFMouseWheelEvent >> scrollVertical [

	^ scrollVertical
]

{ #category : #accessing }
WDGFMouseWheelEvent >> scrollVertical: anObject [

	scrollVertical := anObject
]
