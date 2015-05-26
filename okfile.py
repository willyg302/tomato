project = 'tomato'

def sub_key():
	import imp
	soundcloud = imp.load_source('soundcloud', './soundcloud.py')
	app_id = ''.join([hex((int(c, 16) + 3) % 16)[2:] for c in soundcloud.client])
	with open('dist/main.js', 'r+') as f:
		data = f.read().replace('{{SOUNDCLOUD_APP_ID}}', app_id)
		f.seek(0)
		f.write(data)
		f.truncate()

def install():
	ok.npm('install').bower('install', root='app')

def default():
	ok.node('gulp', module=True).run(sub_key)
