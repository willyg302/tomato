class SoundCloudLoader
	constructor: (@player, @updater) ->
		id = '{{SOUNDCLOUD_APP_ID}}'
		@client_id = id
			.split ''
			.map (c) -> ((parseInt(c, 16) + 13) % 16).toString 16
			.join ''
		@sound = {}

	loadStream: (url, success, failure) ->
		SC.initialize {
			client_id: @client_id
		}
		SC.get '/resolve', { url: url }, (sound) =>
			if sound.errors
				failure sound.errors
					.map (error) -> error.error_message
					.join '\n'
			else
				@sound = sound
				if sound.kind is 'playlist'
					@playlistIndex = 0
					@streamUrl = =>
						@sound.tracks[@playlistIndex].stream_url + "?client_id=" + @client_id
				else
					@sound = sound
					@streamUrl = =>
						@sound.stream_url + "?client_id=" + @client_id
				success(@streamUrl)

	_update: ->
		if @playlistIndex >= 0 and @playlistIndex <= @sound.track_count - 1
			@player.setAttribute 'src', @streamUrl()
			@updater this
			@player.play()

	coast: ->
		if @sound.kind is 'playlist'
			@playlistIndex++
			@_update()

	toggle: ->
		if @player.paused
			@player.play()
		else
			@player.pause()

	forward: ->
		if @sound.kind is 'playlist'
			@playlistIndex = (@playlistIndex + 1) % @sound.track_count
			@_update()

	backward: ->
		if @sound.kind is 'playlist'
			@playlistIndex = (@playlistIndex - 1 + @sound.track_count) % @sound.track_count
			@_update()


module.exports = SoundCloudLoader
