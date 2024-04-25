"
I am a static actor. I am typically used for holding static level data.
"
Class {
	#name : #WDGFStaticActor,
	#superclass : #WDGFActor,
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #initialization }
WDGFStaticActor >> setupComponents [
	super setupComponents.
	self addComponent: WDGFActorSceneComponent new.
	self addComponent: WDGFCollisionObjectComponent new.
]
