--suma con variables
a=5
b=8
print(a+b)

-- juntar strings con variables de tipo texto
nombre = "isaias salgado"
edad = "22"
print("hola, mi nombre es " .. nombre .. " mi edad es de " .. edad) 
--[[comentario 
de varias 
lineas en lua]]
print("----------------------------")
-- funciones pasar un parametro 
function saludo(num)
    print("hola, me gusta el numero "..num)
end

saludo(23)
saludo(24)
saludo(67)
-- funcion que devulve un valor con return
function dameCinco()
    return 5
end
cinco = dameCinco()
print(cinco)

--funcion que recibe argumentos y regresa la suma
function suma(x, y)
    return x + y
end
print(suma(232,89))

print("----------------------------")

--[[funcion para dibujar un hola mundo en love2d
function love.draw()
    love.graphics.print("Hello World!", 400, 300)
    end

--funcion para dibujar un rectangulo con color por dentro
function love.draw()
    love.graphics.rectangle("fill", 100, 200, 50, 90)
end
]]


--funciones principales para el movimiento
function love.load()
    x = 100
end
--con esta funcion se va a estar actualizando la coordenada x de nuestro rectangulo
function love.update()
    x = x + 5
end
--funcion para dibujar un rectangulo con lineas de color
function love.draw()
    love.graphics.rectangle("line", x, 50, 200, 150)
end


