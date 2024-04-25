Class {
	#name : #WDGFStaticBackgroundActor,
	#superclass : #WDGFActor,
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #initialization }
WDGFStaticBackgroundActor >> setupComponents [
	super setupComponents.
	self addComponent: WDGFActorSceneComponent new beSceneBackground.
]
