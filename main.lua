-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- # Configurações Iniciais # --
local tilesets = require("subprogramas.tilesets")
local spritesheet = require("subprogramas.spritesheet")
local physics = require("physics")
local widget = require( "widget" )
physics.start()
physics.setGravity(0,10)
-- # Fim das confogurações # --

-- # Desenhando o cenario # --

    -- Backgroung --
local background = display.newImageRect('SciFi/BG_SciFi.png',500,280)
background.x = display.contentCenterX
background.y = display.contentCenterY
background.xScale = 1.2
    -- Fim Background --

local primeiroTileset = tilesets.novo('SciFi/solo1.png',76.8,25.6,35,290)
tilesets.desenhar(primeiroTileset,"solo")

local segundoTileset = tilesets.novo('SciFi/solo1.png',76.8,25.6,105,290)
tilesets.desenhar(segundoTileset,"solo")

local terceiroTileset = tilesets.novo('SciFi/solo1.png',76.8,25.6,220,290)
tilesets.desenhar(terceiroTileset,"solo")

local quartoTileset = tilesets.novo('SciFi/solo2-3.png',25.6,12.8,290,250)
tilesets.desenhar(quartoTileset,"solo")

local quintoTileset = tilesets.novo('SciFi/solo1.png',76.8,25.6,360,290)
tilesets.desenhar(quintoTileset,"solo")

local sextoTileset = tilesets.novo('SciFi/solo1.png',76.8,25.6,460,290)
tilesets.desenhar(sextoTileset,"solo")
-- # Fim Desenhando o cenario # --

-- # Desenhando o Sprite # --
local Robo_sheetOptions = 
{
    width = 177,
    height = 173,
    numFrames = 60,
    sheetContentWidth = 1771,
    sheetContentHeigth = 1042,
}

local Robo_sequences = {
    { --Robo Parado
        name='robo-idle',
        start=1,
        count=10,
        time=800,
    },
    { --Robo Correndo para Direita
        name='robo-andando-direita',
        start=21,
        count=8,
        time=600,
    },
    {
        name='robo-andando-esquerda',
        start=50,
        count=6,
        time=600,
    },
    {
        name='robo-pulando-direita',
        start=11,
        count=10,
        time=1000,
        loopCount = 1,
    },
}

local robo = spritesheet.novo('SciFi/Robo_SpriteSheet.png',Robo_sheetOptions,20,260)
local heroi = spritesheet.desenhar(robo,Robo_sequences,"heroi")
heroi:setSequence("robo-idle")
heroi:play()

-- # Fim Desenhando o Sprite # --

-- Botões -- 
local function andarDireita( event )
    if ( "ended" == event.phase ) then
        heroi:setSequence("robo-andando-direita")
        heroi:play()
        heroi:applyLinearImpulse( 0.01, 0, heroi.x, heroi.y )
    else
        heroi:applyLinearImpulse( 0, 0, heroi.x, heroi.y)
    end
end

local function andarEsquerda( event )
    if ( "ended" == event.phase ) then
        heroi:setSequence("robo-andando-esquerda")
        heroi:play()
        heroi:applyLinearImpulse( -0.01, 0, heroi.x, heroi.y )
    end
end

local function pular( event )
    heroi:setSequence("robo-andando-direita")
    if ( "ended" == event.phase ) then
        heroi:setSequence("robo-pulando-direita")
        heroi:play()
        heroi:applyLinearImpulse( 0, -0.03, heroi.x, heroi.y )
    end
end
 
local button1 = widget.newButton(
    {
        width = 40,
        height = 40,
        defaultFile = "SciFi/botao1-direita.png",
        onEvent = andarDireita
    }
)
 
-- Center the button
button1.x = 90
button1.y = 250
button1.alpha = 0.5

local button2 = widget.newButton(
    {
        width = 40,
        height = 40,
        defaultFile = "SciFi/botao1-esquerda.png",
        onEvent = andarEsquerda
    }
)
button2.x = 40
button2.y = 250
button2.alpha = 0.5

local button3 = widget.newButton(
    {
        width = 40,
        height = 40,
        defaultFile = "SciFi/botao1-pulopng.png",
        onEvent = pular
    }
)
button3.x = 400
button3.y = 250
button3.alpha = 0.5
-- # Fim Botões # --

heroi:addEventListener("tap",andarDireita)

