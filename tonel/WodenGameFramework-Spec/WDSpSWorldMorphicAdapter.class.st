"
I am a Spec2 morphic based adapter for presenting for a Woden World.
"
Class {
	#name : #WDSpSWorldMorphicAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'WodenGameFramework-Spec'
}

{ #category : #factory }
WDSpSWorldMorphicAdapter >> buildWidget [
	| newWidget |

	newWidget := self worldMorphClass new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		wodenWorld: self presenter wodenWorld;
		camera: self presenter camera;
		yourself.

	self presenter whenWorldChangedDo: [ :newWodenWorld | newWidget wodenWorld: newWodenWorld ].

	^ newWidget
]

{ #category : #hooks }
WDSpSWorldMorphicAdapter >> worldMorphClass [
	^ WDGFWorldMorph
]
