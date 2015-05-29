class AudioSource
	constructor: (@player, @loader) ->
		audioContext = new (window.AudioContext or window.webkitAudioContext)
		@analyser = audioContext.createAnalyser()
		#@analyser.fftSize = 4096  # Half this is the number of bins
		audioContext.createMediaElementSource(@player).connect(@analyser)
		@analyser.connect(audioContext.destination)
		@volume = 0
		@streamData = new Uint8Array @analyser.frequencyBinCount

	_sampleAudioStream: ->
		@analyser.getByteFrequencyData @streamData
		# Calculate overall volume value (from first 80 bins)
		volume = 0
		for i in [0..79]
			volume += @streamData[i]
		@volume = volume

	playStream: (url) ->
		# Get input stream from audio element
		@player.addEventListener 'ended', =>
			@loader.directStream 'coasting'
		@player.setAttribute 'src', url
		@player.play()
		# Loop samples
		setInterval =>
			@_sampleAudioStream()
		, 20


module.exports = AudioSource
