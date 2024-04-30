"
I am a component that provides a collision shape.
"
Class {
	#name : #WDGFAbstractCollisionShapeComponent,
	#superclass : #WDGFActorComponent,
	#instVars : [
		'transform'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #testing }
WDGFAbstractCollisionShapeComponent class >> isAbstract [
	^ self == WDGFAbstractCollisionShapeComponent
]

{ #category : #notifications }
WDGFAbstractCollisionShapeComponent >> addedToActor: anActor [
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
WDGFAbstractCollisionShapeComponent >> asValidCollisionShape [
	| shapeWithoutTransform |
	shapeWithoutTransform := self asValidCollisionShapeWithoutTransform.
	transform isIdentity ifTrue: [ ^ shapeWithoutTransform ].

	^ WDCompoundCollisionShape new
		addShape: shapeWithoutTransform withTransform: transform;
		yourself
]

{ #category : #converting }
WDGFAbstractCollisionShapeComponent >> asValidCollisionShapeWithoutTransform [
	^ self subclassResponsibility
]

{ #category : #initialization }
WDGFAbstractCollisionShapeComponent >> initialize [
	super initialize.
	transform := TRSTransform3D identity.
]

{ #category : #testing }
WDGFAbstractCollisionShapeComponent >> isCompoundCollisionShapeComponent [
	^ false
]

{ #category : #accessing }
WDGFAbstractCollisionShapeComponent >> localBoundingBox [
	^ self subclassResponsibility
]

{ #category : #accessing }
WDGFAbstractCollisionShapeComponent >> transform [

	^ transform
]

{ #category : #accessing }
WDGFAbstractCollisionShapeComponent >> transform: anObject [

	transform := anObject
]
