"
I am a component that provides a collision shape.
"
Class {
	#name : #WDGFCollisionShapeComponent,
	#superclass : #WDGFActorComponent,
	#instVars : [
		'transform'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #testing }
WDGFCollisionShapeComponent class >> isAbstract [
	^ self == WDGFCollisionShapeComponent
]

{ #category : #notifications }
WDGFCollisionShapeComponent >> addedToActor: anActor [
	super addedToActor: anActor.
	anActor collisionShapeComponent ifNotNil: [ :rootShapeComponent |
		rootShapeComponent isCompoundCollisionShapeComponent ifTrue: [
			rootShapeComponent addShapeComponent: self
		] ifFalse: [
			| compoundShape |
			compoundShape := WDGFCompoundCollisionShapeComponent new
				addShapeComponent: rootShapeComponent;
				addShapeComponent: self;
				yourself.
			anActor
				addComponent: compoundShape noCheckBefore: rootShapeComponent;
				collisionShapeComponent: compoundShape
		].
	] ifNil: [ 
		anActor collisionShapeComponent: self
	]
]

{ #category : #converting }
WDGFCollisionShapeComponent >> asValidCollisionShape [
	| shapeWithoutTransform |
	shapeWithoutTransform := self asValidCollisionShapeWithoutTransform.
	transform isIdentity ifTrue: [ ^ shapeWithoutTransform ].

	^ WDPCompoundCollisionShape new
		addShape: shapeWithoutTransform withTransform: transform;
		yourself
]

{ #category : #converting }
WDGFCollisionShapeComponent >> asValidCollisionShapeWithoutTransform [
	^ self subclassResponsibility
]

{ #category : #initialization }
WDGFCollisionShapeComponent >> initialize [
	super initialize.
	transform := TRSTransform3D identity.
]

{ #category : #testing }
WDGFCollisionShapeComponent >> isCompoundCollisionShapeComponent [
	^ false
]

{ #category : #accessing }
WDGFCollisionShapeComponent >> localBoundingBox [
	^ self subclassResponsibility
]

{ #category : #accessing }
WDGFCollisionShapeComponent >> transform [

	^ transform
]

{ #category : #accessing }
WDGFCollisionShapeComponent >> transform: anObject [

	transform := anObject
]
