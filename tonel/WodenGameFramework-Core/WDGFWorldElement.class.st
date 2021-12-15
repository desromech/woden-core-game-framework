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

{ #category : #'as yet unclassified' }
WDGFWorldElement >> editorClassName [
	^ self className withoutPrefix: 'WDGF'
]

{ #category : #'as yet unclassified' }
WDGFWorldElement >> editorTreeChildren [
	^ #()
]

{ #category : #'as yet unclassified' }
WDGFWorldElement >> editorTreeDisplayName [
	^ '[{1}]{2}' format: { self editorClassName . (name ifNil: ['']) asString }
]

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

{ #category : #'as yet unclassified' }
WDGFWorldElement >> visibleInEditor [
	^ true
]

{ #category : #'as yet unclassified' }
WDGFWorldElement >> visibleInEditor: aBoolean [
]
