"
I am a component that provides a collision object.
"
Class {
	#name : #WDGFCollisionObjectComponent,
	#superclass : #WDGFActorComponent,
	#instVars : [
		'restitutionCoefficient',
		'dynamicFrictionCoefficient',
		'staticFrictionCoefficient',
		'collisionObject'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #notifications }
WDGFCollisionObjectComponent >> addedToActor: anActor [
	super addedToActor: anActor.
	anActor collisionObjectComponent: self
]

{ #category : #accessing }
WDGFCollisionObjectComponent >> dynamicFrictionCoefficient [

	^ dynamicFrictionCoefficient
]

{ #category : #accessing }
WDGFCollisionObjectComponent >> dynamicFrictionCoefficient: anObject [

	dynamicFrictionCoefficient := anObject
]

{ #category : #initialization }
WDGFCollisionObjectComponent >> initialize [
	super initialize.
	restitutionCoefficient := 0.5.
	dynamicFrictionCoefficient := 0.5.
	staticFrictionCoefficient := 0.625.
	
]

{ #category : #'model updates' }
WDGFCollisionObjectComponent >> loadCollisionStateInto: aCollisionObject [
	owner ifNil: [ ^ self ].

	aCollisionObject transform: owner transform
]

{ #category : #'physics setup' }
WDGFCollisionObjectComponent >> privateConstructCollisionObject [
	collisionObject := self privateMakeCollisionObjectInstance.
	self setupCollisionObject.
	^ collisionObject
]

{ #category : #'physics setup' }
WDGFCollisionObjectComponent >> privateMakeCollisionObjectInstance [
	^ WDPCollisionObject new
]

{ #category : #hooks }
WDGFCollisionObjectComponent >> privateRegisterInWorld [
	| physicsSubsystem |
	physicsSubsystem := ownerWorld getOrCreateSubsystemWithClass: WDGFPhysicsSubsystem.
	self privateConstructCollisionObject.
	physicsSubsystem physicsWorld addCollisionObject: collisionObject
]

{ #category : #accessing }
WDGFCollisionObjectComponent >> restitutionCoefficient [

	^ restitutionCoefficient
]

{ #category : #accessing }
WDGFCollisionObjectComponent >> restitutionCoefficient: anObject [

	restitutionCoefficient := anObject
]

{ #category : #'model updates' }
WDGFCollisionObjectComponent >> saveCollisionStateFrom: aCollisionObject [
	owner ifNil: [ ^ self ].

	owner transform: aCollisionObject transform
]

{ #category : #'physics setup' }
WDGFCollisionObjectComponent >> setupCollisionObject [
	| shape |
	shape := (owner ifNotNil: [ owner collisionShapeComponent asValidCollisionShape ])
		ifNil: [ WDPNullCollisionShape uniqueInstance ].
	
	collisionObject
		model: self;
		shape: shape;
		restitutionCoefficient: restitutionCoefficient;
		staticFrictionCoefficient: staticFrictionCoefficient;
		dynamicFrictionCoefficient: dynamicFrictionCoefficient
]

{ #category : #accessing }
WDGFCollisionObjectComponent >> staticFrictionCoefficient [

	^ staticFrictionCoefficient
]

{ #category : #accessing }
WDGFCollisionObjectComponent >> staticFrictionCoefficient: anObject [

	staticFrictionCoefficient := anObject
]
