Extension { #name : #WDGFWorld }

{ #category : #'*WodenGameFramework-Spec' }
WDGFWorld >> openInSpec [
	^ WDGFSpWorldPresenter new
		world: self;
		openWithSpec
]
