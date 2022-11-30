"
I am a component that is used for listening for different input events.
"
Class {
	#name : #WDGFInputListenerComponent,
	#superclass : #WDGFActorComponent,
	#category : #'WodenGameFramework-Core-Actor'
}

{ #category : #'event dispatching' }
WDGFInputListenerComponent >> dispatchInputEvent: anInputEvent [
	owner ifNotNil: [ owner send: anInputEvent inputEventMessageName with: anInputEvent ]
]

{ #category : #hooks }
WDGFInputListenerComponent >> privateRegisterInWorld [
	| inputSubsystem |
	inputSubsystem := ownerWorld getOrCreateSubsystemWithClass: WDGFInputSubsystem.
	inputSubsystem registerInputListener: self

]
