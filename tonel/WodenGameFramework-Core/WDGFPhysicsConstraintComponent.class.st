"
I am a component that represents a specific physics constraint.
"
Class {
	#name : #WDGFPhysicsConstraintComponent,
	#superclass : #WDGFActorComponent,
	#instVars : [
		'physicsConstraint'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #testing }
WDGFPhysicsConstraintComponent class >> isAbstract [
	^ self == WDGFPhysicsConstraintComponent
]

{ #category : #hooks }
WDGFPhysicsConstraintComponent >> privateConstructPhysicsConstraint [
	self subclassResponsibility
]

{ #category : #hooks }
WDGFPhysicsConstraintComponent >> privateRegisterInWorld [
	self privateConstructPhysicsConstraint.
	ownerWorld physicsSubsystem physicsWorld add: physicsConstraint
]

{ #category : #hooks }
WDGFPhysicsConstraintComponent >> privateUnregisterFromWorld [
	ownerWorld physicsSubsystem physicsWorld remove: physicsConstraint.
	physicsConstraint := nil.

]
