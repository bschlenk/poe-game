require "gosu"

class Poe < Gosu::Window
    def initialize width=800, height=600, fullscreen=false
        super
        self.caption = 'Poe Game'
    end
end

game = Poe.new
game.show
