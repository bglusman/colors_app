require 'base64'
require 'redis'

class PersistentQueue
  attr_reader :name
  DEFAULT_NAME    = 'colors'
  DEFAULT_TIMEOUT = 3

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

  def dequeue(timeout=DEFAULT_TIMEOUT)
    decode(redis.blpop(name, timeout).try(:last))
  end

  def redis
    $redis
  end

  def encode(object)
    Base64.encode64(Marshal.dump(object))
  end

  def decode(string)
    Marshal.load(Base64.decode64(string))
  end
end