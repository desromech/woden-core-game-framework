"
I am a menu subsystem.
"
Class {
	#name : 'WDGFMenuSubsystem',
	#superclass : 'WDGFSubsystem',
	#instVars : [
		'isEnabled'
	],
	#category : 'WodenGameFramework-Core-Subsystem',
	#package : 'WodenGameFramework-Core',
	#tag : 'Subsystem'
}

{ #category : 'initialization' }
WDGFMenuSubsystem >> initialize [
	super initialize.
	isEnabled := false.
	
]

{ #category : 'accessing' }
WDGFMenuSubsystem >> isEnabled [

	^ isEnabled
]

{ #category : 'accessing' }
WDGFMenuSubsystem >> isEnabled: anObject [

	isEnabled := anObject
]

{ #category : 'as yet unclassified' }
WDGFMenuSubsystem >> toggleMenu [
	isEnabled := isEnabled not.
	Transcript show: 'Menu subsystem enabled: '; show: isEnabled; cr.
]
