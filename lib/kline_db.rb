# encoding: UTF-8
# frozen_string_literal: true

module KlineDB
  class << self

    def redis
      @redis ||= Redis.new(
        url: ENV["REDIS_URL"],
        password: ENV["REDIS_PASSWORD"],
        db: 1
      )
    end

    def kline(market, period)
      key = "peatio:#{market}:k:#{period}"
      length = redis.llen(key)
      data = redis.lrange(key, length - 5000, -1).map{|str| JSON.parse(str)}
    end

  end
end
