"
I am a component that is used for listening for different input events.
"
Class {
	#name : #WDGFInputListenerComponent,
	#superclass : #WDGFActorComponent,
	#category : #'WodenGameFramework-Core-Components-Input'
}

{ #category : #'event dispatching' }
WDGFInputListenerComponent >> dispatchInputEvent: anInputEvent [
	owner ifNotNil: [ owner send: anInputEvent inputEventMessageName with: anInputEvent ]
]

{ #category : #hooks }
WDGFInputListenerComponent >> privateRegisterInWorld [
	ownerWorld inputSubsystem registerInputListener: self

]

{ #category : #hooks }
WDGFInputListenerComponent >> privateUnregisterFromWorld [
	ownerWorld inputSubsystem unregisterInputListener: self

]
