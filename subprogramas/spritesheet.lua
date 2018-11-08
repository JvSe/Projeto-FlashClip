local physics = require("physics")
physics.start()
physics.setGravity(1,0)

spritesheets = {}

function spritesheets.novo(img,sheetOptions,posX,posY)
    return {
        spritesheet = graphics.newImageSheet(img,sheetOptions),
        lugarX = posX,
        lugarY = posY,
    }

    
end

function spritesheets.desenhar(sprite,sequence,nome)
    local newSprite = display.newSprite(sprite.spritesheet,sequence)
    newSprite.x = sprite.lugarX
    newSprite.y = sprite.lugarY
    newSprite.xScale = 0.2
    newSprite.yScale = 0.2
    newSprite.myName = nome
    physics.addBody(newSprite,"dynamic",{ radius=15, bounce=0})

    return newSprite
end

return spritesheets