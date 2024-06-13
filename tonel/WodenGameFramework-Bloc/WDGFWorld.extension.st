Extension { #name : 'WDGFWorld' }

{ #category : '*WodenGameFramework-Bloc' }
WDGFWorld >> openInBlocSpace [
	^ WDBlGFWorldElement new
		wodenWorld: self;
		openInSpace
]

{ #category : '*WodenGameFramework-Bloc' }
WDGFWorld >> playInBlocSpace [
	self beginPlay.
	^ WDBlGFWorldElement new
		wodenWorld: self;
		playing: true;
		openInSpace
]
