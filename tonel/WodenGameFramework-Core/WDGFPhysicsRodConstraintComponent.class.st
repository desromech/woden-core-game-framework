Class {
	#name : #WDGFPhysicsRodConstraintComponent,
	#superclass : #WDGFPhysicsAnchoredPairUnionConstraintComponent,
	#instVars : [
		'length'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #initialization }
WDGFPhysicsRodConstraintComponent >> initialize [
	super initialize.
	length := 1.0.
]

{ #category : #accessing }
WDGFPhysicsRodConstraintComponent >> length [

	^ length
]

{ #category : #accessing }
WDGFPhysicsRodConstraintComponent >> length: anObject [

	length := anObject
]

{ #category : #hooks }
WDGFPhysicsRodConstraintComponent >> privateConstructPhysicsConstraint [
	physicsConstraint := WDPRodConstraint new
		stiffness: stiffness;
		damping: damping;
		length: length;
		firstObject: firstObject;
		firstObjectLocalAnchorPoint: firstObjectLocalAnchorPoint;
		secondObject: secondObject;
		secondObjectLocalAnchorPoint: secondObjectLocalAnchorPoint;
		yourself

]
