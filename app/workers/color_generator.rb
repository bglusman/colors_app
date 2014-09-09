class ColorGenerator
   @queue = :color_generator

  def self.perform
    PersistentQueue << Color.new(red: rand_shade, blue: rand_shade, green: rand_shade)
    sleep 3
    Resque.enqueue(ColorGenerator)
  end

  def self.rand_shade(shade_count=256)
    rand(shade_count)
  end


end
