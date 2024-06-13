Class {
	#name : 'WDGFStaticBackgroundActor',
	#superclass : 'WDGFActor',
	#category : 'WodenGameFramework-Core-Actor',
	#package : 'WodenGameFramework-Core',
	#tag : 'Actor'
}

{ #category : 'initialization' }
WDGFStaticBackgroundActor >> setupComponents [
	super setupComponents.
	self addComponent: WDGFActorSceneComponent new beSceneBackground.
]
