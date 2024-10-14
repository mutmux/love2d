function love.load()
    x = 100
    y = 100
    boost = 0

    -- yoink screen area for window confinement
    love.window.setMode(0, 0)
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
    love.window.setMode(250, 250)
end

function love.update(dt)
    -- keep window confined to screen
    if x < 0 then x = 0 end
    if x > screen_width - 250 then x = screen_width - 250 end
    if y < 0 then y = 0 end
    if y > screen_height - 250 then y = screen_height - 250 end

    love.window.setPosition(x, y, 1)

    if love.keyboard.isDown('lshift') then boost = 400 else boost = 0 end

    if love.keyboard.isDown('w') then
        y = y - (400 + boost) * dt
    end

    if love.keyboard.isDown('s') then
        y = y + (400 + boost) * dt
    end

    if love.keyboard.isDown('a') then
        x = x - (400 + boost) * dt
    end

    if love.keyboard.isDown('d') then
        x = x + (400 + boost) * dt
    end
end

function love.draw()
    love.graphics.print("x: " .. x .. "\ny: " .. y, 10, 10)
    love.graphics.print("moist")
end