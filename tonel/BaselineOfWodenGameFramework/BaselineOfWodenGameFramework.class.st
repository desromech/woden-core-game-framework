Class {
	#name : #BaselineOfWodenGameFramework,
	#superclass : #BaselineOf,
	#category : #BaselineOfWodenGameFramework
}

{ #category : #baselines }
BaselineOfWodenGameFramework >> baseline: spec [
    <baseline>
	spec for: #'common' do: [
		spec
			baseline: #'WodenSceneGraph' with: [ spec repository: 'github://desromech/woden-core-scene-graph' ];
			baseline: #'WodenCorePhysics' with: [ spec repository: 'github://desromech/woden-core-physics' ];

			package: #'WodenGameFramework-Core' with: [
				spec requires: #( #'WodenSceneGraph' #'WodenCorePhysics' #'OpenAL').
			];
			package: #'WodenGameFramework-Core-Tests' with: [
				spec requires: #( #'WodenGameFramework-Core' ).
			];
			package: #'WodenGameFramework-Morphic' with: [];
			package: #'WodenGameFramework-Examples' with: []
	].

	spec for: #pharo do: [
		spec
			baseline: #'OpenAL' with: [ spec repository: 'github://desromech/pharo-openal' ];

			package: #'WodenGameFramework-Bloc' with: [
				spec requires: #( #'WodenGameFramework-Core')
			];
			package: #'WodenGameFramework-Bloc-Examples' with: [
				spec requires: #( #'WodenGameFramework-Bloc')
			];
			package: #'WodenGameFramework-OpenAL' with: [
				spec requires: #( #'WodenGameFramework-Core' #'OpenAL')
			];
			package: #'WodenGameFramework-OSWindow' with: [
				spec requires: #( #'WodenGameFramework-Core')
			];
			package: #'WodenGameFramework-Spec' with: [
				spec requires: #( #'WodenGameFramework-Core' #'WodenGameFramework-Morphic').
			]
	].

]
