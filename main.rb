require 'gosu'
require './lib/obj/snake.rb'
require './lib/obj/apple.rb'
class Window < Gosu::Window
    attr_reader :apple, :snake, :length
    def initialize()
        super(800,800)
        @snake=Snake.new(200,100)
        @apple=Apple.new()
        @font=Gosu::Font.new(20)
        @length=3
    end
    def update()
        self.caption="fps:#{Gosu.fps}|snake"
        if Gosu.button_down?(Gosu::KbUp)
            @snake.snake[0].up()
        end
        if Gosu.button_down?(Gosu::KbDown)
            @snake.snake[0].down()
        end
        if Gosu.button_down?(Gosu::KbLeft)
            @snake.snake[0].left()
        end
        if Gosu.button_down?(Gosu::KbRight)
            @snake.snake[0].right()
        end
        @snake.move()
        
        @snake.test()
        if @snake.snake==[]
            self.close
        end
        if @snake.snake != []
            @apple.test(@snake)
        end
        if @snake.snake != []
        @length=@snake.snake.length
        end
    end
    def draw()
        @apple.draw()
        @snake.draw()
        @font.draw_text("score:#{@apple.score}",0,0,9)
    end
end
ui=Window.new()
ui.show
puts "score:#{ui.apple.score}"
puts "length:#{ui.length}"
k=gets