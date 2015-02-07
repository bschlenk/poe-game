require "gosu"

class Grass
    def initialize window, y
        @window = window
        @x = window.width + 20
        @y = y
        @width = @height = 64
        @image = Gosu::Image.new @window, "assets/grass.png", true
    end

    def update
        @x -= 5
    end

    def draw
        @image.draw @x, @y, @y
    end

    def offscreen?
        return @x < -100
    end

end
