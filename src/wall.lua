-- src/wall.lua
local collision = require("src.collision")

local wall = {}
local wallList = {}

function wall.create(x, y, width, height)
    table.insert(wallList, { x = x, y = y, width = width, height = height })
end

-- Resolver solo eje X
function wall.resolveX(player)
    for _, w in ipairs(wallList) do
        if collision.check(player, w) then
            if player.dx > 0 then
                player.x = w.x - player.width
            elseif player.dx < 0 then
                player.x = w.x + w.width
            end
            player.dx = 0
        end
    end
end

-- Resolver solo eje Y
function wall.resolveY(player)
    for _, w in ipairs(wallList) do
        if collision.check(player, w) then
            if player.dy > 0 then
                player.y = w.y - player.height
            elseif player.dy < 0 then
                player.y = w.y + w.height
            end
            player.dy = 0
        end
    end
end

function wall.draw()
    for _, w in ipairs(wallList) do
        love.graphics.setColor(100, 100, 100)
        love.graphics.rectangle("fill", w.x, w.y, w.width, w.height)
    end
    love.graphics.setColor(255,255,255)
end

return wall
