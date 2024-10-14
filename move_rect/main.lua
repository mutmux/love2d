function love.load()
    x = 200
    y = 200
    boost = 0
end

function love.update(dt)
    if love.keyboard.isDown('lshift') then
        boost = 200
    else
        boost = 0
    end

    if love.keyboard.isDown('w') then
        y = y - (200 + boost) * dt
    end
    if love.keyboard.isDown('s') then
        y = y + (200 + boost) * dt
    end
    if love.keyboard.isDown('a') then
        x = x - (200 + boost) * dt
    end
    if love.keyboard.isDown('d') then
        x = x + (200 + boost) * dt
    end
end

function love.draw()
    local mx, my = love.mouse.getPosition() -- cur mouse pos

    love.graphics.setColor(1, 1, 1)
    -- informative
    love.graphics.print("rect_x: " .. x .. "\nrect_y: " .. y .. "\nboost: " .. boost, 20, 20)

    -- the actual graphics stuff
    love.graphics.rectangle("line", x, y, 50, 50)

    if love.mouse.isDown(1) then
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(x + 25, y + 25, mx, my)
    end
end