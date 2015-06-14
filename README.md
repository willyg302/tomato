# tomato

A SoundCloud music visualizer, inspired by those YouTube channels (you know which ones). See it [here](http://willyg302.github.io/tomato/)!

> **NOTE**: tomato may not work in more recent browser versions due to an update in CORS handling for web audio. It has been confirmed to work in Chrome 40 and below.

## Developing

1. Install [ok](https://github.com/willyg302/ok)
2. [Register](https://developers.soundcloud.com/) as a SoundCloud developer
3. Make a file called `soundcloud.py` with the following contents:

   ```python
   client =  # Your SoundCloud API client key
   secret =  # Your SoundCloud API secret key
   ```

4. Run `ok`, then `http-server dist`, then visit `localhost:8080` in your browser
