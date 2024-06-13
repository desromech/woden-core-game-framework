Class {
	#name : 'WDGFPhysicsHoldObjectConstraintComponent',
	#superclass : 'WDGFPhysicsPairUnionConstraintComponent',
	#instVars : [
		'targetRelativePosition',
		'targetRelativeOrientation'
	],
	#category : 'WodenGameFramework-Core-Components-Physics',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Physics'
}

{ #category : 'initialization' }
WDGFPhysicsHoldObjectConstraintComponent >> initialize [
	super initialize.
	targetRelativePosition := Vector3 zeros.
	targetRelativeOrientation := Quaternion identity.
	
]

{ #category : 'hooks' }
WDGFPhysicsHoldObjectConstraintComponent >> privateConstructPhysicsConstraint [
	physicsConstraint := WDPHoldObjectConstraint new
		stiffness: stiffness;
		damping: damping;
		firstObject: firstObject;
		secondObject: secondObject;
		targetRelativePosition: targetRelativePosition;
		targetRelativeOrientation: targetRelativeOrientation;
		yourself

]

{ #category : 'accessing' }
WDGFPhysicsHoldObjectConstraintComponent >> targetRelativeOrientation [

	^ targetRelativeOrientation
]

{ #category : 'accessing' }
WDGFPhysicsHoldObjectConstraintComponent >> targetRelativeOrientation: anObject [

	targetRelativeOrientation := anObject
]

{ #category : 'accessing' }
WDGFPhysicsHoldObjectConstraintComponent >> targetRelativePosition [

	^ targetRelativePosition
]

{ #category : 'accessing' }
WDGFPhysicsHoldObjectConstraintComponent >> targetRelativePosition: anObject [

	targetRelativePosition := anObject
]
