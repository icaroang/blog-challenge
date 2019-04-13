class PostsController < ApplicationController
  def index
    run Post::Operation::Index do |result|
      @posts = result['models']
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end
end
