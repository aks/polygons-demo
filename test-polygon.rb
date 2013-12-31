#!/usr/bin/env ruby
# test obj.rb
#
$LOAD_PATH.unshift '.'

require 'polygon'
require 'minitest/autorun'

class TestPolygon < Minitest::Test
  def setup

  end
  def check_methods cls, obj
    assert_instance_of  cls, obj
    assert_respond_to  obj, :area
    assert_respond_to  obj, :size
    assert_respond_to  obj, :circum
    assert_respond_to  obj, :sides
  end
  def check_values obj, params
    params.keys.each{|key|
      case key
      when :area   then assert_equal params[:area],  obj.area
      when :size   then assert_equal params[:size],  obj.size
      when :sizes  then assert_equal params[:sizes],  obj.sizes
      when :circum then assert_equal params[:circum], obj.circum
      when :sides  then assert_equal params[:sides],  obj.sides
      end
    }
  end
  def test_circle
    r = radius = 5
    c1 = Circle.new radius
    assert_instance_of Circle, c1
    check_methods     Circle, c1
    check_values      c1, :area => Math::PI*(radius**2),
                          :size => 5,
                          :circum => 2 * Math::PI*radius,
                          :sides  => 1
  end
  def test_square
    size = 5
    sq1 = Square.new size
    check_methods      Square, sq1
    check_values       sq1, :area   => size * size,
                            :size   => size,
                            :circum => 2 * (size + size),
                            :sides  => 4
  end
  def test_rectangle
    sizes = [10, 5]
    r1 = Rectangle.new *sizes
    check_methods Rectangle, r1
    check_values  r1, :area   => (sizes[0] * sizes[1]),
                      :sizes  => sizes,
                      :circum => 2 * ( sizes[0] + sizes[1] ),
                      :sides  => 4
  end
  def test_triangle
    sizes = [4, 5, 6]
    t1 = Triangle.new *sizes
    check_methods Triangle, t1
    check_values  t1, :area   => (s = (sizes.reduce(:+)/2); Math::sqrt(s*(s-sizes[0])*(s-sizes[1])*(s-sizes[2]))),
                      :sizes  => sizes,
                      :circum => sizes.reduce(:+),
                      :sides  => 3
  end
end

