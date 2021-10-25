"
I am a Spec2 presenter for displaying a woden game framework world.
"
Class {
	#name : #WDGFSpWorldPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#world => ObservableSlot',
		'#playing => ObservableSlot'
	],
	#category : #'WodenGameFramework-Spec'
}

{ #category : #specs }
WDGFSpWorldPresenter class >> adapterName [
	^ #WodenGameFrameworkWorldAdapter
]

{ #category : #initialization }
WDGFSpWorldPresenter >> initialize [
	super initialize.
	playing := false.
]

{ #category : #accessing }
WDGFSpWorldPresenter >> playing [

	^ playing
]

{ #category : #accessing }
WDGFSpWorldPresenter >> playing: anObject [

	playing := anObject
]

{ #category : #enumerating }
WDGFSpWorldPresenter >> whenWorldChangedDo: aBlock [
	self property: #world whenChangedDo: aBlock
]

{ #category : #accessing }
WDGFSpWorldPresenter >> world [

	^ world
]

{ #category : #accessing }
WDGFSpWorldPresenter >> world: anObject [

	world := anObject
]
