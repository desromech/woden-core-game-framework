Class {
	#name : #WDGFCompoundCollisionShapeComponent,
	#superclass : #WDGFAbstractCollisionShapeComponent,
	#instVars : [
		'elements',
		'localBoundingBox'
	],
	#category : #'WodenGameFramework-Core-Components-Physics'
}

{ #category : #adding }
WDGFCompoundCollisionShapeComponent >> addShapeComponent: aShape [
	elements add: aShape.
	localBoundingBox insertBox: (aShape localBoundingBox transformedWith: aShape transform)
	
]

{ #category : #converting }
WDGFCompoundCollisionShapeComponent >> asValidCollisionShapeWithoutTransform [
	| compoundShape |
	compoundShape := WDCompoundCollisionShape new.
	elements do: [ :each |
		compoundShape addShape: each asValidCollisionShapeWithoutTransform withTransform: each transform
	].
	^ compoundShape
]

{ #category : #initialization }
WDGFCompoundCollisionShapeComponent >> initialize [
	super initialize.
	elements := OrderedCollection new.
	localBoundingBox := AABox empty.
]

{ #category : #testing }
WDGFCompoundCollisionShapeComponent >> isCompoundCollisionShapeComponent [
	^ true
]

{ #category : #accessing }
WDGFCompoundCollisionShapeComponent >> localBoundingBox [
	^ localBoundingBox
]
