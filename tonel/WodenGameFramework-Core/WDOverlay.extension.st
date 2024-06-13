Extension { #name : 'WDOverlay' }

{ #category : '*WodenGameFramework-Core' }
WDOverlay >> dispatchWodenGameFrameworkEvent: anEvent [
	(self respondsTo: anEvent inputEventMessageName) ifTrue: [ 
		self perform: anEvent inputEventMessageName with: anEvent
	]
]
