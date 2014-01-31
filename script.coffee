$ ->
	sensor_selector = '.wpmcalc-sensor'
	display_selector = '.wpmcalc-display'

	typing = null
	currentTime = null
	wordTimer = null
	wpm = null
	charsTyped = null
	times = null

	setup = (w) ->
		typing = false
		currentTime = 0
		wordTimer = null
		wpm = null
		charsTyped = 0
		times = []
		$(sensor_selector).keypress (e) -> keypress(e)

	averageWPM = ->
		t = 0
		for time in times
			t += 6000/time
		Math.floor(t/times.length)

	resetTimer = ->
		if typing
			times.push currentTime/2
			charsTyped = 0
		clearInterval wordTimer
		wordTimer = null
		currentTime = 0
		wordTimer = setInterval ( -> currentTime += 1 ), 10

	stop = ->
		clearInterval wordTimer
		wordTimer = null
		currentTime = 0
		$(display_selector).text "Your average wpm is #{averageWPM()}"
		typing = false

	keypress = (e) ->
		char = String.fromCharCode(e.keyCode)

		if !typing
			resetTimer()
			typing = true

		charsTyped += 1

		if charsTyped == 12	
			resetTimer()
			$(display_selector).text('#{averageWPM()} WPM')
