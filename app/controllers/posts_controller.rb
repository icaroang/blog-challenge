class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    run Post::Operation::Index do |result|
      @posts = result['models']
    end
  end

  def new
    run Post::Operation::Create::New, params, 'current_user': current_user
  end

  def create
    run Post::Operation::Create, posts_params, 'current_user': current_user do
      flash[:success] = 'Postagem criada com sucesso.'
      return redirect_to posts_path
    end

    flash[:info] = 'Não foi possível criar a postagem.'
    render :new
  end

  def edit
    run Post::Operation::Update::Present, params, 'current_user': current_user
  end

  def update
    run Post::Operation::Update, posts_params.merge(params.permit(:id)), 'current_user': current_user do
      flash[:success] = 'Postagem atualizada com sucesso.'
      return redirect_to post_path(@model)
    end

    flash[:info] = 'Não foi possível atualizar a postagem.'
    render :edit
  end

  def show
    run Post::Operation::Show, params do
      return render :show
    end

    flash[:info] = 'Não foi possível visualizar esta postagem.'
    redirect_to posts_path
  end

  private

  def posts_params
    params.require(:post).permit(:title, :markdown_body)
  end
end
