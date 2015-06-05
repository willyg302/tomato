class AudioSource
	constructor: (@player, @loader) ->
		audioContext = new (window.AudioContext or window.webkitAudioContext)
		@analyser = audioContext.createAnalyser()
		audioContext.createMediaElementSource(@player).connect(@analyser)
		@analyser.connect(audioContext.destination)
		@volume = 0
		@streamData = new Uint8Array @analyser.frequencyBinCount

	_sampleAudioStream: ->
		@analyser.getByteFrequencyData @streamData
		# Calculate overall volume value (from first 80 bins)
		#@volume = @streamData
		#	.slice 0, 80
		#	.reduce (a, b) -> a + b

	playStream: (url) ->
		# Get input stream from audio element
		@player.addEventListener 'ended', =>
			@loader.coast()
		@player.setAttribute 'src', url
		@player.play()
		# Loop samples
		setInterval =>
			@_sampleAudioStream()
		, 20


module.exports = AudioSource
