AudioSource = require './audio-source.coffee'
SoundCloudLoader = require './soundcloud-loader.coffee'


updateTrackInfo = (loader) ->
	track = loader.sound

	document.getElementById('infoImage').setAttribute('src', track.artwork_url ? track.user.avatar_url)

	artistLink = document.createElement('a')
	artistLink.setAttribute('href', track.user.permalink_url)
	artistLink.innerHTML = track.user.username
	infoArtist = document.getElementById('infoArtist')
	infoArtist.innerHTML = ''
	infoArtist.appendChild artistLink

	trackLink = document.createElement('a')
	trackLink.setAttribute('href', track.permalink_url)
	if track.kind is 'playlist'
		trackLink.innerHTML = track.tracks[loader.streamPlaylistIndex].title
	else
		trackLink.innerHTML = track.title
	infoTrack = document.getElementById('infoTrack')
	infoTrack.innerHTML = ''
	infoTrack.appendChild trackLink

	# Finally show the thing
	document.getElementById('trackInfo').style.display = 'flex'

	# add a hash to the URL so it can be shared or saved
	window.location.hash = track.permalink_url.substr(22)


window.onload = ->
	player = document.getElementById 'player'
	loader = new SoundCloudLoader player

	source = new AudioSource player


	loadTrack = (url) ->
		loader.loadStream url,
			(streamUrl) ->
				source.playStream streamUrl
				updateTrackInfo loader
			->
				# Error


	if window.location.hash
		loadTrack "https://soundcloud.com/#{window.location.hash.substr(1)}"


	submit = document.getElementById('submit')
	submit.onkeypress = (e) ->
		e ?= window.event
		if e.keyCode is 10 or e.keyCode is 13
			url = submit.value
			submit.value = ''
			loadTrack url






###
window.onload = function init() {

	var visualizer = new Visualizer();
	var player =  document.getElementById('player');
	var uiUpdater = new UiUpdater();
	var loader = new SoundCloudLoader(player,uiUpdater);

	var audioSource = new SoundCloudAudioSource(player);
	var form = document.getElementById('form');
	var loadAndUpdate = function(trackUrl) {
		
	};

	visualizer.init({
		containerId: 'visualizer',
		audioSource: audioSource
	});


	uiUpdater.toggleControlPanel();
	// on load, check to see if there is a track token in the URL, and if so, load that automatically
	if (window.location.hash) {
		var trackUrl = 'https://soundcloud.com/' + window.location.hash.substr(1);
		loadAndUpdate(trackUrl);
	}

	// handle the form submit event to load the new URL
	form.addEventListener('submit', function(e) {
		e.preventDefault();
		var trackUrl = document.getElementById('input').value;
		loadAndUpdate(trackUrl);
	});
	var toggleButton = document.getElementById('toggleButton')
	toggleButton.addEventListener('click', function(e) {
		e.preventDefault();
		uiUpdater.toggleControlPanel();
	});

	window.addEventListener("keydown", keyControls, false);
	 
	function keyControls(e) {
		switch(e.keyCode) {
			case 32:
				// spacebar pressed
				loader.directStream('toggle');
				break;
			case 37:
				// left key pressed
				loader.directStream('backward');
				break;
			case 39:
				// right key pressed
				loader.directStream('forward');
				break;
		}   
	}
};
###