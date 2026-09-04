require "redis"
require "json"

class CachingService
  def self.redis
    @redis ||= Redis.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"))
  end

  def self.get(key)
    value = redis.get(key)
    value ? JSON.parse(value) : nil
  end

  def self.set(key, value, expiry = 20.minutes)
    redis.set(key, value.to_json, ex: expiry.to_i)
  end

  def self.delete(key)
    redis.del(key)
  end

  def self.fetch(key, expiry = 20.minutes)
    cached = get(key)
    return cached unless cached.nil?

    value = yield
    set(key, value, expiry)
    value
  end
end
