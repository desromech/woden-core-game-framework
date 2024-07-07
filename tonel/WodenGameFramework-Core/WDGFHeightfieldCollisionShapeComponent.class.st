Class {
	#name : 'WDGFHeightfieldCollisionShapeComponent',
	#superclass : 'WDGFAbstractCollisionShapeComponent',
	#instVars : [
		'width',
		'depth',
		'scale',
		'data',
		'localBoundingBox'
	],
	#category : 'WodenGameFramework-Core-Components-Physics',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Physics'
}

{ #category : 'converting' }
WDGFHeightfieldCollisionShapeComponent >> asValidCollisionShapeWithoutTransform [
	^ WDHeightfieldCollisionShape new
		width: width;
		depth: depth;
		scale: scale;
		data: data;
		localBoundingBox: self localBoundingBox;
		yourself
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> data [

	^ data
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> data: anObject [

	data := anObject
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> depth [

	^ depth
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> depth: anObject [

	depth := anObject
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> localBoundingBox [
	| minHeight maxHeight |
	localBoundingBox ifNil: [
		minHeight := maxHeight := data first.
		data do: [ :eachHeight |
			minHeight := minHeight min: eachHeight.
			maxHeight := maxHeight max: eachHeight.
		].
	
		localBoundingBox := AABox min: (Vector3 x: 0 y: minHeight z: 0) * scale max: (Vector3 x: 1 y: maxHeight z: 1) * scale
	].
	^ localBoundingBox
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> scale [

	^ scale
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> scale: anObject [

	scale := anObject
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> width [

	^ width
]

{ #category : 'accessing' }
WDGFHeightfieldCollisionShapeComponent >> width: anObject [

	width := anObject
]
