"
I am a menu subsystem.
"
Class {
	#name : 'WDGFMenuSubsystem',
	#superclass : 'WDGFSubsystem',
	#instVars : [
		'isEnabled',
		'overlay',
		'menuEnabledChangedBlock'
	],
	#category : 'WodenGameFramework-Core-Subsystem',
	#package : 'WodenGameFramework-Core',
	#tag : 'Subsystem'
}

{ #category : 'event management' }
WDGFMenuSubsystem >> dispatchEvent: anEventToDispatch [
	overlay ifNotNil: [ 
		overlay dispatchWodenGameFrameworkEvent: anEventToDispatch
	].

	(self respondsTo: anEventToDispatch inputEventMessageName) ifTrue: [ 
		self perform: anEventToDispatch inputEventMessageName with: anEventToDispatch
	].

]

{ #category : 'initialization' }
WDGFMenuSubsystem >> initialize [
	super initialize.
	isEnabled := false.
	menuEnabledChangedBlock := [:enabled |].
]

{ #category : 'accessing' }
WDGFMenuSubsystem >> isEnabled [

	^ isEnabled
]

{ #category : 'accessing' }
WDGFMenuSubsystem >> isEnabled: anObject [
	isEnabled := anObject.
	menuEnabledChangedBlock cull: isEnabled.
]

{ #category : 'keyboard handlers' }
WDGFMenuSubsystem >> keyDownEvent: event [
	event symbol = KeyboardKey escape ifTrue: [
		self toggleMenu
	].
]

{ #category : 'enumerating' }
WDGFMenuSubsystem >> onMenuEnabledChangedDo: aBlock [
	menuEnabledChangedBlock := aBlock.
]

{ #category : 'accessing' }
WDGFMenuSubsystem >> overlay [

	^ overlay
]

{ #category : 'accessing' }
WDGFMenuSubsystem >> overlay: anObject [

	overlay := anObject
]

{ #category : 'as yet unclassified' }
WDGFMenuSubsystem >> toggleMenu [
	self isEnabled: self isEnabled not.
]
