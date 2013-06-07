verses = ["The fear of the LORD is the beginning of wisdom all those who practice it have a good understanding His praise endures forever", "Thus says the LORD Let not the wise man boast in his wisdom let not the mighty man boast in his might let not the rich man boast in his riches but let him who boasts boast in this that he understands and knows me that I am the LORD who practices steadfast love justice and righteousness in the earth For in these things I delight declares the LORD", "Again Jesus spoke to them saying I am the light of the world Whoever follows me will not walk in darkness but will have the light of life"]
references = ["Psalm 111:10", "Jeremiah 9:23-24", "John 2:8"]

$ ->
	unsplit = null
	typing = null
	currentTime = null
	wordTimer = null
	wpm = null
	charsTyped = null
	times = null
	incorrectchars = null

	setup = (w) ->	
		unsplit = w
		text = unsplit.split(" ")
		html = ""
		typing = false
		currentTime = 0
		wordTimer = null
		wpm = null
		charsTyped = 0
		times = []
		incorrectchars = 0
		$("body").html "<div class='typeable'></div><span class='wpm'> 0 wpm </span><span class='wordTimer'></span><br><span class='incorrectchars'></span>"
		for word in text
			html += "<p class='word'>"
			for character in word
				html += "<span class='char'>#{character}</span>"
			html += "</p>"
			if word != text[text.length-1]
				html += "<p class='word'><span class='char'> </span></p>"

		$(".typeable").html html
		$(document).keypress (e) -> keypress(e)

	averageWPM = ->
		t = 0
		for time in times
			t += 6000/time
		Math.floor(t/times.length)

	resetTimer = ->
		if typing
			times.push currentTime/2
			$(".list").text times
		clearInterval wordTimer
		wordTimer = null
		currentTime = 0
		wordTimer = setInterval ( -> currentTime += 1 ), 10

	stop = ->
		clearInterval wordTimer
		wordTimer = null
		currentTime = 0
		$(".wpm").text "Your average wpm is #{averageWPM()}"
		$(".incorrectchars").text "You have a(n) #{Math.floor(100*(incorrectchars/unsplit.length))}% error rate"
		$("body").append("<br><span class='playagain'><a>Play Again?</a></span>")
		typing = false
		$(".playagain a").click ->
			showMenu()

	showMenu = ->
		$("body").html "<h1>Choose a verse</h1><div class='verseList'><ul></ul></div>"
		for verse, i in verses
			$(".verseList ul").append("<li><a id='#{i}'>#{references[i]}</a></li>")
		$(".verseList ul li a").click ->
			setup(verses[$(@).attr('id')])

	keypress = (e) ->
		char = String.fromCharCode(e.keyCode)

		if char == " "
			e.preventDefault()

		if char.toLowerCase() == $(".word:not(.typed) .char:not(.typed)").first().text().toLowerCase()
			if !typing
				resetTimer()
				typing = true

			$(".word:not(.typed) .char:not(.typed)").first().addClass("typed")

			charsTyped += 1
			if charsTyped == 12
				charsTyped = 0
				resetTimer()
				$(".wpm").text "#{Math.floor(6000/times[times.length-1])} wpm"
		else
			if typing and char.toLowerCase() != $(".word:not(.typed) .char:not(.typed)").first().text().toLowerCase()
				incorrectchars += 1
				$(".incorrectchars").text("#{incorrectchars} incorrect characters typed")

		if typing and $(".word:not(.typed)").first().find(".char:not(.typed)").length == 0
			$(".word:not(.typed)").first().addClass("typed")
			if $(".word:not(.typed)").length == 0
				stop()

	showMenu()
		
