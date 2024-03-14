Class {
	#name : #WDGFPhysicsAnchoredPairUnionConstraintComponent,
	#superclass : #WDGFPhysicsPairUnionConstraintComponent,
	#instVars : [
		'firstObjectLocalAnchorPoint',
		'secondObjectLocalAnchorPoint'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #accessing }
WDGFPhysicsAnchoredPairUnionConstraintComponent >> firstObjectLocalAnchorPoint [

	^ firstObjectLocalAnchorPoint
]

{ #category : #accessing }
WDGFPhysicsAnchoredPairUnionConstraintComponent >> firstObjectLocalAnchorPoint: anObject [

	firstObjectLocalAnchorPoint := anObject
]

{ #category : #initialization }
WDGFPhysicsAnchoredPairUnionConstraintComponent >> initialize [
	super initialize.
	firstObjectLocalAnchorPoint := secondObjectLocalAnchorPoint := Vector3 zeros.
]

{ #category : #accessing }
WDGFPhysicsAnchoredPairUnionConstraintComponent >> secondObjectLocalAnchorPoint [

	^ secondObjectLocalAnchorPoint
]

{ #category : #accessing }
WDGFPhysicsAnchoredPairUnionConstraintComponent >> secondObjectLocalAnchorPoint: anObject [

	secondObjectLocalAnchorPoint := anObject
]
