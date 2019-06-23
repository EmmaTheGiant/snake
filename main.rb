require 'gosu'
require './lib/obj/snake.rb'
require './lib/obj/apple.rb'
class Window < Gosu::Window
    attr_reader :apple, :snake, :length, :highscore, :dev
    def initialize(key,highscore)
        super(800,800)
        @apple=Apple.new()
        @font=Gosu::Font.new(20)
        @song=Gosu::Song.new("./lib/snd/song.mp3")
        @length=3
        if key=="not a backdoor"
            @dev=true
        else
            @dev=false
        end
        if @dev
            @snake=Snake.new(0,0)
        else
            @snake=Snake.new(200,100)
        end
        @go=false
        @dev_add=true
        @highscore=highscore
        @song.play(looping=true)
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
        @font.draw_text("highscore:#{@highscore[0]}",0,20,9)
        @font.draw_text("highlength:#{@highscore[1]}",400,20,9)

        if @go==false
            @font.draw_text("space to start",400,400,9)
        end
        if @dev
            @font.draw_text("Apple X:#{@apple.x}",0,40,9)
            @font.draw_text("Apple Y:#{@apple.y}",0,60,9)
        end
    end
end
highscore=[]
File.readlines("./lib/score.txt").each do |num|
    highscore.push(num.chomp.to_i)
end
puts "press enter to start"
key=gets.chomp
ui=Window.new(key,highscore)
ui.show
puts "score"
puts ui.apple.score
puts ui.length
puts "highscore"
puts highscore[0]
puts highscore[1]
if ui.apple.score>highscore[0]&&ui.dev==false
    file=File.open("./lib/score.txt",'w')
    file.puts(ui.apple.score)
    file.write(ui.length)
    file.close
    puts "new highscore"
elsif ui.apple.score>highscore[0]&&ui.dev
    puts "[info] cant add to highscore because of devmode"
end
k=gets