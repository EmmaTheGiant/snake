class Apple
    attr_reader :x, :y, :width, :height, :score
    def initialize()
        @x=rand(0..15)*50
        @y=rand(0..15)*50
        @color=Gosu::Color.argb(0xff_ff0000)
        @width=50
        @height=50
        @score=0
    end
    def test(obj)
        if obj.snake[0].contain(self)
            @x=rand(0..15)*50
            @y=rand(0..15)*50
            obj.add()
            @score+=5*obj.snake.length()
        end
    end
    def draw()
        Gosu.draw_rect(@x,@y,@width,@height,@color)
    end
end