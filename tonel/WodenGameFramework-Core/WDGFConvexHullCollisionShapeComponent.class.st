Class {
	#name : 'WDGFConvexHullCollisionShapeComponent',
	#superclass : 'WDGFAbstractCollisionShapeComponent',
	#instVars : [
		'points',
		'localBoundingBox'
	],
	#category : 'WodenGameFramework-Core-Components-Physics',
	#package : 'WodenGameFramework-Core',
	#tag : 'Components-Physics'
}

{ #category : 'construction' }
WDGFConvexHullCollisionShapeComponent class >> withPoints: aListOfPoints [
	^ self new points: aListOfPoints; yourself
]

{ #category : 'converting' }
WDGFConvexHullCollisionShapeComponent >> asValidCollisionShapeWithoutTransform [
	^ WDConvexHullCollisionShape withPoints: points
]

{ #category : 'accessing' }
WDGFConvexHullCollisionShapeComponent >> localBoundingBox [
	^ localBoundingBox
]

{ #category : 'accessing' }
WDGFConvexHullCollisionShapeComponent >> points [

	^ points
]

{ #category : 'accessing' }
WDGFConvexHullCollisionShapeComponent >> points: aListOfPoints [
	points := aListOfPoints.
	localBoundingBox := AABox encompassing: points.
]
