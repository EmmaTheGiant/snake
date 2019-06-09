class Apple
    attr_reader :x, :y, :width, :height, :score
    def initialize()
        @x=rand(0..15)*50
        @y=rand(0..15)*50
        @color=Gosu::Color.argb(0xff_ff0000)
        @width=50
        @height=50
        @score=0
        @go=true
    end
    def test(obj)
        if obj.snake[0].contain(self)
            @go=true
            while @go
                @x=rand(0..15)*50
                @y=rand(0..15)*50
                if obj.board[@y/50][@x/50]==0
                    @go=false
                end
            end
            obj.add()
            @score+=5*obj.snake.length()
        end
    end
    def draw()
        Gosu.draw_rect(@x,@y,@width,@height,@color)
    end
end