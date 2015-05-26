class SoundCloudLoader
	constructor: (@player, @updater) ->
		id = '{{SOUNDCLOUD_APP_ID}}'
		@client_id = id
			.split ''
			.map (c) -> ((parseInt(c, 16) + 13) % 16).toString 16
			.join ''
		@sound = {}
		@errorMessage = ''

	loadStream: (url, success, failure) ->
		SC.initialize {
			client_id: @client_id
		}
		SC.get '/resolve', { url: url }, (sound) =>
			if sound.errors
				@errorMessage = 'Something bad happened'
				#for (var i = 0; i < sound.errors.length; i++) {
					#self.errorMessage += sound.errors[i].error_message + '<br>';
				#}
				failure()
			else
				@sound = sound
				if sound.kind is 'playlist'
					@streamPlaylistIndex = 0
					streamUrl = @sound.tracks[@streamPlaylistIndex].stream_url + "?client_id=" + @client_id
				else
					@sound = sound
					streamUrl = @sound.stream_url + "?client_id=" + @client_id
				success(streamUrl)


	directStream: (direction) ->
		if direction is 'toggle'
			if @player.paused
				@player.play()
			else
				@player.pause()
		else if @sound.kind is 'playlist'
			if direction is 'coasting'
				@streamPlaylistIndex++
			else if direction is 'forward'
				if @streamPlaylistIndex >= @sound.track_count - 1
					@streamPlaylistIndex = 0
				else
					@streamPlaylistIndex++
			else
				if @streamPlaylistIndex <= 0
					@streamPlaylistIndex = @sound.track_count - 1
				else
					@streamPlaylistIndex--
			if @streamPlaylistIndex >= 0 and @streamPlaylistIndex <= @sound.track_count - 1
				@player.setAttribute 'src', @streamUrl()
				#@updater.update this
				@player.play()


module.exports = SoundCloudLoader
