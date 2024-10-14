local track_snddata = love.sound.newSoundData("track.flac") -- create new sounddata from file
local track = love.audio.newSource(track_snddata, "stream")

local track_position = 0
local track_position_mins = 0 -- track position in whole minutes
local track_position_secs = 0 -- track position in seconds

-- some calculations for separate secs and mins...
local track_duration_mins = math.floor(track:getDuration("seconds") / 60)
local track_duration_secs = math.floor(track:getDuration("seconds")) - 60 * track_duration_mins

-- amplitude calculation from sample-point of current sample...
local samplepnt_a = 0
local samplepnt_b = 0
local amplitude_avg = 0
local amplitude_diff = 0

function love.load()
    love.audio.setVolume(0.1)
    love.audio.play(track)
end

function love.update(dt)
    -- mm:ss track_position conversion
    -- correct seconds if not starting from whole minute OR correct mins if seeking backwards
    if track_position_secs > 59 or track_position_mins * 60 >= track_position then
        track_position_mins = math.floor(track_position) / 60
    end

    track_position = track:tell("seconds")

    if track_snddata:getSample(track:tell("samples")) ^ 2 ~= samplepnt_a then
        samplepnt_b = samplepnt_a
        samplepnt_a = track_snddata:getSample(track:tell("samples")) ^ 2
        amplitude_avg = (tonumber(string.format("%.3f", samplepnt_a)) + tonumber(string.format("%.3f", samplepnt_b))) / 2
        amplitude_diff = math.abs(tonumber(string.format("%.3f", samplepnt_a)), tonumber(string.format("%.3f", samplepnt_b)))

        if amplitude_avg > 0.18 then amplitude_avg = 0.18 end
        if amplitude_diff > 0.18 then amplitude_diff = 0.18 end
    end

    -- grab whole minutes from current track position
    if math.floor(track_position + 0.5) % 60 == 0 then track_position_mins = math.floor(track_position + 0.5) / 60 end

    -- grab whole seconds from current track position, drop back to zero upon reaching other minute
    if math.floor(track_position + 0.5) > 59 then track_position_secs = math.floor(track_position + 0.5) - 60 * track_position_mins
    else track_position_secs = math.floor(track_position + 0.5) end
end

function love.draw()
    love.graphics.setColor(0, 1, 1)
    love.graphics.rectangle("fill", 225, 305, amplitude_avg * 2000, 20)
    love.graphics.setColor(1, 0.4, 0.4)
    love.graphics.rectangle("fill", 225, 360, amplitude_diff * 2000, 20)

    -- text display
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("audio_visualisation\n"
    .. string.format("%02d", track_position_mins) .. ":" .. string.format("%02d", track_position_secs)
    .. " / " .. string.format("%02d", track_duration_mins) .. ":" .. string.format("%02d", track_duration_secs), 20, 20)

    love.graphics.print("avg\n" .. amplitude_avg * 2000 .. "\n\n\ndifference\n" .. amplitude_diff * 2000 .. "", 50, 300)
end

function love.keypressed(key)
    if key == "space" then
        if track:isPlaying() then love.audio.pause(track)
        else love.audio.play(track) end
    end

    -- backwards seeking by 5 secs
    if key == "left" then
        if track_position - 5 < 0 then
            track:seek(0)
        else
            track:seek(track_position - 5)
        end
    end

    -- forwards seeking by 5 secs
    if key == "right" then
        if track_position + 5 > track:getDuration("seconds") then
            track:seek(track:getDuration("seconds"))
        else
            track:seek(track_position + 5)
        end
    end
end