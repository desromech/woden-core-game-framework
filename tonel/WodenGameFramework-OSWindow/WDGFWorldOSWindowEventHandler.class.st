"
I am the event handler for a Woden Game Framework OSWindow.
"
Class {
	#name : #WDGFWorldOSWindowEventHandler,
	#superclass : #WDAbstractRenderingSceneStateOSWindowEventHandler,
	#instVars : [
		'playing',
		'wodenWorld'
	],
	#category : #'WodenGameFramework-OSWindow'
}

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitJoyAxisEvent: anEvent [
	window ifNotNil: [ window onJoyAxis: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitJoyButtonDownEvent: anEvent [
	window ifNotNil: [ window onJoyButtonDown: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitJoyButtonUpEvent: anEvent [
	window ifNotNil: [ window onJoyButtonUp: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitKeyDownEvent: anEvent [
	window ifNotNil: [ window onKeyDown: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitKeyUpEvent: anEvent [
	window ifNotNil: [ window onKeyUp: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitMouseButtonPressEvent: anEvent [
	window ifNotNil: [ window onMouseButtonPress: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitMouseButtonReleaseEvent: anEvent [
	window ifNotNil: [ window onMouseButtonRelease: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitMouseMoveEvent: anEvent [
	window ifNotNil: [ window onMouseMove: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitMouseWheelEvent: anEvent [
	window ifNotNil: [ window onMouseWheel: anEvent ]
]

{ #category : #visiting }
WDGFWorldOSWindowEventHandler >> visitTextInputEvent: anEvent [
	window ifNotNil: [ window onTextInput: anEvent ]
]
