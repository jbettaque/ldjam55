local function randomizeTable(tbl)
	local rnd = {}
	table.sort(tbl, function(a, b)
		rnd[a] = rnd[a] or math.random()
		rnd[b] = rnd[b] or math.random()
		return rnd[a] > rnd[b]
	end)
end

function love.conf(t)
	-- make randomness actually random by using the current time as seed
	math.randomseed(os.time())

	-- define and randomize window title
	TITLE_WORDS = { "Mass", "Move", "Minion", "Magic" }
	randomizeTable(TITLE_WORDS)
	t.window.title = table.concat(TITLE_WORDS, " ")

	-- configure love
	t.version = "11.4"
	t.identity = "MassMoveMinionMagic"
	t.window.resizable = true
	t.modules.joystick = false
	t.modules.touch = false
	t.console = false
end
