"
I am a component that provides a collision object.
"
Class {
	#name : 'WDGFCollisionObjectComponent',
	#superclass : 'WDGFActorComponent',
	#instVars : [
		'restitutionCoefficient',
		'dynamicFrictionCoefficient',
		'staticFrictionCoefficient',
		'collisionObject',
		'collisionGroup',
		'collisionResponseGroupMask'
	],
	#category : 'WodenGameFramework-Core-Components-Physics',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Physics'
}

{ #category : 'notifications' }
WDGFCollisionObjectComponent >> addedToActor: anActor [
	super addedToActor: anActor.
	anActor collisionObjectComponent: self
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> angularVelocity [
	^ collisionObject angularVelocity
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> angularVelocity: aVector3 [
	collisionObject angularVelocity: aVector3
]

{ #category : 'update' }
WDGFCollisionObjectComponent >> applyForce: force [
	collisionObject ifNotNil: [ collisionObject applyForce: force ]
]

{ #category : 'update' }
WDGFCollisionObjectComponent >> applyForce: force inPosition: position [
	collisionObject ifNotNil: [ collisionObject applyForce: force inPosition: position ]
]

{ #category : 'update' }
WDGFCollisionObjectComponent >> applyTorque: torque [
	collisionObject ifNotNil: [ collisionObject applyTorque: torque ]
]

{ #category : 'as yet unclassified' }
WDGFCollisionObjectComponent >> collisionActorExclusionSet: actorSet [
	| newExclusionSet |
	collisionObject ifNil: [ ^ self ].

	newExclusionSet := actorSet collect: [ :eachActor |
		eachActor collisionObjectComponent ifNotNil: [ :comp | comp collisionObject ]
	] thenSelect: [ :each | each notNil ].

	collisionObject collisionObjectExclusionSet: newExclusionSet.
	
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> collisionObject [
	^ collisionObject
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> dynamicFrictionCoefficient [

	^ dynamicFrictionCoefficient
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> dynamicFrictionCoefficient: anObject [

	dynamicFrictionCoefficient := anObject
]

{ #category : 'initialization' }
WDGFCollisionObjectComponent >> initialize [
	super initialize.
	restitutionCoefficient := 0.5.
	dynamicFrictionCoefficient := 0.5.
	staticFrictionCoefficient := 0.625.
	collisionGroup := WDPCollisionMasks defaultCollisionGroup.
	collisionResponseGroupMask := WDPCollisionMasks defaultCollisionResponseGroup.
	
]

{ #category : 'testing' }
WDGFCollisionObjectComponent >> isSolidCollision [
	^ true
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> linearVelocity [
	^ collisionObject linearVelocity
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> linearVelocity: aVector3 [
	collisionObject linearVelocity: aVector3
]

{ #category : 'model updates' }
WDGFCollisionObjectComponent >> loadCollisionStateInto: aCollisionObject deltaTime: deltaTime [
	owner ifNil: [ ^ self ].

	aCollisionObject transform: owner transform
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> mass [
	^ 0
]

{ #category : 'physics setup' }
WDGFCollisionObjectComponent >> privateConstructCollisionObject [
	collisionObject := self privateMakeCollisionObjectInstance.
	self setupCollisionObject.
	^ collisionObject
]

{ #category : 'physics setup' }
WDGFCollisionObjectComponent >> privateMakeCollisionObjectInstance [
	^ WDPCollisionObject new
]

{ #category : 'hooks' }
WDGFCollisionObjectComponent >> privateRegisterInWorld [
	self privateConstructCollisionObject.
	ownerWorld physicsSubsystem physicsWorld add: collisionObject
]

{ #category : 'hooks' }
WDGFCollisionObjectComponent >> privateUnregisterFromWorld [
	ownerWorld physicsSubsystem physicsWorld remove: collisionObject.
	collisionObject := nil
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> restitutionCoefficient [

	^ restitutionCoefficient
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> restitutionCoefficient: anObject [

	restitutionCoefficient := anObject
]

{ #category : 'model updates' }
WDGFCollisionObjectComponent >> saveCollisionStateFrom: aCollisionObject [
	owner ifNil: [ ^ self ].

	owner transform: aCollisionObject transform
]

{ #category : 'physics setup' }
WDGFCollisionObjectComponent >> setupCollisionObject [
	| shape |
	shape := (owner notNil and: [owner collisionShapeComponent notNil])
		ifTrue: [ owner collisionShapeComponent asValidCollisionShapeWithoutTransform ]
		ifFalse: [ WDNullCollisionShape uniqueInstance ].
	
	collisionObject
		model: self;
		shape: shape;
		restitutionCoefficient: restitutionCoefficient;
		staticFrictionCoefficient: staticFrictionCoefficient;
		dynamicFrictionCoefficient: dynamicFrictionCoefficient;
		collisionGroup: collisionGroup;
		collisionResponseGroupMask: collisionResponseGroupMask
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> staticFrictionCoefficient [

	^ staticFrictionCoefficient
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> staticFrictionCoefficient: anObject [

	staticFrictionCoefficient := anObject
]

{ #category : 'accessing' }
WDGFCollisionObjectComponent >> worldInertiaTensor [
	^ Matrix3x3 zeros
]
