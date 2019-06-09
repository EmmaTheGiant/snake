highscore=0
require 'gosu'
require './lib/obj/snake.rb'
require './lib/obj/apple.rb'
class Window < Gosu::Window
    attr_reader :apple, :snake, :length
    def initialize(key)
        super(800,800)
        @snake=Snake.new(200,100)
        @apple=Apple.new()
        @font=Gosu::Font.new(20)
        @length=3
        if key=="not a backdoor"
            @dev=true
        else
            @dev=false
        end
        @go=false
        @dev_add=true
    end
    def update()
        self.caption="fps:#{Gosu.fps}|snake"
        if @go
        if Gosu.button_down?(Gosu::KbM)==false&&@dev
            @dev_add=true
        end
        if @dev&&Gosu.button_down?(Gosu::KbM)&&@dev_add
            @snake.add()
            @dev_add=false
        end
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
        if Gosu.button_down?(Gosu::KbSpace)
            @go=true
        end
    end
    def draw()
        @apple.draw()
        @snake.draw()
        @font.draw_text("score:#{@apple.score}",0,0,9)
        @font.draw_text("length:#{@snake.snake.length}",400,0,9)
        if @go==false
            @font.draw_text("space to start",400,400,9)
        end
    end
end
puts "press enter to start"
key=gets.chomp
ui=Window.new(key)
ui.show
puts "score:#{ui.apple.score}"
puts "length:#{ui.length}"
k=gets