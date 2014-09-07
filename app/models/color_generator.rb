class ColorGenerator
  def self.start
    fork do
      queue = PersistentQueue.new
      while true
        queue << Color.new(red: rand_shade, blue: rand_shade, green: rand_shade)
        sleep 3
      end
    end
  end

  def self.rand_shade(shade_count=256)
    rand(shade_count)
  end

  # alternative generator
  # def self.start
  #   existing_pid = `ps aux | grep 'watch --interval=3 ruby generate_color.r[b]' | awk '{ print $2 }'`
  #   if existing_pid.blank?
  #     IO.open( IO.sysopen("/dev/null", "w+") ) do |io|
  #       pid = spawn('watch --interval=3 ruby generate_color.rb', in: io, out: io, err: io)
  #       Process.detach(pid)
  #       pid
  #     end
  #   else
  #     existing_pid.chop.to_i
  #   end
  # end

end
