-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- CARREGANDO AS BIBLIOTECAS DO CORONA -- 
local physics = require( "physics" )
local widget = require("widget")
physics.start()

-- DESENHANDO O BACKGROUND --
local background = display.newImageRect('SciFi/BG_SciFi.png',1500,280)
background.x = 0
background.y = display.contentCenterY


local background2= display.newImageRect('SciFi/BG_SciFi.png',1500,280)
background2.x = 1500
background2.y = display.contentCenterY
-- ###################### --

-- DESENHANDO O SOLO -- 
local solo = display.newImage('SciFi/solo.png')
solo.x = 0
solo.y = 295
solo.xScale = 0.8
solo.yScale = 0.3
physics.addBody(solo,"static")


local solo2 = display.newImage('SciFi/solo.png')
solo2.x = 1500
solo2.y = 295
solo2.xScale = 0.8
solo2.yScale = 0.3
physics.addBody(solo2,"static")
-- ################ --

-- CONFIGURANDO OS SPRITES -- 
local sheetOptions = 
{ 
    width = 177, 
    height = 173, 
    numFrames = 60 
}

    -- # CARREGANDO A SPRITESHEET # --
local sheet = graphics.newImageSheet( "SciFi/Robo_SpriteSheet.png", sheetOptions )
    -- #            #             # --

    -- # DEFININDO AS ANIMAÇÕES COM O NOME DE "sequencesNOME_DA_ANIMACAO" # --
local sequencesParado = {
    {
        name = "parado",
        start = 1,
        count = 10,
        time = 500,
    }
    
}

local sequencesCorrendo = {
    { 
        name = "correndo",
        start = 21,
        count = 8,
        time = 500,
        loopCount = 0,
        loopDirection = "forward"
    }

}

local sequencesPulando = {
    {
        name = "pulando",
        start = 11,
        count = 10,
        time = 500,
        loopCount = 1
    }
}
    -- #                                    #                               # -- 

    -- # DESENHANDO O SPRITE(ANIMAÇÃO) NA TELA # --
local heroiParado = display.newSprite( sheet, sequencesParado )
heroiParado.x = 20
heroiParado.y = 253
heroiParado.xScale = 0.3
heroiParado.yScale = 0.3
heroiParado:setSequence("parado")
heroiParado:play()

local heroiCorrendo = display.newSprite( sheet, sequencesCorrendo )
heroiCorrendo.x = 20
heroiCorrendo.y = 253
heroiCorrendo.xScale = 0.3
heroiCorrendo.yScale = 0.3
heroiCorrendo.isVisible = false

local heroiPulando = display.newSprite(sheet, sequencesPulando)
heroiPulando.x = 20
heroiPulando.y = 253
heroiPulando.xScale = 0.3
heroiPulando.yScale = 0.3
heroiPulando.isVisible = false
physics.addBody( heroiPulando, "dynamic", { radius=0, bounce=0.3 } )
    -- #                #                      # -- 

    -- # ANIMAÇÃO DA TELA EM MOVIMENTO # --
local tPrevious = system.getTimer()
local function move(event)
    
    local tDelta = event.time - tPrevious
    tPrevious = event.time

    local xOffset = ( 0.2 * tDelta )
    background.x = background.x - xOffset
    background2.x = background2.x - xOffset
    solo.x = solo.x - xOffset
    solo2.x = solo2.x - xOffset
   

    if (background.x + background.contentWidth) < 0 then
        background:translate( 1500 * 2, 0)
        solo:translate(1500 * 2, 0)
        
    end
    if (background2.x + background2.contentWidth) < 0 then
        background2:translate( 1500 * 2, 0)
        solo2:translate(1500 * 2, 0)
        
    end
    
end
    -- #                #               # --


    -- # FUNÇÕES PARA A MAGICA ACONTECER # --
local function iniciar( event )
    heroiParado.isVisible = false
    heroiCorrendo.isVisible = true
    heroiCorrendo:setSequence("correndo")
    heroiCorrendo:play()
    
    Runtime:addEventListener("enterFrame",move)
end

local function andar()
    heroiPulando.isVisible = false
    heroiCorrendo.isVisible = true
    heroiCorrendo:setSequence("correndo")
    heroiCorrendo:play()
end

local function pular(event)
    heroiCorrendo.isVisible = false
    heroiPulando.isVisible = true
    heroiPulando:setSequence("pulando")
    heroiPulando:play()
    heroiPulando:applyLinearImpulse( 0, -0.1, heroiPulando.x, heroiPulando.y )

    if ("ended" == event.phase) then
        andar()
    end
end

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
-- faz tudo acontecer
heroiParado:addEventListener("tap",iniciar)
heroiPulando:addEventListener("tap",pular)

    -- #                 #               # --