class Visualizer
	init: (opts) ->
		@audioSource = opts.audioSource

		canvas = document.createElement 'canvas'
		canvas.width = 384
		canvas.height = 384
		@context = canvas.getContext '2d'
		document
			.getElementById opts.container
			.appendChild canvas

		@_draw()

	_draw: =>
		@context.clearRect 0, 0, 384, 384
		@context.fillStyle = '#000000'
		@context.lineCap = 'round'

		for i in [0..127]
			@context.save()
			@context.translate 192, 192
			magnitude = @audioSource.streamData[i]
			# No math here, just manual pixel twiddling
			#@context.rotate -Math.PI * (i + 95.3) / 79.5
			@context.rotate -0.039516888724399915 * i - 3.765959495435312
			@context.fillRect 0, 112, 2, magnitude / 4
			@context.restore()

		window.requestAnimationFrame @_draw


module.exports = Visualizer
