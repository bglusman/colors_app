
class Color

  InvalidColorShade = Class.new(StandardError)
  MAX_SHADE = 255
  MIN_SHADE = 0

  attr_accessor :red, :green, :blue

  def initialize(red: nil, green: nil, blue: nil)
    self.red = red.to_i
    self.green = green.to_i
    self.blue = blue.to_i
    raise InvalidColorShade unless valid_shades?
  end

  def valid_shades?
    valid_shade?(red) && valid_shade?(green) && valid_shade?(blue)
  end

  def valid_shade?(shade)
    (MIN_SHADE..MAX_SHADE).include?(shade)
  end

  def ==(other)
    red == other.red && blue == other.blue && green == other.green
  end

end
