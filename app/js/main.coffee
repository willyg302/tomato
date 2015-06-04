AudioSource = require './audio-source.coffee'
SoundCloudLoader = require './soundcloud-loader.coffee'
Visualizer = require './visualizer.coffee'


plyr.setup {
	controls: ['restart', 'play', 'current-time', 'duration', 'mute', 'volume']
}


updateTrackInfo = (loader) ->
	track = loader.sound

	document
		.getElementById 'infoImage'
		.setAttribute 'src', track.artwork_url ? track.user.avatar_url

	addLink = (href, inner, parent) ->
		link = document.createElement 'a'
		link.setAttribute 'href', href
		link.innerHTML = inner
		pElem = document.getElementById parent
		pElem.innerHTML = ''
		pElem.appendChild link

	artist = track.user.username
	if track.kind is 'playlist'
		artist += " [#{track.title}]"
	addLink track.user.permalink_url, artist, 'infoArtist'

	song = if track.kind is 'playlist' then track.tracks[loader.streamPlaylistIndex].title else track.title
	addLink track.permalink_url, song, 'infoTrack'

	# add a hash to the URL so it can be shared or saved
	window.location.hash = track.permalink_url.substr(22)


window.onload = ->
	document.body.className = ''
	player = document.getElementById 'player'
	loader = new SoundCloudLoader player, updateTrackInfo
	source = new AudioSource player, loader
	visualizer = new Visualizer 'visualizer', source


	loadTrack = (url) ->
		loader.loadStream url,
			(streamUrl) ->
				source.playStream streamUrl()
				updateTrackInfo loader
				document.body.className = 'playing'
			->
				# Error


	if window.location.hash
		loadTrack "https://soundcloud.com/#{window.location.hash.substr(1)}"


	submit = document.getElementById 'submit'
	submit.onkeypress = (e) ->
		e.stopPropagation()
		switch e.keyCode
			when 10, 13
				url = submit.value
				submit.value = ''
				loadTrack url


	keyboardControls = (e) ->
		switch e.keyCode
			when 32
				# Space
				loader.directStream 'toggle'
			when 37
				# Left arrow
				loader.directStream 'backward'
			when 39
				# Right arrow
				loader.directStream 'forward'

	window.addEventListener 'keydown', keyboardControls, false


###
@TODO
  - Error messages
  - Music vis!
  - Beat detection...? :D  http://www.airtightinteractive.com/2013/10/making-audio-reactive-visuals/
  - Dynamic images
  - Analytics
  - Fix CORS
    http://jsfiddle.net/thebigfeel/f8xn99wq/
    https://twitter.com/therealbigfeel/status/592454329962926080
  - Integrate plyr
    To be able to play a buffer maybe have to hook into https://github.com/Ircam-RnD/player
  - This code is so tightly coupled agh
###
