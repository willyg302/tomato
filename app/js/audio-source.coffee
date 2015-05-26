class AudioSource
	constructor: (@player) ->
		audioContext = new (window.AudioContext or window.webkitAudioContext)
		@analyser = audioContext.createAnalyser()
		@analyser.fftSize = 256
		audioContext.createMediaElementSource(@player).connect(@analyser)
		@analyser.connect(audioContext.destination)

		@volume = 0
		@streamData = new Uint8Array 128

	_sampleAudioStream: ->
		@analyser.getByteFrequencyData @streamData
		# Calculate overall volume value (from first 80 bins)
		volume = 0
		for i in [0..79]
			volume += @streamData[i]
		@volume = volume

	playStream: (url) ->
		# Get input stream from audio element
		@player.addEventListener 'ended', ->
			@directStream 'coasting'
		@player.setAttribute 'src', url
		@player.play()
		# Loop samples
		setInterval =>
			@_sampleAudioStream()
		, 20


module.exports = AudioSource
