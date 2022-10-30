"
I am an element in a world.
"
Class {
	#name : #WDGFWorldElement,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'WodenGameFramework-Core'
}

{ #category : #initialization }
WDGFWorldElement >> initialize [
	super initialize.
	name := ''.
]

{ #category : #accessing }
WDGFWorldElement >> name [

	^ name
]

{ #category : #accessing }
WDGFWorldElement >> name: anObject [

	name := anObject
]
