-- Módulo para simular uma "class" para ter um programa "OOP" kkk
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

tilesets = {}

function tilesets.novo(img,width,height,posX,posY)
    return {
        image = display.newImageRect(img,width,height),
        lugarX = posX,
        lugarY = posY,
    }
end

function tilesets.desenhar(tileset,nome)
    local desenho = tileset.image
    desenho.x = tileset.lugarX
    desenho.y = tileset.lugarY
    desenho.myName = nome
    physics.addBody(desenho,"static")
end

return tilesets