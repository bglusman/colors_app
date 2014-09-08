class ColorGenerator
   @queue = :color_generator
  def self.start
    Resque.enqueue(ColorGenerator)
  end

  def self.perform
    PersistentQueue << Color.new(red: rand_shade, blue: rand_shade, green: rand_shade)
    Resque.enqueue_in(3.seconds, ColorGenerator)
  end

  def self.rand_shade(shade_count=256)
    rand(shade_count)
  end


end
