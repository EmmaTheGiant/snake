class Head
    #width and height are for collisions
    #the rest are for the devmode
    attr_reader :x, :y, :width, :height, :cur_dir, :dir
    def initialize(x,y)
        @width=50
        @height=50
        @x=x
        @y=y
        @dir=2
        @cur_dir=2
        @color=Gosu::Color.argb(0xff_ff0adf)
    end
    def move(obj)
        if @cur_dir%2==1
            if @y%50==0
                @cur_dir=@dir
                obj.board[y/50][x/50]=@cur_dir
            end
        end
        if @cur_dir%2==0
            if @x%50==0
                @cur_dir=@dir
                obj.board[y/50][x/50]=@cur_dir
            end
        end
        if @cur_dir==1
            @y-=5
        end
        if @cur_dir==2
            @x+=5
        end
        if @cur_dir==3
            @y+=5
        end
        if @cur_dir==4
            @x-=5
        end
    end
    def up()
        if @cur_dir%2==0
            @dir=1
        end
    end
    def right()
        if @cur_dir%2==1
            @dir=2
        end
    end
    def down()
        if @cur_dir%2==0
            @dir=3
        end
    end
    def left()
        if @cur_dir%2==1
            @dir=4
        end
    end
    def contain(obj)
        if @x%50==0&&@y%50==0
            @x<obj.x+obj.width&&@x+@width>obj.x&&@y<obj.y+obj.height&&@y+@height>obj.y
        else
            false
        end
    end
    def draw()
        Gosu.draw_rect(@x,@y,@width,@height,@color)
    end
    def test(obj)
        if @x<0 || @x+@width>800 || @y<0 || @y+@width>800
            obj.die()
        end
    end
end
class Body
    attr_reader :x, :y, :width, :height, :dir
    def initialize(x,y,dir)
        @width=50
        @height=50
        @x=x
        @y=y
        @dir=dir
        @color=Gosu::Color.argb(0xff_ff0adf)
    end
    def move(obj)
        if @dir%2==1
            if @y%50==0
                @dir=obj.board[y/50][x/50]
            end
        end
        if @dir%2==0
            if @x%50==0
                @dir=obj.board[y/50][x/50]
            end
        end
        if @dir==1
            @y-=5
        end
        if @dir==2
            @x+=5
        end
        if @dir==3
            @y+=5
        end
        if @dir==4
            @x-=5
        end
    end
    def test(obj)
        if obj.snake[0].contain(self)
            obj.die()
        end
    end
    def draw()
        Gosu.draw_rect(@x,@y,@width,@height,@color)
    end
end
class Snake
    attr_accessor :snake, :board
    def initialize(x,y)
        @snake=[]
        @board=[]
        @snake.push(Head.new(x,y))
        2.times do |hol|
            @snake.push(Body.new(x-((hol+1)*50),y,2))
        end
        16.times do |y|
            @board.push([])
            16.times do
                @board[y].push(0)
            end
        end
        @board[@snake[1].y/50][@snake[1].x/50]=2
        @board[@snake[2].y/50][@snake[2].x/50]=2
    end
    def add()
        if @snake[-1].dir==1
            @snake.push(Body.new(@snake[-1].x,@snake[-1].y+50,@snake[-1].dir))
        end
        if @snake[-1].dir==2
            @snake.push(Body.new(@snake[-1].x-50,@snake[-1].y,@snake[-1].dir))
        end
        if @snake[-1].dir==3
            @snake.push(Body.new(@snake[-1].x,@snake[-1].y-50,@snake[-1].dir))
        end
        if @snake[-1].dir==4
            @snake.push(Body.new(@snake[-1].x+50,@snake[-1].y,@snake[-1].dir))
        end
    end
    def die()
        @snake=[]
    end
    def move()
        @snake.each do |obj|
            obj.move(self)
        end
    end
    def test()
        @snake.each do |obj|
            if @snake!=[]
                obj.test(self)
            end
        end
    end
    def draw()
        @snake.each do |obj|
            obj.draw()
        end
    end
end   