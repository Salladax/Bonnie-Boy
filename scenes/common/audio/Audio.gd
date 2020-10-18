extends AudioStreamPlayer

## deverá ser um global chamado de Audio, responsável p

func play_audio(audio : AudioStream):
	stream_paused = false
	stream = audio
	play()

