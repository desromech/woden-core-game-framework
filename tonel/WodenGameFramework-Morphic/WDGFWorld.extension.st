Extension { #name : 'WDGFWorld' }

{ #category : '*WodenGameFramework-Morphic' }
WDGFWorld >> openInMorphic [
	^ WDGFWorldMorph new
		wodenWorld: self;
		openInWindow
]

{ #category : '*WodenGameFramework-Morphic' }
WDGFWorld >> openInWindow [
	^ self openInMorphic
]

{ #category : '*WodenGameFramework-Morphic' }
WDGFWorld >> playInMorphic [
	self beginPlay.
	^ WDGFWorldMorph new
		wodenWorld: self;
		playing: true;
		openInWindow
]

{ #category : '*WodenGameFramework-Morphic' }
WDGFWorld >> playInWindow [
	(self respondsTo: #playInOSWindow) ifTrue: [ ^ self playInOSWindow ].
	^ self playInMorphic
]
