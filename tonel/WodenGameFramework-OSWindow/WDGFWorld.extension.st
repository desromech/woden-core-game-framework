Extension { #name : #WDGFWorld }

{ #category : #'*WodenGameFramework-OSWindow' }
WDGFWorld >> openInOSWindow [
	^ WDGFWorldOSWindow new
		wodenWorld: self;
		open
]

{ #category : #'*WodenGameFramework-OSWindow' }
WDGFWorld >> playInOSWindow [
	self beginPlay.
	^ WDGFWorldOSWindow new
		wodenWorld: self;
		open
]
