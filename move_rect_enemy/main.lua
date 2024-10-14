local enemies = {}
local enemy_count = 0
local x = 200
local y = 200
local boost = 0

function spawnEnemy()
    local enemy = {}
    enemy.x = love.math.random(200, 1080)
    enemy.y = love.math.random(200, 520)
    enemy.width = 20
    enemy.height = 20
    enemy.removed = false
    table.insert(enemies, enemy)
    enemy_count = enemy_count + 1
end

function love.load()
    spawnEnemy()
    spawnEnemy()
    spawnEnemy()
    spawnEnemy()
    spawnEnemy()
end

function love.update(dt)
    for i=#enemies, 1, -1 do
        local enemy = enemies[i]
        if not enemy.removed then
            -- update enemy
            if love.math.random(1, 2) == 1 then
                enemies[i].x = enemies[i].x + love.math.random(50, 150) * dt
                enemies[i].y = enemies[i].y - love.math.random(50, 150) * dt
            else
                enemies[i].x = enemies[i].x - love.math.random(50, 150) * dt
                enemies[i].y = enemies[i].y + love.math.random(50, 150) * dt
            end
        else table.remove(enemies, i) end
    end

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
    love.graphics.print("rect_x: " .. x .. "\nrect_y: " .. y .. "\nboost: " .. boost .. "\nmouse_x: " .. mx .. "\nmouse_y: " .. my .. "\nenemy_count: " .. enemy_count, 20, 20)

    -- the actual graphics stuff
    love.graphics.rectangle("line", x, y, 50, 50)

    love.graphics.setColor(1, 0, 0)
    if love.mouse.isDown(1) then
        love.graphics.line(x + 25, y + 25, mx, my)

        for i=#enemies, 1, -1 do
            local enemy = enemies[i]
            if (love.mouse.getX() >= enemy.x and love.mouse.getX() <= enemy.x + 20) and (love.mouse.getY() >= enemy.y and love.mouse.getY() <= enemy.y + 20) then
                enemies[i].removed = true
                enemy_count = enemy_count -1
            end
        end
    end

    love.graphics.setColor(1, 1, 0)
    for i=#enemies, 1, -1 do
        local enemy = enemies[i]
        -- draw stuff
        love.graphics.rectangle("line", enemy.x, enemy.y, enemy.width, enemy.height)
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 2 then spawnEnemy() end
end