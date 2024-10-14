function love.load()
    x = 100
    y = 100
    boost = 0

    love.window.setMode(x, y)
end

function love.update(dt)
    boost = boost + 1
    if boost % 10 == 0 then
        x = x + 10
        y = y + 10
        love.window.setMode(x, y)
    end
end

function love.draw()
    love.graphics.print("width: " .. x .. "\nheight: " .. y, 10, 10)
    love.graphics.print("grower")
end