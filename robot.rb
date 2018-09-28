# class Robot: 
# XEDGE & YEDGE are table width & height ; would be overided by inputting at the beginning
# PLACE, RIGHT, LEFT are Robot's commands ; they're in the CONST for quick changing if need
class Robot

  XEDGE = 10, YEDGE = 10
  PLACE = 'PLACE'
  RIGHT = 'RIGHT'
  LEFT = 'LEFT'

#  @@xedge
#  @@yedge

  attr_accessor :direction, :x, :y

  def initialize(faceto = 'north', x = 0, y = 0)
    @faceto = faceto
    @x = x
    @y = y
  end

  def move
    case @faceto
      when 'NORTH'
        ((@y - 1) >= 0) ? @y -= 1 : (p 'CAREFUL! edge')
      when 'EAST'
        ((@x + 1) <= XEDGE[0]) ? @x += 1 : (p 'CAREFUL! edge')
      when 'SOUTH'
        ((@y + 1) <= XEDGE[0]) ? @y += 1 : (p 'CAREFUL! edge')
      when 'WEST'
        ((@x - 1) >= 0) ? @x -= 1 : (p 'CAREFUL! edge')
    end
  end

  def turn(operation, side)
    dr = ['NORTH', 'EAST', 'SOUTH', 'WEST']
    dr.rotate!(2) if @faceto == side
    @faceto = dr.slice(dr.index(@faceto).send(operation, 1))  
  end

  def place(direction = @faceto, x = @x, y = @y)
    @faceto = direction
    @x = x.to_i
    @y = y.to_i
  end

  def report
    p 'OUTPUT: '<<' '<< @x.to_s << ', ' << @y.to_s << ', ' << @faceto.to_s
  end

  def find_location(str)
    first_cmd = str.split(' ')
    if first_cmd[0] == PLACE 
  	  place(first_cmd[1], first_cmd[2], first_cmd[3])
  	else
  	  rerun false
    end
  end

  def cmds_case(val)
    case val
      when 'MOVE' # possible eval (move)??
        move
      when 'REPORT'
        report
      when 'LEFT'
      	turn(:-, 'NORTH')
      when 'RIGHT'
      	turn(:+, 'WEST')
      end
    end
end

#print "Table width  : "
#@@xedge = gets.chomp.to_i
#print "Table height : "
#@@yedge = gets.chomp.to_i
puts "Robot location with PLACE command."
puts "Other commands are: LEFT RIGHT MOVE."
puts "REPORT command specifies Robot's stop."

cmds = []

begin
  cmds << gets.chomp
end until cmds.last == 'REPORT'

garik = Robot.new

if garik.find_location(cmds.first) 
  cmds.each_with_index { |val, index| 
    if index > 0
      garik.cmds_case(val)
    end
  }
else
  exit
end  
