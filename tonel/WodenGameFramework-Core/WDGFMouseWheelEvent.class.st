"
I am a game framework mouse wheel event.
"
Class {
	#name : 'WDGFMouseWheelEvent',
	#superclass : 'WDGFMouseEvent',
	#instVars : [
		'scrollHorizontal',
		'scrollVertical'
	],
	#category : 'WodenGameFramework-Core-Events',
	#package : 'WodenGameFramework-Core',
	#tag : 'Events'
}

{ #category : 'message name' }
WDGFMouseWheelEvent class >> inputEventMessageName [
	^ #mouseWheelEvent:
]

{ #category : 'as yet unclassified' }
WDGFMouseWheelEvent >> accept: anEventHandler [
	^ anEventHandler mouseWheelEvent: self
]

{ #category : 'initialization' }
WDGFMouseWheelEvent >> initialize [
	super initialize.
	scrollHorizontal := 0.
	scrollVertical := 0.
	
]

{ #category : 'accessing' }
WDGFMouseWheelEvent >> scrollHorizontal [

	^ scrollHorizontal
]

{ #category : 'accessing' }
WDGFMouseWheelEvent >> scrollHorizontal: anObject [

	scrollHorizontal := anObject
]

{ #category : 'accessing' }
WDGFMouseWheelEvent >> scrollVertical [

	^ scrollVertical
]

{ #category : 'accessing' }
WDGFMouseWheelEvent >> scrollVertical: anObject [

	scrollVertical := anObject
]
