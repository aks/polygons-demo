# polygon.rb

include Math

TAU = PI * 2

class Polygon

  # o = Polygon.new :KIND, PARAMS
  # o.kind
  # o.area
  # o.circum
  # o.sides
  # o.sizes or o.size

  attr :sizes, :sides
  def initialize kind, params           # num_sides, area_calc, circum_calc, *sizes
    @kind        = kind
    @sides       = params[:sides]  if params.key?(:sides)
    @area_calc   = params[:area]   if params.key?(:area)   # computes area - should be a lambda of "num_sides" variables
    @circum_calc = params[:circum] if params.key?(:circum) # computes circumference - another lambda of "num_sides" variables
    @sizes       = params[:sizes]  if params.key?(:sizes)
    @sizes       = params[:size]   if params.key?(:size)
    @sizes     ||= [nil]
    self
  end
  def area
    @area_calc.call(*@sizes)
  end
  def circumference
    @circum_calc.call(*@sizes)
  end
  alias circum circumference
  # size attribute is really an alias for sizes, but enforcing single number
  def size= num
    @sizes = [num]
  end
  def size
    @sizes.first
  end
end

class Rectangle < Polygon
  def initialize *sizes
    super :Rectangle, {
          :sides  => 4,
          :area   => lambda {|a,b| a*b},
          :circum => lambda {|a,b| 2*(a+b)},
          :sizes  => sizes[0,2]
          }
  end
end

class Square < Polygon
  def initialize size
    super :Square, {
          :sides  => 4,
          :area   => lambda {|a| a*a},
          :circum => lambda {|a| 4*a},
          :size   => [size]
          }
  end
end

class Triangle < Polygon
  def initialize *sizes
    super :Triangle, {
          :sides  => 3,
          :area   => lambda {|a,b,c| s = (a + b + c) / 2 ; sqrt(s*(s-a)*(s-b)*(s-c)) },
          :circum => lambda {|a,b,c| a+b+c},
          :sizes  => sizes[0,3]
          }
  end
end

class Circle < Polygon
  def initialize size
    super :Circle, {
          :sides   => 1,
          :area    => lambda{|r| PI*(r**2) },
          :circum  => lambda{|r| 2*PI*r },
          :size    => [size]
          }
  end
end

# end of Polygon.rb
# vim:ai:sw=2
