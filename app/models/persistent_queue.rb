require 'base64'
require 'redis'

class PersistentQueue
  attr_reader :name
  DEFAULT_NAME = 'colors'

  def self.dequeue(name: DEFAULT_NAME)
    setup(name)
    @queues[name].dequeue
  end

  def self.enqueue(object, name: DEFAULT_NAME)
    setup(name)
    @queues[name].enqueue(object)
  end

  def self.<<(val)
    self.enqueue(val)
  end

  def self.default_queue
    setup(DEFAULT_NAME)
    @queues[DEFAULT_NAME]
  end

  def self.setup(name)
    @queues       ||= ThreadSafe::Hash.new
    @queues[name] ||= new(name: name)
  end

  def initialize(name: DEFAULT_NAME)
    @name = name
  end

  def enqueue(object)
    redis.rpush(name, encode(object))
  end
  alias :<< :enqueue

  def dequeue
    decode(redis.blpop(name).last)
  end

  def redis
    @redis ||= begin
      if ENV["REDISCLOUD_URL"] && !$redis
        uri = URI.parse(ENV["REDISCLOUD_URL"])
        $redis = Redis.new(url: uri)
      end
      $redis || Redis.new #default port, etc, can pass in options to new if needed
    end
  end

  def encode(object)
    Base64.encode64(Marshal.dump(object))
  end

  def decode(string)
    Marshal.load(Base64.decode64(string))
  end
end