local menu_pos = 0
local menu_entry_count = 4

local prev_pos
local cur_pos

snd_menu_select = love.audio.newSource("menu_select.ogg", "static")

local function round(num)
    return tonumber(string.format("%.0f", num))
end

local has_played = 0

local is_fullscreen = false
local function toggle_fullscreen()
    is_fullscreen = not is_fullscreen
    love.window.setFullscreen(is_fullscreen, "desktop")
end

local function draw_menu()
    for i=0,menu_entry_count - 1 do
        if i == round(menu_pos) then
            love.graphics.setColor(255,0,0)

            if love.keyboard.isDown("return") then
                if has_played == 0 then
                    love.audio.stop(snd_menu_select)
                    love.audio.play(snd_menu_select)
                    has_played = 1
                end
                love.graphics.setColor(255,255,0)

                if i == 2 then toggle_fullscreen() end
                if i == 3 then love.event.quit() end
            else
                has_played = 0
            end
        end

        love.graphics.print("option", 60, 60 + (20 * i))
        love.graphics.setColor(255,255,255)
    end
end

function love.draw()
    draw_menu()
    love.graphics.print("menu_pos: " .. round(menu_pos) .. " (".. menu_pos .. ")", 20, 20)
end

function love.update(dt)
    if love.keyboard.isDown("escape") then love.event.quit() end

    prev_pos = cur_pos
    cur_pos = love.mouse.getPosition()

    if menu_pos < 0 then menu_pos = 0 end
    if menu_pos > menu_entry_count - 1 then menu_pos = menu_entry_count - 1 end

    if love.keyboard.isDown("up") then
        love.mouse.setVisible(false)
        if menu_pos >= 0 then
            menu_pos = menu_pos - (dt * 10)
        end
    end

    if love.keyboard.isDown("down") then
        love.mouse.setVisible(false)
        if menu_pos <= menu_entry_count - 1 then
            menu_pos = menu_pos + (dt * 10)
        end
    end

    if cur_pos ~= prev_pos then
        love.mouse.setVisible(true)
    end
end
