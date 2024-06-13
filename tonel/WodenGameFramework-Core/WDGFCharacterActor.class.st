"
I am a sample character actor that uses physics for its movement.
"
Class {
	#name : 'WDGFCharacterActor',
	#superclass : 'WDGFActor',
	#instVars : [
		'walkingDirection',
		'walkingSpeed'
	],
	#category : 'WodenGameFramework-Core-Actor-Character',
	#package : 'WodenGameFramework-Core',
	#tag : 'Actor-Character'
}

{ #category : 'as yet unclassified' }
WDGFCharacterActor class >> defaultBroadness [
	^ 0.5
]

{ #category : 'as yet unclassified' }
WDGFCharacterActor class >> defaultHeight [
	^ 1.6
]

{ #category : 'as yet unclassified' }
WDGFCharacterActor class >> defaultJumpVelocity [
	^ Vector3 y: 2.0
]

{ #category : 'as yet unclassified' }
WDGFCharacterActor class >> defaultMass [
	^ 70.0
]

{ #category : 'initialization' }
WDGFCharacterActor >> initialize [
	super initialize.
	self wantsToTick: true.
	walkingDirection := Vector3 zeros.
	walkingSpeed := 3.0.
]

{ #category : 'controlling' }
WDGFCharacterActor >> jump [
	collisionObjectComponent jump
]

{ #category : 'initialization' }
WDGFCharacterActor >> setupComponents [
	super setupComponents.
	self addComponent: WDGFActorSceneComponent new.
	self addComponent: (WDGFCapsuleYCollisionShapeComponent height: self class defaultHeight - self class defaultBroadness radius: self class defaultBroadness / 2).
	self addComponent: (WDGFCharacterBodyObjectComponent new
		mass: self class defaultMass;
		restitutionCoefficient: 0.0;
		withoutTorque;
		jumpVelocity: self class defaultJumpVelocity;
		yourself).
]

{ #category : 'game events' }
WDGFCharacterActor >> tick: deltaSeconds [
	| walkingVelocity |
	walkingVelocity := walkingDirection normalized * walkingSpeed.
	collisionObjectComponent walkingVelocity: walkingDirection normalized * walkingSpeed.
]
