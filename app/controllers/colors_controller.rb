class ColorsController < ApplicationController
  def index
  end

  def create
    #modifies state of server, so using a POST action
    render json: PersistentQueue.dequeue
  end
end
