if ENV["REDIS_URL"]
  uri = URI.parse(ENV["REDIS_URL"])
  $redis = Redis.new(url: uri)
end
$redis ||= Redis.new
Resque.redis = $redis

ColorGenerator.perform
