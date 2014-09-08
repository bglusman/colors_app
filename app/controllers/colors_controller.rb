class ColorsController < ApplicationController
  def index
  end

  def create
    Rails.logger.info("popping from queue #{RedisQueue.default_queue}")
    color = RedisQueue.dequeue
    Rails.logger.info("popped color #{color} from queue #{RedisQueue.default_queue}")
    render json: color
  end
end
