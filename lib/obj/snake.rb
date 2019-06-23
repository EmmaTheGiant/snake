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
        @color=Gosu::Color.argb(0xff_00af00)
    end
    def move(obj)
        #if the snake is moving in the y direction
        if @cur_dir%2==1
            #and filling a cell
            if @y%50==0
                #apply the direction change
                @cur_dir=@dir
                #and put it on the board for the tail to follow
                obj.board[y/50][x/50]=@cur_dir
            end
        end
        #same deal, but in the x direction
        if @cur_dir%2==0
            if @x%50==0
                @cur_dir=@dir
                obj.board[y/50][x/50]=@cur_dir
            end
        end
        #actually move the head
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
    #all of these are the change direction commands
    def up()
        #this makes sure it cant turn back on itself
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
    #collision code
    def contain(obj)
        #makes sure the head is filling a "cell"
        if @x%50==0&&@y%50==0
            #then it checks if the two objects are in the same cell
            @x==obj.x&&@y==obj.y
        else
            #this is so the game doesnt crash if the head is between cells
            false
        end
    end
    def draw()
        Gosu.draw_rect(@x,@y,@width,@height,@color)
    end
    def test(obj)
        #this is checking if the head is out of the play area
        if @x<0 || @x+@width>800 || @y<0 || @y+@width>800
            obj.die()
        end
    end
end
class Body
    attr_reader :x, :y, :width, :height, :dir
    #i need to include the direction in the code so it can start moving in any direction
    #when length is added, the direction the tail will be moving in will depend on the direction of the previous tail
    #i also put the obj(snake) in here so i can add the direction to the board
    def initialize(x,y,dir,obj)
        @width=50
        @height=50
        @x=x
        @y=y
        @dir=dir
        @color=Gosu::Color.argb(0xff_00af00)
        obj.board[y/50][x/50]=@dir
    end
    #basically the same move code as the head, but the direction changes based on the board
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
    #this is testing to see if the head (always @snake.snake[0]) contains the body
    def test(obj)
        if obj.snake[0].contain(self)
            #if it dies, the snake dies
            obj.die()
        end
    end
    def draw()
        Gosu.draw_rect(@x,@y,@width,@height,@color)
    end
end
class Snake
    #@snake and @board need to be both read and wrote to for reasons explained above
    attr_accessor :snake, :board
    def initialize(x,y)
        @snake=[]
        @board=[]
        @snake.push(Head.new(x,y))
        #i create the board first
        16.times do |y|
            @board.push([])
            16.times do
                @board[y].push(0)
            end
        end
        #so that the game doesnt crash when i create the initial body
        2.times do |hol|
            @snake.push(Body.new(x-((hol+1)*50),y,2,self))
        end
        #this is kind of pointless to have here, its what i did before the body automatically added to the board
        @board[@snake[1].y/50][@snake[1].x/50]=2
        @board[@snake[2].y/50][@snake[2].x/50]=2
    end
    def add()
        #this is the 4 different add cases for the 4 different directions
        if @snake[-1].dir==1
            @snake.push(Body.new(@snake[-1].x,@snake[-1].y+50,@snake[-1].dir,self))
        end
        if @snake[-1].dir==2
            @snake.push(Body.new(@snake[-1].x-50,@snake[-1].y,@snake[-1].dir,self))
        end
        if @snake[-1].dir==3
            @snake.push(Body.new(@snake[-1].x,@snake[-1].y-50,@snake[-1].dir,self))
        end
        if @snake[-1].dir==4
            @snake.push(Body.new(@snake[-1].x+50,@snake[-1].y,@snake[-1].dir,self))
        end
    end
    #kills the snake
    def die()
        @snake=[]
    end
    #this moves the whole body of the snake
    def move()
        #it moves each part
        @snake.each do |obj|
            obj.move(self)
        end
        #this sets the board space behind the tail to 0
        if @snake[-1].dir%2==0
            if @snake[-1].x%50==0
                if @snake[-1].dir==2
                    @board[@snake[-1].y/50][(@snake[-1].x/50)-1]=0
                else
                    @board[@snake[-1].y/50][(@snake[-1].x/50)+1]=0
                end
            end
        else
            if @snake[-1].y%50==0
                if @snake[-1].dir==3
                    @board[(@snake[-1].y/50)-1][@snake[-1].x/50]=0
                else
                    @board[(@snake[-1].y/50)+1][@snake[-1].x/50]=0
                end
            end
        end              
    end
    def test()
        #tests the whole snake
        @snake.each do |obj|
            if @snake!=[]
                obj.test(self)
            end
        end
    end
    def draw()
        #draws the whole snake
        @snake.each do |obj|
            obj.draw()
        end
    end
end