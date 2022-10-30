Extension { #name : #WDGFWorld }

{ #category : #'*WodenGameFramework-Spec' }
WDGFWorld >> openInSpec [
	^ WDGFSpWorldPresenter new
		world: self;
		open
]

{ #category : #'*WodenGameFramework-Spec' }
WDGFWorld >> playInSpec [
	self beginPlay.
	^ WDGFSpWorldPresenter new
		world: self;
		playing: true;
		open
]
