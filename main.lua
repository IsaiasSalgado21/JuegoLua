-- funciones principales para el movimiento y física
function love.load()
    -- Cargar imágenes de la animación
    sprites = {}
    for i = 0, 3 do
        sprites[i] = love.graphics.newImage("sprites/sprite_" .. i .. ".png")
    end
    
    -- Posición y velocidad inicial del personaje
    x = 100
    y = 100
    dx = 0
    dy = 0

    -- Ajustes de la física
    acceleration = 120 -- Aceleración
    friction = 3 -- Fricción
    maxSpeed = 100 -- Velocidad máxima

    currentFrame = 0
    totalFrames = 4
    timePerFrame = 0.2
    elapsedTime = 0
end

-- Función para actualizar
function love.update(dt)
    -- Movimiento horizontal
    if love.keyboard.isDown("right") then
        dx = math.min(dx + acceleration * dt, maxSpeed)
    elseif love.keyboard.isDown("left") then
        dx = math.max(dx - acceleration * dt, -maxSpeed)
    else
        -- Aplicar fricción
        dx = dx * (1 - friction * dt)
    end

    -- Movimiento vertical
    if love.keyboard.isDown("down") then
        dy = math.min(dy + acceleration * dt, maxSpeed)
    elseif love.keyboard.isDown("up") then
        dy = math.max(dy - acceleration * dt, -maxSpeed)
    else
        -- Aplicar fricción
        dy = dy * (1 - friction * dt)
    end

    -- Aplicar velocidad
    x = x + dx * dt
    y = y + dy * dt

    -- Actualizar la animación del sprite
    updateAnimation(dt)
end

-- Función para actualizar la animación del sprite
function updateAnimation(dt)
    -- Incrementar el tiempo transcurrido
    elapsedTime = elapsedTime + dt
    -- Si ha pasado el tiempo de un frame, avanzar al siguiente frame
    if elapsedTime >= timePerFrame then
        currentFrame = (currentFrame + 1) % totalFrames
        elapsedTime = 0 -- Reiniciar el contador
    end
end

-- Función para dibujar
function love.draw()
    -- Dibujar la animación del personaje
    love.graphics.draw(sprites[currentFrame], x, y) -- Usar el primer sprite por ahora
end
