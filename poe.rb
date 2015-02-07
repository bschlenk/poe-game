#!/usr/bin/env ruby
require "gosu"

class Poe < Gosu::Window
    def initialize width=800, height=600, fullscreen=false
        super
        self.caption = 'Poe Game'
    end

    def button_down id
        close if id == Gosu::KbEscape
    end

    def update
    end

    def draw
    end
end

game = Poe.new
game.show
