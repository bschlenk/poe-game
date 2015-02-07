#!/usr/bin/env ruby
require "gosu"
require "./grass"

class Poe
    FRAME_WAIT = 4
    def initialize window
        @window = window
        @width = 552 / 3
        @height = 300 / 3
        @image = Gosu::Image.load_tiles @window,
                                       "assets/dogrun_552x300.png",
                                       @width, @height, true

        @x = @window.width/2  - @width/2
        @y = @window.height/2 - @height/2
        # direction and movement
        @direction = :right
        @frame = 0
        @frameWait = FRAME_WAIT
        @moving = false
    end

    def button_down id
    end

    def update
        @frameWait -= 1
        if @frameWait == 0
            @frame += 1
            @frameWait = FRAME_WAIT
        end
        @moving = false
        if @window.button_down? Gosu::KbLeft
            @direction = :left
            @moving = true
            @x += -5
        elsif @window.button_down? Gosu::KbRight
            @direction = :right
            @moving = true
            @x += 5
        end
        if @window.button_down? Gosu::KbUp
            @y -= 5
        elsif @window.button_down? Gosu::KbDown
            @y += 5
        end
    end

    def draw
        f = @frame % @image.size
        image = @image[f]
        if @direction == :right
            image.draw @x, @y, @y
        else
            image.draw @x + @width, @y, @y, -1, 1
        end
    end
end

class Game < Gosu::Window
    BACKGROUND_COLOR = Gosu::Color::GREEN
    def initialize width=800, height=600, fullscreen=false
        super
        self.caption = 'Poe Game'
        @poe = Poe.new self
        @grass = []
    end

    def button_down id
        close if id == Gosu::KbEscape
    end

    def update
        @poe.update
        if Random.rand(20) > 18
            @grass.push(Grass.new(self, Random.rand(self.height)))
        end
        @grass.each { |x| x.update }
        @grass.reject! { |x| x.offscreen? }
    end

    def draw
        @poe.draw
        draw_quad(0, 0, BACKGROUND_COLOR,
                  0, self.height, BACKGROUND_COLOR,
                  self.width, self.height, BACKGROUND_COLOR,
                  self.width, 0, BACKGROUND_COLOR)
        @grass.each { |x| x.draw }
    end
end

game = Game.new
game.show
