Class {
	#name : #WDGFPhysicsRopeConstraintComponent,
	#superclass : #WDGFPhysicsAnchoredPairUnionConstraintComponent,
	#instVars : [
		'length'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #initialization }
WDGFPhysicsRopeConstraintComponent >> initialize [
	super initialize.
	length := 1.0.
]

{ #category : #accessing }
WDGFPhysicsRopeConstraintComponent >> length [

	^ length
]

{ #category : #accessing }
WDGFPhysicsRopeConstraintComponent >> length: anObject [

	length := anObject
]

{ #category : #hooks }
WDGFPhysicsRopeConstraintComponent >> privateConstructPhysicsConstraint [
	physicsConstraint := WDPRopeConstraint new
		stiffness: stiffness;
		damping: damping;
		length: length;
		firstObject: firstObject;
		firstObjectLocalAnchorPoint: firstObjectLocalAnchorPoint;
		secondObject: secondObject;
		secondObjectLocalAnchorPoint: secondObjectLocalAnchorPoint;
		yourself

]
