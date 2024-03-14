Class {
	#name : #WDGFPhysicsPairUnionConstraintComponent,
	#superclass : #WDGFPhysicsConstraintComponent,
	#instVars : [
		'stiffness',
		'firstObject',
		'secondObject'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #accessing }
WDGFPhysicsPairUnionConstraintComponent >> firstObject [

	^ firstObject
]

{ #category : #accessing }
WDGFPhysicsPairUnionConstraintComponent >> firstObject: anObject [

	firstObject := anObject
]

{ #category : #initialization }
WDGFPhysicsPairUnionConstraintComponent >> initialize [
	super initialize.
	stiffness := 50.0.
]

{ #category : #accessing }
WDGFPhysicsPairUnionConstraintComponent >> secondObject [

	^ secondObject
]

{ #category : #accessing }
WDGFPhysicsPairUnionConstraintComponent >> secondObject: anObject [

	secondObject := anObject
]

{ #category : #accessing }
WDGFPhysicsPairUnionConstraintComponent >> stiffness [

	^ stiffness
]

{ #category : #accessing }
WDGFPhysicsPairUnionConstraintComponent >> stiffness: anObject [

	stiffness := anObject
]
