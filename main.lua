function love.load()
	time = 0
end
function love.update(dt)
	time = dt + time
end
function love.draw()
	love.graphics.print("Hello World " .. time, 400, 250)
end
