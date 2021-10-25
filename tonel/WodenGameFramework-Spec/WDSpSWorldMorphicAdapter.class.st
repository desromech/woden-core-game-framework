"
I am a Spec2 morphic based adapter for presenting for a Woden World.
"
Class {
	#name : #WDSpSWorldMorphicAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'WodenGameFramework-Spec'
}

{ #category : #accessing }
WDSpSWorldMorphicAdapter class >> adaptingName [
	^ #WodenGameFrameworkWorldAdapter
]

{ #category : #factory }
WDSpSWorldMorphicAdapter >> buildWidget [
	| newWidget |

	newWidget := self worldMorphClass new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		wodenWorld: self presenter world;
		yourself.

	self presenter whenWorldChangedDo: [ :newWodenWorld | newWidget wodenWorld: newWodenWorld ].

	^ newWidget
]

{ #category : #hooks }
WDSpSWorldMorphicAdapter >> worldMorphClass [
	^ WDGFWorldMorph
]
